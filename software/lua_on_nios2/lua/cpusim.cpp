#include "cpusim.h"

int32_t gTick = 0;

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
    bool ignoreNextRequest = true;
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
        pendingRequests.push(Request{address, writedata, isWrite, gTick, requestDelayFull});
    }

    void serviceRequest()
    {
        if (pendingRequests.size() > 0)
        {
            Request r = pendingRequests.front();
            if (r.issuedTick + r.delay <= gTick)
            {
                waitrequest = 0;
                int32_t* ptr = reinterpret_cast<int32_t*>(r.address);
                if (r.isWrite)
                    *ptr = r.writedata;
                else
                    readdata = *ptr;
                pendingRequests.pop();
                ignoreNextRequest = true;
            }
        }
    }

    void clock()
    {
        waitrequest = 1;
        if ((read || write) && pendingRequests.size() == 0 && !ignoreNextRequest)
            this->queueRequest(address, write, writedata);
        else
            ignoreNextRequest = false;
        this->serviceRequest();
    }
};

Vlua_cpu* cpu;
SDRAMController* sdram;
VerilatedVcdC* tfp;

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

Instruction luacpu_simulate(lua_State* L, CallInfo* ci)
{
    cpu->nios_lua_exec_slave_start = 1;
    cpu->nios_lua_exec_slave_clk_en = 1;
    cpu->clock_sink_clk = 0;
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
