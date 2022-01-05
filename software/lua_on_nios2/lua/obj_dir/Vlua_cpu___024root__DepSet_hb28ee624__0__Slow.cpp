// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlua_cpu.h for the primary calling header

#include "verilated.h"

#include "Vlua_cpu___024root.h"

VL_ATTR_COLD void Vlua_cpu___024root___final(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___final\n"); );
}

VL_ATTR_COLD void Vlua_cpu___024root___ctor_var_reset(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->nios_lua_exec_slave_dataa = VL_RAND_RESET_I(32);
    vlSelf->nios_lua_exec_slave_datab = VL_RAND_RESET_I(32);
    vlSelf->nios_lua_exec_slave_result = VL_RAND_RESET_I(32);
    vlSelf->nios_lua_exec_slave_clk = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_clk_en = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_start = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_done = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_a = VL_RAND_RESET_I(5);
    vlSelf->nios_lua_exec_slave_b = VL_RAND_RESET_I(5);
    vlSelf->nios_lua_exec_slave_c = VL_RAND_RESET_I(5);
    vlSelf->nios_lua_exec_slave_n = VL_RAND_RESET_I(2);
    vlSelf->nios_lua_exec_slave_readra = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_readrb = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_reset = VL_RAND_RESET_I(1);
    vlSelf->nios_lua_exec_slave_writerc = VL_RAND_RESET_I(1);
    vlSelf->avalon_master_address = VL_RAND_RESET_I(32);
    vlSelf->avalon_master_readdata = VL_RAND_RESET_I(32);
    vlSelf->avalon_master_writedata = VL_RAND_RESET_I(32);
    vlSelf->avalon_master_read = VL_RAND_RESET_I(1);
    vlSelf->avalon_master_write = VL_RAND_RESET_I(1);
    vlSelf->avalon_master_waitrequest = VL_RAND_RESET_I(1);
    vlSelf->clock_sink_clk = VL_RAND_RESET_I(1);
    vlSelf->reset_sink_reset = VL_RAND_RESET_I(1);
    vlSelf->__VinpClk__TOP__lua_cpu____PVT__main_rst = VL_RAND_RESET_I(1);
    vlSelf->__Vchglast__TOP__lua_cpu__main_rst = VL_RAND_RESET_I(1);
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }
}
