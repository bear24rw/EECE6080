stepsize 10
logfile intranex_test.log
h VDD
l GND
vector CLK SCLKI
clock  CLK 0 1
w   SCLKI SI SO
ana SCLKI SI SO
l LDI
l PCLKI
l PSI

| enable test mode
h TESTI

| clock in a pulse (010)
l SI
c
h SI
c
l SI
c

| clock it until the pulse is just about to come out
| 16*16+16-3-1 == 268
|
| 16*16+16 == number of flip flops
| 3 == we already clocked three times
| 1 == stop right before the pulse comes out
c 268

| make sure we see the pulse
assert SO 0
c
assert SO 1
c
assert SO 0
c

