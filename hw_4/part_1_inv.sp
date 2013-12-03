* Max Thrun HW4 Part 1 Inverter

.include ../models/library.sp

vdd vdd gnd 5V

xinv a f vdd gnd inv

va    a     gnd PULSE(0V 5V 10n 0 0 10n 20n)

.option post
.tran 0.01n 30n

.end
