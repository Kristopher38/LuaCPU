// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlua_cpu.h for the primary calling header

#include "verilated.h"

#include "Vlua_cpu__Syms.h"
#include "Vlua_cpu___024root.h"

void Vlua_cpu___024root___ctor_var_reset(Vlua_cpu___024root* vlSelf);

Vlua_cpu___024root::Vlua_cpu___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vlua_cpu___024root___ctor_var_reset(this);
}

void Vlua_cpu___024root::__Vconfigure(Vlua_cpu__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vlua_cpu___024root::~Vlua_cpu___024root() {
}
