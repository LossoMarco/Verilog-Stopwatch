# Verilog-Stopwatch

## Introduction
The report outlines the design of a stopwatch developed in Verilog, which counts seconds, tenths, and hundredths of a second, and includes features such as reset, start/stop, partial time display, and countdown functionality . The project was simulated using ModelSim and implemented on the Terasic DE1-SoC board, showcasing the results on six seven-segment displays .

## Stopwatch Description
The basic stopwatch is designed to count seconds, tenths, and hundredths of a second, featuring two main buttons: reset and start/stop. The reset button clears the count, while the start/stop button initiates or halts the counting process . When reset, the stopwatch remains at zero until the start/stop button is pressed again .

## Clock Divider
A clock divider is utilized to generate a 100 Hz clock signal from a 50 MHz internal signal of the DE1-SoC board, ensuring an appropriate update frequency for counting hundredths of a second . The clock divider counts the rising edges of the 50 MHz clock, totaling 500,000 in 0.01 seconds, and toggles the output clock signal accordingly .

### Clock Divider Module
The clock divider module is defined with inputs and outputs, where the input is a 50 MHz clock and the output is a 100 Hz clock . The module includes a counter that tracks clock cycles to generate the output clock .

## Counter Implementation
The implementation of the actual counting mechanism involves nested if statements to manage the counting of seconds, minutes, and hours . The reset functionality sets all counters to zero, while an enable signal controls the start/stop state of the counter .

### Counter Module
The counter module is activated on the rising edge of the 100 Hz clock or the reset signal, with conditions to reset or increment the counters based on the enable state . The variables include centiseconds, seconds, minutes, hours, and the running state of the counter .

## Simulation
Before downloading the design to the hardware, a simulation was conducted in ModelSim to verify the correct operation of the counter and the reset and enable signals .
