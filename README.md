# AVR LED Signalling System

## Overview
This project implements an LED signalling program using **AVR Assembly** on an **ATmega microcontroller**. The program displays encoded messages by controlling LED blink patterns using precise timing and low-level hardware control.

The goal of this project is to practice **embedded systems programming, bitwise operations, and microcontroller register manipulation** using AVR assembly.

---

## Features
- LED message signalling using AVR Assembly
- Precise timing control with delay loops
- Direct hardware control through microcontroller registers
- Implementation of encoded signal patterns using LED blinking

---

## Technologies Used
- **Language:** AVR Assembly
- **Microcontroller:** ATmega2560
- **Development Environment:** Atmel Studio
- **Hardware Output:** LEDs connected to microcontroller pins

---

## How It Works
The program generates LED signalling patterns that represent encoded messages.

The program:
1. Loads encoded message values.
2. Controls LED output pins on the microcontroller.
3. Uses delay loops to control LED ON/OFF timing.
4. Repeats patterns to display the full message sequence.

Each signal consists of:
- LED ON duration
- LED OFF duration
- Delay between signals

---

## Project Files
```
a2-signalling.asm       # Main assembly source code
a2-signalling.asmproj   # Atmel Studio project file
a2-signalling.hex       # Compiled program for microcontroller
a2-signalling.lss       # Assembly listing file
```

---

## Concepts Demonstrated
- Embedded systems programming
- AVR assembly language
- Bitwise operations
- Hardware control using microcontroller registers
- Timing and signal generation

---

## Learning Outcome
This project demonstrates how low-level programs interact directly with hardware to produce controlled outputs. It provides hands-on experience with **assembly programming, microcontroller architecture, and embedded system design**.

---

## Author
Jasvin Kaur  
Computer Science Student – University of Victoria
