#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
SRC="${ROOT_DIR}/src/vhdl"
SIM_DIR="${ROOT_DIR}/sim"

# Choose VHDL standard (2008 is widely supported)
STD="--std=08"

# Analyze
ghdl -a $STD -g --workdir=./work "$SRC"/Data_Input.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/Coeff_Shift_Register.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/MUL1.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/MUL2.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/ADD1.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/Data_Output.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/Synchro_Unit.vhd
ghdl -a $STD -g --workdir=./work "$SRC"/FIR_Filter_Top.vhd
ghdl -a $STD -g --workdir=./work "${SIM_DIR}"/FIR_Top_TB.vhd

# Elaborate
ghdl -e $STD --workdir=./work FIR_Top_TB

# Run
ghdl -r $STD --workdir=./work FIR_Top_TB --assert-level=error --stop-time=2ms --wave=wave.ghw
echo "Simulation complete. Open sim/wave.ghw in GTKWave."
