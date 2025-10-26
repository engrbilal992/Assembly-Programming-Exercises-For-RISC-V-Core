# Assembly Programming Exercises For RISC-V Core

This repository contains **Assembly programming exercises** implemented for the **RISC-V Core (RVfpga)** running on the **Nexys A7 FPGA board**.

Each exercise demonstrates fundamental **assembly-level programming concepts** such as loops, arrays, sorting, and arithmetic operations — all implemented using **memory-mapped I/O** for hardware interaction with **LEDs and switches**.

---

## 📘 Exercises Included

| Folder | Description |
|---------|-------------|
| Exercise1 | Basic arithmetic operations and GPIO interaction |
| Exercise2 | Conditional branching and LED control |
| Exercise3 | Loop operations using registers |
| Exercise4 | Array traversal and element manipulation |
| Exercise5 | Sorting or comparison logic |
| Exercise6 | Fibonacci and sequence generation |
| Exercise7 | Switch and LED interfacing |
| Exercise8 | Bitwise and logical operation exercises |
| Exercise9 | Combined control and computation task |
| Exercise10 | Final integration and testing routine |
| Project1 | Complete mini-project combining multiple features |
| ReadSwitches.S | Direct example of reading switch input and controlling LEDs |

---

## 🧰 Requirements

- RISC-V GCC Toolchain (`riscv64-unknown-elf-gcc`)
- SweRVolf SoC (RVfpga) on Nexys A7
- PlatformIO / Vivado environment for integration

---

## 🧠 Usage

To assemble and run an exercise:

```bash
riscv64-unknown-elf-as -o output.o Exercise1/main.S
riscv64-unknown-elf-objcopy -O binary output.o output.bin
