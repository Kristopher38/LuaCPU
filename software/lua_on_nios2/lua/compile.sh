
#/bin/zsh

verilator -O0 -CFLAGS "-DLUA_USE_LINUX -DLUA_COMPAT_5_2 -DVERILATOR_SIM -g -m32 -march=i386" -LDFLAGS "-Wl,-E -Iobj_dir/ -lm -ldl -lreadline -m32" --trace --cc --build --exe ../../../hardware/lua_cpu.v *.c cpusim.cpp