#include "cpusim.h"

class SDRAMController
{
public:
    uint32_t address;
    uint32_t readdata;
    uint32_t writedata;
    uint8_t write;
    uint8_t read;
    uint8_t waitrequest;


};

Vlua_cpu cpu;
SDRAMController sdram;

void luacpu_init(int argc, char** argv)
{
    Verilated::commandArgs(argc, argv);
    
}

Instruction luacpu_simulate(lua_State* L, CallInfo* ci)
{
    std::cout<<"test"<<std::endl;
    return 0;    
}
