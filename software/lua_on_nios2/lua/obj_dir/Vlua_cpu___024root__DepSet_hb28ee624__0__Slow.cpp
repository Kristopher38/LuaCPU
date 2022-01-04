// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlua_cpu.h for the primary calling header

#include "verilated.h"

#include "Vlua_cpu___024root.h"

VL_ATTR_COLD void Vlua_cpu___024root___settle__TOP__2(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___settle__TOP__2\n"); );
    // Init
    CData/*0:0*/ lua_cpu__DOT__nios_done;
    CData/*0:0*/ lua_cpu__DOT__mem_r;
    CData/*0:0*/ lua_cpu__DOT__mem_w;
    IData/*31:0*/ lua_cpu__DOT__nios_result;
    IData/*31:0*/ lua_cpu__DOT__mem_addr;
    IData/*31:0*/ lua_cpu__DOT__mem_wdata;
    IData/*31:0*/ lua_cpu__DOT__ci_u_l_p;
    // Body
    lua_cpu__DOT__ci_u_l_p = ((IData)(0x10U) + vlSelf->nios_lua_exec_slave_datab);
    vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p = ((IData)(4U) 
                                              + lua_cpu__DOT__ci_u_l_p);
    lua_cpu__DOT__nios_done = 0U;
    if ((8U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
        if ((4U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
            if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    lua_cpu__DOT__nios_done = 1U;
                }
            }
        }
    }
    lua_cpu__DOT__mem_w = 0U;
    if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                  >> 3U)))) {
        if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                      >> 2U)))) {
            if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    lua_cpu__DOT__mem_w = 1U;
                }
                lua_cpu__DOT__mem_r = 0U;
                if ((1U & (~ (IData)(vlSelf->lua_cpu__DOT__ex_state)))) {
                    lua_cpu__DOT__mem_r = 1U;
                }
            } else {
                lua_cpu__DOT__mem_r = 0U;
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    lua_cpu__DOT__mem_r = 1U;
                }
            }
        } else {
            lua_cpu__DOT__mem_r = 0U;
        }
    } else {
        lua_cpu__DOT__mem_r = 0U;
    }
    lua_cpu__DOT__nios_result = 0U;
    if ((8U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
        if ((4U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
            if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    lua_cpu__DOT__nios_result = vlSelf->lua_cpu__DOT__instruction;
                }
            }
        }
    }
    lua_cpu__DOT__mem_wdata = 0U;
    if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                  >> 3U)))) {
        if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                      >> 2U)))) {
            if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    lua_cpu__DOT__mem_wdata = ((IData)(4U) 
                                               + vlSelf->lua_cpu__DOT__ci_u_l_savedpc_v);
                    lua_cpu__DOT__mem_addr = 0U;
                    lua_cpu__DOT__mem_addr = vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p;
                } else {
                    lua_cpu__DOT__mem_addr = 0U;
                    lua_cpu__DOT__mem_addr = vlSelf->lua_cpu__DOT__ci_u_l_savedpc_v;
                }
            } else {
                lua_cpu__DOT__mem_addr = 0U;
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    lua_cpu__DOT__mem_addr = vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p;
                }
            }
        } else {
            lua_cpu__DOT__mem_addr = 0U;
        }
    } else {
        lua_cpu__DOT__mem_addr = 0U;
    }
    vlSelf->nios_lua_exec_slave_done = lua_cpu__DOT__nios_done;
    vlSelf->avalon_master_write = lua_cpu__DOT__mem_w;
    vlSelf->avalon_master_read = lua_cpu__DOT__mem_r;
    vlSelf->nios_lua_exec_slave_result = lua_cpu__DOT__nios_result;
    vlSelf->avalon_master_writedata = lua_cpu__DOT__mem_wdata;
    vlSelf->avalon_master_address = lua_cpu__DOT__mem_addr;
}

VL_ATTR_COLD void Vlua_cpu___024root___eval_initial(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clock_sink_clk = vlSelf->clock_sink_clk;
    vlSelf->__Vclklast__TOP__reset_sink_reset = vlSelf->reset_sink_reset;
}

VL_ATTR_COLD void Vlua_cpu___024root___eval_settle(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___eval_settle\n"); );
    // Body
    Vlua_cpu___024root___settle__TOP__2(vlSelf);
}

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
    vlSelf->lua_cpu__DOT__ex_state = VL_RAND_RESET_I(4);
    vlSelf->lua_cpu__DOT__ci_u_l_savedpc_v = VL_RAND_RESET_I(32);
    vlSelf->lua_cpu__DOT__instruction = VL_RAND_RESET_I(32);
    vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p = VL_RAND_RESET_I(32);
}
