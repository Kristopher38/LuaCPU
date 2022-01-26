#include "cpusim.h"

int32_t gTick = 0;
Vlua_cpu* cpu;
SDRAMController* sdram;
VerilatedVcdC* tfp;

struct Request
{
    uint32_t address;
    uint32_t writedata;
    uint8_t isWrite;
    int32_t issuedTick;
    int32_t delay;
};

class SDRAMController
{
private:
    std::queue<Request> pendingRequests;
    const int32_t requestDelayFull = 3;
    bool canService = true;
public:
    uint32_t address;
    uint32_t readdata;
    uint32_t writedata;
    uint8_t write;
    uint8_t read;
    uint8_t waitrequest;

    SDRAMController() : address(0), readdata(0), writedata(0), write(0), read(0), waitrequest(1)
    {}

    void queueRequest(uint32_t address, bool isWrite, uint32_t writedata)
    {
        canService = false;
        pendingRequests.push(Request{address, writedata, isWrite, gTick, requestDelayFull});
    }

    void serviceRequest()
    {
        if (pendingRequests.size() > 0)
        {
            Request r = pendingRequests.front();
            if (r.issuedTick + r.delay == gTick)
            {
                // first read data is put on the bus before waitrequest is deasserted
                // (contrary to what the avalon specs say)
                int32_t* ptr = reinterpret_cast<int32_t*>(r.address);
                if (r.isWrite)
                    *ptr = r.writedata;
                else
                    readdata = *ptr;
            }
            if (r.issuedTick + r.delay + 1 == gTick)
                waitrequest = 0;
            if (r.issuedTick + r.delay + 2 == gTick)
            {
                // transfer done one cycle after waitrequest is deasserted,
                // then we can start servicing next request
                canService = true;
                pendingRequests.pop();
            }
        }
    }

    void clock()
    {
        waitrequest = 1;
        if ((read || write) && canService)
            this->queueRequest(address, write, writedata);
        this->serviceRequest();
    }
};

void luacpu_reset()
{
    cpu->clock_sink_clk = 0;
    cpu->nios_lua_exec_slave_reset = 1;
    cpu->reset_sink_reset = 1;
    cpu->eval();
    cpu->nios_lua_exec_slave_reset = 0;
    cpu->reset_sink_reset = 0;
    cpu->eval();
}

void luacpu_init(int argc, char** argv)
{
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    cpu = new Vlua_cpu;
    sdram = new SDRAMController;
    tfp = new VerilatedVcdC;
    cpu->trace(tfp, 99);
    tfp->open("dump.vcd");

    luacpu_reset();
    gTick = 0;
}

void luacpu_deinit()
{
    delete cpu;
    delete sdram;
    tfp->close();
    delete tfp;
}

inline void clk_half(int dir = -1)
{
    cpu->clock_sink_clk = dir < 0 ? (cpu->clock_sink_clk == 0 ? 1 : 0) : dir;
    Verilated::timeInc(1);
    cpu->eval();
    tfp->dump(Verilated::time());
}

inline void clk_up()
{
    clk_half(1);
}

inline void clk_down()
{
    clk_half(0);
}

inline void clk()
{
    clk_half();
    clk_half();
}

void instr_begin(int n)
{
    cpu->avalon_master_waitrequest = 1;
    cpu->nios_lua_exec_slave_start = 1;
    cpu->nios_lua_exec_slave_clk_en = 1;
    cpu->clock_sink_clk = 0;
    cpu->nios_lua_exec_slave_n = n;
}

void luacpu_storett(void* regbase, int tt)
{
    instr_begin(2);
    cpu->nios_lua_exec_slave_dataa = reinterpret_cast<uint32_t>(regbase);
    cpu->nios_lua_exec_slave_datab = static_cast<uint32_t>(tt);
    clk();

    while (!cpu->nios_lua_exec_slave_done)
        clk();
}

void luacpu_storebase(void* base)
{
    instr_begin(3);
    cpu->nios_lua_exec_slave_dataa = reinterpret_cast<uint32_t>(base);
    clk();

    while(!cpu->nios_lua_exec_slave_done)
        clk();
}

uint32_t luacpu_simulate(void* L, void* ci)
{
    instr_begin(0);
    cpu->nios_lua_exec_slave_dataa = reinterpret_cast<uint32_t>(L);
    cpu->nios_lua_exec_slave_datab = reinterpret_cast<uint32_t>(ci);
    clk();

    while (!cpu->nios_lua_exec_slave_done)
    {
        sdram->address = cpu->avalon_master_address;
        sdram->writedata = cpu->avalon_master_writedata;
        sdram->write = cpu->avalon_master_write;
        sdram->read = cpu->avalon_master_read;
        sdram->clock();
        
        cpu->avalon_master_waitrequest = sdram->waitrequest;
        cpu->avalon_master_readdata = sdram->readdata;
        cpu->nios_lua_exec_slave_start = 0;
        clk();
        gTick++;
    }
    tfp->flush();
    return cpu->nios_lua_exec_slave_result;
}
