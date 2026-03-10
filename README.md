# AVR LED Message Signalling System

## Overview
This project implements a **visual message signalling system using LEDs** on the **Arduino Mega2560** programmed in **AVR Assembly**.

Each letter of a message is converted into a **specific LED pattern and duration**, allowing words to be communicated through sequences of lights. The system demonstrates low-level programming concepts including register manipulation, stack-based parameter passing, and function implementation in assembly language.

The program reads a message from memory, encodes each letter into an LED signal pattern, and displays the message using six LEDs.

---

## Features
- LED-based message signalling system
- Custom encoding for each alphabet letter
- Variable signal speed (short and long durations)
- Assembly functions using register and stack parameter passing
- Modular assembly program design

---

## Hardware and Tools
- **Microcontroller:** Arduino Mega2560
- **Language:** AVR Assembly
- **Development Environment:** Microchip Studio
- **Output Device:** Six onboard LEDs

---

## How the System Works

Each letter of the alphabet is represented by:

- A **6-LED pattern**
- A **signal duration** (short or long)

Example encoding:

| Letter | LED Pattern | Duration |
|------|-------------|---------|
| H | `..oo..` | Short |
| E | `oooooo` | Long |
| L | `o.o.o.` | Long |
| O | `.oooo.` | Long |

Where:
- `o` = LED ON  
- `.` = LED OFF  

The program converts letters into LED patterns and displays them sequentially.

---

# Program Functions

## configure_leds
Turns LEDs on or off based on the bit pattern stored in register `r16`.

Each bit controls a specific LED:

```
bit5 bit4 bit3 bit2 bit1 bit0
LED1 LED2 LED3 LED4 LED5 LED6
```

Example:

```
0b00100001
```

Turns on the **first and last LED**.

---

## fast_leds
Displays an LED pattern for **short duration (~0.25 seconds)** before turning the LEDs off.

Uses:
- `configure_leds`
- `delay_short`

---

## slow_leds
Displays an LED pattern for **long duration (~1 second)**.

Uses:
- `configure_leds`
- `delay_long`

---

## leds_with_speed
Determines the display speed based on the **two most significant bits** of the parameter.

| Bits | Duration |
|----|----|
| `11` | Long (~1 second) |
| `00` | Short (~0.25 second) |

Calls either:
- `slow_leds`
- `fast_leds`

---

## encode_letter
Converts an **uppercase letter** into its LED encoding.

Steps:
1. Search the **PATTERNS table**.
2. Determine LED pattern and speed.
3. Return the encoded byte in register `r25`.

Example:

```
A → 0b11001100
```

---

## display_message_signal
Displays an entire message using LED signals.

Process:

1. Read each letter from program memory.
2. Convert the letter using `encode_letter`.
3. Display the signal using `leds_with_speed`.
4. Continue until the null terminator (`0`) is reached.

---

## Project Structure

```
avr-led-message-signalling
│
├── a2-signalling.asm
└── README.md
```

---

## Concepts Demonstrated

- AVR assembly programming
- Function implementation in assembly
- Register-based parameter passing
- Stack-based parameter passing
- Microcontroller hardware control
- LED signalling and pattern encoding
- Program memory access

---

## Learning Outcomes

This project demonstrates how **low-level programs interact directly with hardware** to create visual communication systems. It reinforces understanding of:

- Embedded system programming
- Assembly-level function design
- Binary encoding and decoding
- Microcontroller input/output control

---

## Author

**Jasvin Kaur**  
Computer Science Student  
University of Victoria
