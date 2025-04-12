# EFLAGS

This project contains assembly code designed to detect whether the CPUID instruction is enabled in the system. It includes implementations for both 32-bit (x86) and 64-bit (x86_64) Linux environments.

<br>

## Overview

The main purpose of this project is to demonstrate how to check the state of the CPUID instruction in the EFLAGS register. The CPUID instruction is used to query the CPU for details about its capabilities.

Both 32-bit and 64-bit versions are included, allowing you to test on systems of different architectures.

<br>

## Prerequisites

To build and run this project, you will need the following tools:

- **NASM:** The assembler used to compile the assembly code.
- **Linux:** The code is intended to run on a Linux system, either 32-bit or 64-bit.

<br>

## Building and Running the Code

The project includes two versions of the code: one for 32-bit systems and one for 64-bit systems.

#### 32-bit version

First, assemble the code using NASM:

```bash
nasm -f elf32 src/eflags.asm -o eflags.o
```

Then, link the object file using the ld linker:

```bash
ld -m elf_i386 eflags.o -o eflags.bin
```

Finally, run the executable:

```bash
./eflags.bin
```

#### 64-bit version

Assemble the 64-bit code:

```bash
nasm -f elf64 src/eflags64.asm -o eflags64.o
```

Link the object file:

```bash
ld eflags64.o -o eflags64.bin
```

Run the 64-bit executable:

```bash
./eflags64.bin
```

<br>

## What the Code Does

The program checks whether the CPUID instruction is enabled in the system by inspecting the EFLAGS register. The specific bit used to determine if CPUID is enabled is bit 21, and the program checks this by manipulating the EFLAGS register.

The program outputs one of two messages:

- "CPUID is enabled" if CPUID is active.
- "CPUID is not active" if it is not.

If you want to extend this program to check other CPU features or state, such as virtual mode, you will need to modify the code accordingly.

<br>

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
