// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VLUA_CPU_H_
#define VERILATED_VLUA_CPU_H_  // guard

#include "verilated.h"

class Vlua_cpu__Syms;
class Vlua_cpu___024root;
class VerilatedVcdC;

// This class is the main interface to the Verilated model
class Vlua_cpu VL_NOT_FINAL {
  private:
    // Symbol table holding complete model state (owned by this class)
    Vlua_cpu__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&nios_lua_exec_slave_clk,0,0);
    VL_IN8(&nios_lua_exec_slave_clk_en,0,0);
    VL_IN8(&nios_lua_exec_slave_start,0,0);
    VL_OUT8(&nios_lua_exec_slave_done,0,0);
    VL_IN8(&nios_lua_exec_slave_a,4,0);
    VL_IN8(&nios_lua_exec_slave_b,4,0);
    VL_IN8(&nios_lua_exec_slave_c,4,0);
    VL_IN8(&nios_lua_exec_slave_n,1,0);
    VL_IN8(&nios_lua_exec_slave_readra,0,0);
    VL_IN8(&nios_lua_exec_slave_readrb,0,0);
    VL_IN8(&nios_lua_exec_slave_reset,0,0);
    VL_IN8(&nios_lua_exec_slave_writerc,0,0);
    VL_OUT8(&avalon_master_read,0,0);
    VL_OUT8(&avalon_master_write,0,0);
    VL_IN8(&avalon_master_waitrequest,0,0);
    VL_IN8(&clock_sink_clk,0,0);
    VL_IN8(&reset_sink_reset,0,0);
    VL_IN(&nios_lua_exec_slave_dataa,31,0);
    VL_IN(&nios_lua_exec_slave_datab,31,0);
    VL_OUT(&nios_lua_exec_slave_result,31,0);
    VL_OUT(&avalon_master_address,31,0);
    VL_IN(&avalon_master_readdata,31,0);
    VL_OUT(&avalon_master_writedata,31,0);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    Vlua_cpu___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit Vlua_cpu(VerilatedContext* contextp, const char* name = "TOP");
    explicit Vlua_cpu(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~Vlua_cpu();
  private:
    VL_UNCOPYABLE(Vlua_cpu);  ///< Copying not allowed

  public:
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    /// Return current simulation context for this model.
    /// Used to get to e.g. simulation time via contextp()->time()
    VerilatedContext* contextp() const;
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
