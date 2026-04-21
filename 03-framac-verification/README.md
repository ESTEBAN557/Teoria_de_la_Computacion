# SI1001 — Homework 3: Frama-C

**Course:** SI1001 — Theory of Computation  
**Professor:** Andrés Sicard-Ramírez  
**Date:** 3rd November 2025  
**Version:** 1.0

---

## 👥 Team Members

- Joan Stiven Peralta Bedoya  
- Esteban Alvarez Garcia  

---

## Context

This program implements and specifies the addition function from Exercise 3.1.4.1 (Addition) in [Blanchard 2024].  

**Goal:** The primary goal is not just to write the function, but to use **Frama-C** and its **WP (Weakest Precondition)** plugin to write formal specifications in **ACSL (ANSI/ISO C Specification Language)**. This involves:
1.  Proving the function's core logic (post-condition).
2.  Identifying and proving the absence of Run-Time Errors (RTE), specifically `signed_overflow`.


---


## Environment Versions

Operating System: Windows 11 (using WSL 2 with Ubuntu)

C Compiler (gcc): 13.3.0

Frama-C: 31.0

Prover (Alt-Ergo): 2.6.2

## 📂 Repository Structure

hw3/
 ├── add.c
 └── README.md

## Install Dependencies

**Installation Commands (WSL/Ubuntu):**
```bash
# 1. Install prerequisites
sudo apt update
sudo apt install opam
# 2. Initialize OPAM (the OCaml package manager)
opam init
eval $(opam env)
# 3. Install Frama-C
opam install frama-c
# 4. Install the prover (Alt-Ergo)
opam install alt-ergo
# 5. Detect and configure the prover
why3 config detect
```
---

## 🧩 Source Code and Function Contract

add.c:

#include <limits.h> 

/*@
  // Preconditions: avoid arithmetic overflow in x + y
  requires (long long)x + y >= INT_MIN && (long long)x + y <= INT_MAX;

  // Postcondition: the result must equal the original sum of x and y
  ensures \result == \old(x) + \old(y);

  // No global variables or memory locations are modified
  assigns \nothing;
*/
int add(int x, int y) {
  return x + y;
}


## ⚙️ Verification Steps

The GUI will automatically load the file add.c and perform the verification.

Once the analysis is complete, the results appear as colored bubbles next to each verification condition:

🟢 Green: the proof succeeded (correct).

🔴 Red: the proof failed (incorrect).

🔵 Blue: informational (not a proof goal).

If all bubbles are green, it means the function and its contract were successfully verified.
1. Proof of Correctness (WP Plugin)
Run:
frama-c-gui -wp add.c
Result: All proof obligations successfully discharged.
Postcondition \result == \old(x) + \old(y) proven.

Example output (add_wp_output.txt):
[wp] Goal add_Post proved.
[wp] Proved goals: 1 / 1

2. Runtime Error Analysis (RTE)
Run:
frama-c-gui -wp -rte add.c
Initially reports possible overflow in x + y.
After adding preconditions, all runtime checks are safe.

Example output (add_rte_output.txt):
[rte] No possible runtime errors detected.
[wp] Proved goals: 4 / 4

## 📊 Results and Interpretation

Summary Table:
| Verification Type | Tool / Plugin | Purpose | Result |
|-------------------|---------------|----------|---------|
| Function contract | WP | Prove postcondition correctness | ✅ Passed |
| Runtime errors | RTE + WP | Check integer overflow safety | ✅ Passed |

✅ The program satisfies its formal specification: if preconditions hold, the addition function always returns the correct result without overflow.

## 🧠 Background: Frama-C and WP Plugin

Frama-C is a platform for static analysis of C programs.
The WP (Weakest Precondition) plugin uses formal logic to prove that a program respects its annotated specification written in ACSL (ANSI/ISO C Specification Language).

- requires: defines preconditions
- ensures: defines postconditions
- assigns: specifies variables that can be modified
- \old(x): refers to the value of x before execution
- \result: represents the value returned by the function

---

## 📚 References & Further Reading

- Allan Blanchard (2024). Introduction to C Program Proof with Frama-C and its WP Plugin.
  GitHub: https://github.com/AllanBlanchard/tutoriel_wp
- Frama-C Documentation: https://frama-c.com
- EAFIT University — SI1001 Theory of Computation course materials.
