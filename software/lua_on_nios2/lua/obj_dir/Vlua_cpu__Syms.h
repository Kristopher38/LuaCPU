// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLUA_CPU__SYMS_H_
#define VERILATED_VLUA_CPU__SYMS_H_  // guard

#include "verilated.h"
#include "verilated_vcd_c.h"

// INCLUDE MODEL CLASS

#include "Vlua_cpu.h"

// INCLUDE MODULE CLASSES
#include "Vlua_cpu___024root.h"
#include "Vlua_cpu_lua_cpu.h"

// SYMS CLASS (contains all model state)
class Vlua_cpu__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vlua_cpu* const __Vm_modelp;
    bool __Vm_dumping = false;  // Dumping is active
    VerilatedMutex __Vm_dumperMutex;  // Protect __Vm_dumperp
    VerilatedVcdC* __Vm_dumperp VL_GUARDED_BY(__Vm_dumperMutex) = nullptr;  /// Trace class for $dump*
    bool __Vm_activity = false;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode = 0;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vlua_cpu___024root             TOP;
    Vlua_cpu_lua_cpu               TOP__lua_cpu;

    // CONSTRUCTORS
    Vlua_cpu__Syms(VerilatedContext* contextp, const char* namep, Vlua_cpu* modelp);
    ~Vlua_cpu__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
    void _traceDump();
    void _traceDumpOpen();
    void _traceDumpClose();
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
