// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlua_cpu.h for the primary calling header

#include "verilated.h"

#include "Vlua_cpu___024root.h"

QData Vlua_cpu___024root___change_request_1(Vlua_cpu___024root* vlSelf);

VL_INLINE_OPT QData Vlua_cpu___024root___change_request(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___change_request\n"); );
    // Body
    return (Vlua_cpu___024root___change_request_1(vlSelf));
}

#ifdef VL_DEBUG
void Vlua_cpu___024root___eval_debug_assertions(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_clk 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_clk");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_clk_en 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_clk_en");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_start 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_start");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_a 
                     & 0xe0U))) {
        Verilated::overWidthError("nios_lua_exec_slave_a");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_b 
                     & 0xe0U))) {
        Verilated::overWidthError("nios_lua_exec_slave_b");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_c 
                     & 0xe0U))) {
        Verilated::overWidthError("nios_lua_exec_slave_c");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_n 
                     & 0xfcU))) {
        Verilated::overWidthError("nios_lua_exec_slave_n");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_readra 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_readra");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_readrb 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_readrb");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_reset 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_reset");}
    if (VL_UNLIKELY((vlSelf->nios_lua_exec_slave_writerc 
                     & 0xfeU))) {
        Verilated::overWidthError("nios_lua_exec_slave_writerc");}
    if (VL_UNLIKELY((vlSelf->avalon_master_waitrequest 
                     & 0xfeU))) {
        Verilated::overWidthError("avalon_master_waitrequest");}
    if (VL_UNLIKELY((vlSelf->clock_sink_clk & 0xfeU))) {
        Verilated::overWidthError("clock_sink_clk");}
    if (VL_UNLIKELY((vlSelf->reset_sink_reset & 0xfeU))) {
        Verilated::overWidthError("reset_sink_reset");}
}
#endif  // VL_DEBUG
