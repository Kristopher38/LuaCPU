// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vlua_cpu.h"
#include "Vlua_cpu__Syms.h"

//============================================================
// Constructors

Vlua_cpu::Vlua_cpu(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new Vlua_cpu__Syms(_vcontextp__, _vcname__, this)}
    , clock_sink_clk{vlSymsp->TOP.clock_sink_clk}
    , reset_sink_reset{vlSymsp->TOP.reset_sink_reset}
    , nios_lua_exec_slave_clk{vlSymsp->TOP.nios_lua_exec_slave_clk}
    , nios_lua_exec_slave_clk_en{vlSymsp->TOP.nios_lua_exec_slave_clk_en}
    , nios_lua_exec_slave_start{vlSymsp->TOP.nios_lua_exec_slave_start}
    , nios_lua_exec_slave_done{vlSymsp->TOP.nios_lua_exec_slave_done}
    , nios_lua_exec_slave_a{vlSymsp->TOP.nios_lua_exec_slave_a}
    , nios_lua_exec_slave_b{vlSymsp->TOP.nios_lua_exec_slave_b}
    , nios_lua_exec_slave_c{vlSymsp->TOP.nios_lua_exec_slave_c}
    , nios_lua_exec_slave_n{vlSymsp->TOP.nios_lua_exec_slave_n}
    , nios_lua_exec_slave_readra{vlSymsp->TOP.nios_lua_exec_slave_readra}
    , nios_lua_exec_slave_readrb{vlSymsp->TOP.nios_lua_exec_slave_readrb}
    , nios_lua_exec_slave_reset{vlSymsp->TOP.nios_lua_exec_slave_reset}
    , nios_lua_exec_slave_writerc{vlSymsp->TOP.nios_lua_exec_slave_writerc}
    , avalon_master_read{vlSymsp->TOP.avalon_master_read}
    , avalon_master_write{vlSymsp->TOP.avalon_master_write}
    , avalon_master_waitrequest{vlSymsp->TOP.avalon_master_waitrequest}
    , nios_lua_exec_slave_dataa{vlSymsp->TOP.nios_lua_exec_slave_dataa}
    , nios_lua_exec_slave_datab{vlSymsp->TOP.nios_lua_exec_slave_datab}
    , nios_lua_exec_slave_result{vlSymsp->TOP.nios_lua_exec_slave_result}
    , avalon_master_address{vlSymsp->TOP.avalon_master_address}
    , avalon_master_readdata{vlSymsp->TOP.avalon_master_readdata}
    , avalon_master_writedata{vlSymsp->TOP.avalon_master_writedata}
    , rootp{&(vlSymsp->TOP)}
{
}

Vlua_cpu::Vlua_cpu(const char* _vcname__)
    : Vlua_cpu(nullptr, _vcname__)
{
}

//============================================================
// Destructor

Vlua_cpu::~Vlua_cpu() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void Vlua_cpu___024root___eval_initial(Vlua_cpu___024root* vlSelf);
void Vlua_cpu___024root___eval_settle(Vlua_cpu___024root* vlSelf);
void Vlua_cpu___024root___eval(Vlua_cpu___024root* vlSelf);
#ifdef VL_DEBUG
void Vlua_cpu___024root___eval_debug_assertions(Vlua_cpu___024root* vlSelf);
#endif  // VL_DEBUG
void Vlua_cpu___024root___final(Vlua_cpu___024root* vlSelf);

static void _eval_initial_loop(Vlua_cpu__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    Vlua_cpu___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        Vlua_cpu___024root___eval_settle(&(vlSymsp->TOP));
        Vlua_cpu___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void Vlua_cpu::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vlua_cpu::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vlua_cpu___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        Vlua_cpu___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

VerilatedContext* Vlua_cpu::contextp() const {
    return vlSymsp->_vm_contextp__;
}

const char* Vlua_cpu::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void Vlua_cpu::final() {
    Vlua_cpu___024root___final(&(vlSymsp->TOP));
}
