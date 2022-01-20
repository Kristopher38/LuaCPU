#ifndef h_common
#define h_common

#ifdef __NIOS2__
	#include "system.h"
	#define ALT_CI_LUA_EXEC(n,A,B) __builtin_custom_inpp(ALT_CI_LUA_CPU_0_N+(n&ALT_CI_LUA_CPU_0_N_MASK),(A),(B))
	#define ALT_CI_LUA_STOREVALI(reg, val) __builtin_custom_npi(ALT_CI_LUA_CPU_0_N+(1&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(val))
    #define ALT_CI_LUA_STOREVALF(reg, val) __builtin_custom_npf(ALT_CI_LUA_CPU_0_N+(1&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(val))
    #define ALT_CI_LUA_STOREVALP(reg, val) __builtin_custom_npp(ALT_CI_LUA_CPU_0_N+(1&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(void*)(val))
    #define ALT_CI_LUA_STOREVAL(reg, val) __asm__("custom 1,zero,%0,%1" :: "r" (reg), "r" (val)); 
	#define ALT_CI_LUA_STORETT(reg, tt) __builtin_custom_npi(ALT_CI_LUA_CPU_0_N+(2&ALT_CI_LUA_CPU_0_N_MASK),(void*)(reg),(int)(tt))
    #define ALT_CI_LUA_STOREBASE(base) __builtin_custom_np(ALT_CI_LUA_CPU_0_N+(3&ALT_CI_LUA_CPU_0_N_MASK),(void*)(base))
#endif

#endif
