// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vlua_cpu.h for the primary calling header

#ifndef VERILATED_VLUA_CPU___024ROOT_H_
#define VERILATED_VLUA_CPU___024ROOT_H_  // guard

#include "verilated.h"

class Vlua_cpu__Syms;
class Vlua_cpu_lua_cpu;

VL_MODULE(Vlua_cpu___024root) {
  public:
    // CELLS
    Vlua_cpu_lua_cpu* __PVT__lua_cpu;

    // DESIGN SPECIFIC STATE
    VL_IN8(nios_lua_exec_slave_clk,0,0);
    VL_IN8(nios_lua_exec_slave_clk_en,0,0);
    VL_IN8(nios_lua_exec_slave_start,0,0);
    VL_OUT8(nios_lua_exec_slave_done,0,0);
    VL_IN8(nios_lua_exec_slave_a,4,0);
    VL_IN8(nios_lua_exec_slave_b,4,0);
    VL_IN8(nios_lua_exec_slave_c,4,0);
    VL_IN8(nios_lua_exec_slave_n,1,0);
    VL_IN8(nios_lua_exec_slave_readra,0,0);
    VL_IN8(nios_lua_exec_slave_readrb,0,0);
    VL_IN8(nios_lua_exec_slave_reset,0,0);
    VL_IN8(nios_lua_exec_slave_writerc,0,0);
    VL_OUT8(avalon_master_read,0,0);
    VL_OUT8(avalon_master_write,0,0);
    VL_IN8(avalon_master_waitrequest,0,0);
    VL_IN8(clock_sink_clk,0,0);
    VL_IN8(reset_sink_reset,0,0);
    CData/*0:0*/ __VinpClk__TOP__lua_cpu____PVT__main_rst;
    CData/*0:0*/ __Vclklast__TOP__lua_cpu____PVT__main_clk;
    CData/*0:0*/ __Vclklast__TOP____VinpClk__TOP__lua_cpu____PVT__main_rst;
    CData/*0:0*/ __Vchglast__TOP__lua_cpu__main_rst;
    VL_IN(nios_lua_exec_slave_dataa,31,0);
    VL_IN(nios_lua_exec_slave_datab,31,0);
    VL_OUT(nios_lua_exec_slave_result,31,0);
    VL_OUT(avalon_master_address,31,0);
    VL_IN(avalon_master_readdata,31,0);
    VL_OUT(avalon_master_writedata,31,0);
    VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;

    // INTERNAL VARIABLES
    Vlua_cpu__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
    Vlua_cpu___024root(const char* name);
    ~Vlua_cpu___024root();
    VL_UNCOPYABLE(Vlua_cpu___024root);

    // INTERNAL METHODS
    void __Vconfigure(Vlua_cpu__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
