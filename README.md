# AVR LED Message Signalling

## Overview
This project implements a **LED-based message signalling system** using AVR Assembly on the **Arduino Mega2560**. Each letter of a message is encoded into a specific LED pattern and duration, allowing messages to be visually displayed using six LEDs.

## Features
- LED signalling patterns for alphabet letters
- Short and long display durations
- Assembly functions using registers and stack parameters
- Message display from program memory

## How It Works
1. A message is stored in program memory.
2. Each letter is converted into an LED pattern using `encode_letter`.
3. The pattern and duration are displayed using `leds_with_speed`.
4. LEDs flash sequentially to represent the full message.

## Files
```
a2-signalling.asm   # Main AVR assembly program
README.md
```

## Concepts Demonstrated
- AVR Assembly programming
- Embedded systems programming
- Bitwise operations
- Function calls and stack usage
- Microcontroller LED control

## Author
Jasvin Kaur  
Computer Science – University of Victoria
