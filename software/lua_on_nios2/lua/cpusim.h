#include <iostream>
#include <verilated.h>

#include "obj_dir/Vlua_cpu.h"
#include "lstate.h"

extern Instruction luacpu_simulate(lua_State* L, CallInfo* ci);
