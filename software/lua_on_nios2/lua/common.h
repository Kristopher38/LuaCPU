#ifndef h_common
#define h_common

#if defined(__NIOS2__) || defined(VERILATOR_SIM)
    #define CUSTOM_LUA
#endif

#define SYNC_REGS(ci, base) { \
    for (StkId slot = base; slot < ci->top; slot++) \
    { \
        ALT_CI_LUA_STOREVAL(slot, slot->value_); \
        ALT_CI_LUA_STORETT(slot, slot->tt_); \
    } \
}

#ifdef __NIOS2__
	#include "system.h"
	#define ALT_CI_LUA_EXEC(A,B) __builtin_custom_inpp(ALT_CI_LUA_CPU_0_N+0,(A),(B))
	#define ALT_CI_LUA_STOREVALI(reg, val) __builtin_custom_npi(ALT_CI_LUA_CPU_0_N+(1&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(val))
    #define ALT_CI_LUA_STOREVALF(reg, val) __builtin_custom_npf(ALT_CI_LUA_CPU_0_N+(1&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(val))
    #define ALT_CI_LUA_STOREVALP(reg, val) __builtin_custom_npp(ALT_CI_LUA_CPU_0_N+(1&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(void*)(val))
    #define ALT_CI_LUA_STOREVAL(reg, val) __asm__("custom 1,zero,%0,%1" :: "r" (reg), "r" (val)) 
	#define ALT_CI_LUA_STORETT(reg, tt) __builtin_custom_npi(ALT_CI_LUA_CPU_0_N+(2&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(int)(tt))
    #define ALT_CI_LUA_STOREBASE(base) { __builtin_custom_np(ALT_CI_LUA_CPU_0_N+(3&ALT_CI_LUA_CPU_0_N_MASK),(void*)(base)); SYNC_REGS(L->ci, base); }
#elif VERILATOR_SIM
    #include "cpusim.h"
	#define ALT_CI_LUA_EXEC(A,B) luacpu_simulate(A, B);
	#define ALT_CI_LUA_STOREVALI(reg, val) luacpu_storeval((void*)reg, val) 
    #define ALT_CI_LUA_STOREVALF(reg, val) luacpu_storeval((void*)reg, val)
    #define ALT_CI_LUA_STOREVALP(reg, val) luacpu_storeval((void*)reg, val)
    #define ALT_CI_LUA_STOREVAL(reg, val) luacpu_storeval((void*)reg, val)
	#define ALT_CI_LUA_STORETT(reg, tt) luacpu_storett((void*)reg, tt)
    #define ALT_CI_LUA_STOREBASE(base) { luacpu_storebase((void*)base); SYNC_REGS(L->ci, base); }
#else
	#define ALT_CI_LUA_EXEC(A,B) (void)0
	#define ALT_CI_LUA_STOREVALI(reg, val) (void)0 
    #define ALT_CI_LUA_STOREVALF(reg, val) (void)0
    #define ALT_CI_LUA_STOREVALP(reg, val) (void)0
    #define ALT_CI_LUA_STOREVAL(reg, val) (void)0
	#define ALT_CI_LUA_STORETT(reg, tt) (void)0
    #define ALT_CI_LUA_STOREBASE(base) (void)0
#endif

#endif
