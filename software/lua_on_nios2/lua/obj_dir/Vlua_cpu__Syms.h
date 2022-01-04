// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLUA_CPU__SYMS_H_
#define VERILATED_VLUA_CPU__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vlua_cpu.h"

// INCLUDE MODULE CLASSES
#include "Vlua_cpu___024root.h"

// SYMS CLASS (contains all model state)
class Vlua_cpu__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vlua_cpu* const __Vm_modelp;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vlua_cpu___024root             TOP;

    // CONSTRUCTORS
    Vlua_cpu__Syms(VerilatedContext* contextp, const char* namep, Vlua_cpu* modelp);
    ~Vlua_cpu__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
