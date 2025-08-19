# Vending Machine Controller (Mealy FSM)

##  Overview 
The machine takes coins of **5** and **10**, represented by a 2-bit input:

- `coin = 2'b01` → 5  
- `coin = 2'b10` → 10  
- `coin = 2'b00` → no coin  
- `coin = 2'b11` → ignore  
 The FSM interprets when to **dispense** the product and if to return **5 change**.



---

##  State Encoding
- `a` → 0 inserted  
- `b` → 5 inserted  
- `c` → 10 inserted  
- `d` → 15 inserted  

---

## State Transitions
- From **a**:  
  - +5 → b  
  - +10 → c  

- From **b**:  
  - +5 → c  
  - +10 → d  

- From **c**:  
  - +5 → d  
  - +10 → Dispense immediately, reset to a  

- From **d**:  
  - +5 → Dispense immediately, reset to a  
  - +10 → Dispense + return ₹5 change, reset to a  

---

##  Output Logic
- **Dispense**:
  - When total ≥ 20 (achieved either by exact 20 or by overpayment).  
- **Change (chg5)**:
  - When an extra ₹10 is inserted at d (i.e., 25 total).  

---

## Simulation Commands
```bash
iverilog -o  iverilog -o vending vending_mealy.v tb3.v
vvp vending
gtkwave wave3.vcd
