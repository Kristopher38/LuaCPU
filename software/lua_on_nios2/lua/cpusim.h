#include <iostream>
#include <queue>
#include <verilated.h>

#include "obj_dir/Vlua_cpu.h"
#include "verilated_vcd_c.h"
#include "lstate.h"

extern Instruction luacpu_simulate(lua_State* L, CallInfo* ci);
extern void luacpu_reset();
extern void luacpu_init(int argc, char** argv);
extern void luacpu_deinit();