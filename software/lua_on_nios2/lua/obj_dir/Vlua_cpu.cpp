// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vlua_cpu.h"
#include "Vlua_cpu__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vlua_cpu::Vlua_cpu(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new Vlua_cpu__Syms(_vcontextp__, _vcname__, this)}
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
    , clock_sink_clk{vlSymsp->TOP.clock_sink_clk}
    , reset_sink_reset{vlSymsp->TOP.reset_sink_reset}
    , nios_lua_exec_slave_dataa{vlSymsp->TOP.nios_lua_exec_slave_dataa}
    , nios_lua_exec_slave_datab{vlSymsp->TOP.nios_lua_exec_slave_datab}
    , nios_lua_exec_slave_result{vlSymsp->TOP.nios_lua_exec_slave_result}
    , avalon_master_address{vlSymsp->TOP.avalon_master_address}
    , avalon_master_readdata{vlSymsp->TOP.avalon_master_readdata}
    , avalon_master_writedata{vlSymsp->TOP.avalon_master_writedata}
    , __PVT__lua_cpu{vlSymsp->TOP.__PVT__lua_cpu}
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
QData Vlua_cpu___024root___change_request(Vlua_cpu___024root* vlSelf);
#ifdef VL_DEBUG
void Vlua_cpu___024root___eval_debug_assertions(Vlua_cpu___024root* vlSelf);
#endif  // VL_DEBUG
void Vlua_cpu___024root___final(Vlua_cpu___024root* vlSelf);

static void _eval_initial_loop(Vlua_cpu__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    Vlua_cpu___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        Vlua_cpu___024root___eval_settle(&(vlSymsp->TOP));
        Vlua_cpu___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = Vlua_cpu___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("../../../hardware/lua_cpu.v", 4, "",
                "Verilated model didn't DC converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = Vlua_cpu___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
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
    int __VclockLoop = 0;
    QData __Vchange = 1;
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        Vlua_cpu___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = Vlua_cpu___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("../../../hardware/lua_cpu.v", 4, "",
                "Verilated model didn't converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = Vlua_cpu___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
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

//============================================================
// Trace configuration

void Vlua_cpu___024root__trace_init_top(Vlua_cpu___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vlua_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vlua_cpu___024root*>(voidSelf);
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    Vlua_cpu___024root__trace_init_top(vlSelf, tracep);
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void Vlua_cpu___024root__trace_register(Vlua_cpu___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vlua_cpu::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vlua_cpu___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
