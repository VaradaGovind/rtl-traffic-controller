# 🚦 FSM-Based Traffic Light Controller

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Platform](https://img.shields.io/badge/Platform-FPGA-orange)
![Status](https://img.shields.io/badge/Status-Synthesizable-green)

A robust **Finite State Machine (FSM)** implementation for a two-way traffic intersection. This design features emergency-priority logic, sensor-based dynamic switching, and fail-safe yellow phase transitions. Written in Verilog, the code is fully synthesizable and optimized for FPGA deployment.

---

## 🧩 Key Features

- **Dual-Road Management:** Efficiently handles traffic flow for Road-A and Road-B.
- **Robust FSM Architecture:** Clean 6-state design ensures no invalid states or deadlocks.
- **🚨 Priority Interrupts:** Asynchronous emergency overrides for both roads (Ambulance/Police priority).
- **Safety-First Logic:** Guarantees a Yellow transition phase even during emergency recovery to prevent accidents.
- **Hardware Ready:** Designed with synchronous logic and asynchronous reset, ready for synthesis on Xilinx/Intel FPGAs.

---

## 🔧 Finite State Machine (FSM)

The controller utilizes a **Moore Machine** architecture where outputs depend solely on the current state.

### State Table
| State Code | State Name | Description |
| :--- | :--- | :--- |
| `3'b000` | **S_A_GREEN** | **Road A:** Green <br> **Road B:** Red |
| `3'b001` | **S_A_YELLOW** | **Road A:** Yellow (Transition) <br> **Road B:** Red |
| `3'b010` | **S_B_GREEN** | **Road B:** Green <br> **Road A:** Red |
| `3'b011` | **S_B_YELLOW** | **Road B:** Yellow (Transition) <br> **Road A:** Red |
| `3'b100` | **S_EMERG_A** | **Emergency A:** Forces A Green, B Red immediately. |
| `3'b101` | **S_EMERG_B** | **Emergency B:** Forces B Green, A Red immediately. |

### Logic Flow
1. **Normal Operation:** Cycles between A-Green and B-Green based on timer/sensor inputs.
2. **Emergency Detect:** If `emerg_a` or `emerg_b` goes high, the FSM jumps to the respective Emergency state.
3. **Recovery:** Once the emergency signal clears, the system transitions to the Yellow state of the *current* active road before switching, ensuring a safe handover.

---

## 🔌 I/O Ports

| Direction | Port Name | Width | Description |
| :--- | :--- | :--- | :--- |
| **Input** | `clk` | 1-bit | System Clock |
| **Input** | `rst_n` | 1-bit | Active-low Asynchronous Reset |
| **Input** | `sensor_a/b` | 1-bit | Traffic sensors for Road A/B |
| **Input** | `emerg_a/b` | 1-bit | Emergency overrides for Road A/B |
| **Output** | `light_a` | 3-bit | RGB Output for Road A (Red, Yellow, Green) |
| **Output** | `light_b` | 3-bit | RGB Output for Road B (Red, Yellow, Green) |

---

## 📁 Repository Structure

```text
.
├── src
│   └── controller.v       # Main RTL design (FSM Logic)
├── tb
│   └── controller_tb.v    # Testbench with emergency scenarios
├── docs
│   └── Testbench.png       # Simulation output
└── README.md
