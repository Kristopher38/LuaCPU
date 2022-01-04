#/bin/zsh

verilator -CFLAGS "-DLUA_USE_LINUX -DLUA_COMPAT_5_2 -DVERILATOR_SIM" -LDFLAGS "-Wl,-E -Iobj_dir/ -lm -ldl -lreadline" --cc --build --exe ../../../hardware/lua_cpu.v *.c cpusim.cpp
