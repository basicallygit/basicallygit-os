# basicallygit-os
A simple hobby operating system

Currently on boot only displays a welcome message, and a prompt that will echo back whatever the user types.

## Building & Running

### Prerequisites
- [nasm](https://www.nasm.us/) - Building the OS
- [qemu](https://www.qemu.org/) - Running the OS

### Building
Run `make` in the root of this project

### Running
Run the resulting binary in `out/boot.bin` directly from qemu:
```shell
qemu-system-x86_64 out/boot.bin
# OR
qemu-system-i386 out/boot.bin
```
