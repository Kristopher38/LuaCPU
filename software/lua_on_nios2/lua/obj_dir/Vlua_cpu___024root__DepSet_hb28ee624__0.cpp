// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlua_cpu.h for the primary calling header

#include "verilated.h"

#include "Vlua_cpu___024root.h"

VL_INLINE_OPT void Vlua_cpu___024root___combo__TOP__1(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___combo__TOP__1\n"); );
    // Init
    IData/*31:0*/ lua_cpu__DOT__ci_u_l_p;
    // Body
    lua_cpu__DOT__ci_u_l_p = ((IData)(0x10U) + vlSelf->nios_lua_exec_slave_datab);
    vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p = ((IData)(4U) 
                                              + lua_cpu__DOT__ci_u_l_p);
}

VL_INLINE_OPT void Vlua_cpu___024root___sequent__TOP__3(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___sequent__TOP__3\n"); );
    // Init
    CData/*0:0*/ lua_cpu__DOT__nios_done;
    CData/*0:0*/ lua_cpu__DOT__mem_r;
    CData/*0:0*/ lua_cpu__DOT__mem_w;
    IData/*31:0*/ lua_cpu__DOT__nios_result;
    IData/*31:0*/ lua_cpu__DOT__mem_wdata;
    CData/*3:0*/ __Vdly__lua_cpu__DOT__ex_state;
    // Body
    __Vdly__lua_cpu__DOT__ex_state = vlSelf->lua_cpu__DOT__ex_state;
    if (vlSelf->reset_sink_reset) {
        __Vdly__lua_cpu__DOT__ex_state = 0U;
        vlSelf->lua_cpu__DOT__ci_u_l_savedpc_v = 0U;
        vlSelf->lua_cpu__DOT__instruction = 0U;
    } else if (vlSelf->nios_lua_exec_slave_clk_en) {
        if ((8U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
            if ((4U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                        __Vdly__lua_cpu__DOT__ex_state = 0U;
                    }
                }
            }
        } else if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                             >> 2U)))) {
            if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                    if ((1U & (~ (IData)(vlSelf->avalon_master_waitrequest)))) {
                        __Vdly__lua_cpu__DOT__ex_state = 2U;
                    }
                } else if ((1U & (~ (IData)(vlSelf->avalon_master_waitrequest)))) {
                    vlSelf->lua_cpu__DOT__instruction 
                        = vlSelf->avalon_master_readdata;
                    __Vdly__lua_cpu__DOT__ex_state = 0xfU;
                }
            } else if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                if ((1U & (~ (IData)(vlSelf->avalon_master_waitrequest)))) {
                    vlSelf->lua_cpu__DOT__ci_u_l_savedpc_v 
                        = vlSelf->avalon_master_readdata;
                    __Vdly__lua_cpu__DOT__ex_state = 3U;
                }
            } else if (vlSelf->nios_lua_exec_slave_start) {
                __Vdly__lua_cpu__DOT__ex_state = 1U;
            }
        }
    }
    vlSelf->lua_cpu__DOT__ex_state = __Vdly__lua_cpu__DOT__ex_state;
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
                }
            }
        }
    }
    vlSelf->nios_lua_exec_slave_done = lua_cpu__DOT__nios_done;
    vlSelf->avalon_master_write = lua_cpu__DOT__mem_w;
    vlSelf->avalon_master_read = lua_cpu__DOT__mem_r;
    vlSelf->nios_lua_exec_slave_result = lua_cpu__DOT__nios_result;
    vlSelf->avalon_master_writedata = lua_cpu__DOT__mem_wdata;
}

VL_INLINE_OPT void Vlua_cpu___024root___combo__TOP__4(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___combo__TOP__4\n"); );
    // Init
    IData/*31:0*/ lua_cpu__DOT__mem_addr;
    // Body
    lua_cpu__DOT__mem_addr = 0U;
    if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                  >> 3U)))) {
        if ((1U & (~ ((IData)(vlSelf->lua_cpu__DOT__ex_state) 
                      >> 2U)))) {
            if ((2U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                lua_cpu__DOT__mem_addr = ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))
                                           ? vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p
                                           : vlSelf->lua_cpu__DOT__ci_u_l_savedpc_v);
            } else if ((1U & (IData)(vlSelf->lua_cpu__DOT__ex_state))) {
                lua_cpu__DOT__mem_addr = vlSelf->lua_cpu__DOT__ci_u_l_savedpc_p;
            }
        }
    }
    vlSelf->avalon_master_address = lua_cpu__DOT__mem_addr;
}

void Vlua_cpu___024root___eval(Vlua_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlua_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlua_cpu___024root___eval\n"); );
    // Body
    Vlua_cpu___024root___combo__TOP__1(vlSelf);
    if ((((IData)(vlSelf->clock_sink_clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clock_sink_clk))) 
         | ((IData)(vlSelf->reset_sink_reset) & (~ (IData)(vlSelf->__Vclklast__TOP__reset_sink_reset))))) {
        Vlua_cpu___024root___sequent__TOP__3(vlSelf);
    }
    Vlua_cpu___024root___combo__TOP__4(vlSelf);
    // Final
    vlSelf->__Vclklast__TOP__clock_sink_clk = vlSelf->clock_sink_clk;
    vlSelf->__Vclklast__TOP__reset_sink_reset = vlSelf->reset_sink_reset;
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
