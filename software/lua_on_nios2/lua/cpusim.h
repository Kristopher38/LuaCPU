#ifndef h_cpusim
#define h_cpusim

#include <iostream>
#include <queue>
#include <verilated.h>

#include "obj_dir/Vlua_cpu.h"
#include "verilated_vcd_c.h"

class SDRAMController;

extern Vlua_cpu* cpu;
extern SDRAMController* sdram;
extern VerilatedVcdC* tfp;

extern uint32_t luacpu_simulate(void* L, void* ci);
extern void luacpu_reset();
extern void luacpu_init(int argc, char** argv);
extern void luacpu_deinit();

void clk_half(int dir);
void clk_up();
void clk_down();
void clk();
void instr_begin(int n);
void luacpu_storett(void* regbase, int tt);
void luacpu_storebase(void* base);

template <typename T>
void luacpu_storeval(void* regbase, T val)
{
    instr_begin(1);
    cpu->nios_lua_exec_slave_dataa = reinterpret_cast<uint32_t>(regbase);
    
    // gcc won't let me use reinterpret cast on all types:
    // cpu->nios_lua_exec_slave_datab = reinterpret_cast<uint32_t>(val);
    __asm__("" : "=r" (cpu->nios_lua_exec_slave_datab) : "0" (val));
    clk();
    cpu->nios_lua_exec_slave_start = 0;

    while (!cpu->nios_lua_exec_slave_done)
        clk();
}

#endif