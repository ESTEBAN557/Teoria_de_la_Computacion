# 🧠 HW3 — Formal Verification with Frama-C

## Academic Context

**Course:** SI1001 — Theory of Computation  
**Professor:** Andrés Sicard-Ramírez  
**Institution:** EAFIT University  
**Date:** 3rd November 2025  
**Version:** 1.0

---

## 👥 Team Members

- Joan Stiven Peralta Bedoya
- Esteban Alvarez Garcia

---

# 📌 Project Description

This homework explores **formal verification of C programs** using **Frama-C** and its **WP (Weakest Precondition)** plugin.

The project specifies and verifies an addition function from Exercise 3.1.4.1 (Addition) in *Blanchard 2024* using **ACSL (ANSI/ISO C Specification Language)** annotations.

The goal is not only to implement the function, but also to formally prove:

- The correctness of the function behavior
- The absence of runtime errors
- Integer overflow safety

---

# 🎯 Verification Goals

The verification process focuses on:

1. Proving the function's postcondition
2. Detecting possible runtime errors
3. Preventing signed integer overflow
4. Demonstrating formal correctness using ACSL specifications

---

# 📂 Repository Structure

```bash
📦 03-framac-verification
 ┣ 📄 add.c
 ┗ 📄 README.md
```

---

# ⚙️ Environment Versions

| Component | Version |
|---|---|
| Operating System | Windows 11 + WSL2 Ubuntu |
| GCC | 13.3.0 |
| Frama-C | 31.0 |
| Alt-Ergo | 2.6.2 |

---

# 🛠️ Installation and Dependencies

The project was developed using **WSL2 Ubuntu**.

## Install WSL and Ubuntu

Run in PowerShell:

```powershell
wsl --install -d Ubuntu
```

Then create a Linux user after Ubuntu launches.

---

## Install Dependencies

```bash
sudo apt update
sudo apt install opam
```

---

## Initialize OPAM

```bash
opam init
eval $(opam env)
```

---

## Install Frama-C

```bash
opam install frama-c
```

---

## Install Alt-Ergo

```bash
opam install alt-ergo
```

---

## Configure Why3

```bash
why3 config detect
```

---

# 🧩 Source Code and ACSL Contract

## add.c

```c
#include <limits.h>

/*@
  // Preconditions: avoid arithmetic overflow in x + y
  requires (long long)x + y >= INT_MIN &&
           (long long)x + y <= INT_MAX;

  // Postcondition: result equals original sum
  ensures \result == \old(x) + \old(y);

  // No memory modification
  assigns \nothing;
*/
int add(int x, int y) {
  return x + y;
}
```

---

# ⚙️ Verification Steps

## 1. WP Verification (Correctness Proof)

Run:

```bash
frama-c-gui -wp add.c
```

### Result

All proof obligations were successfully discharged.

The following property was formally proven:

```text
\result == \old(x) + \old(y)
```

### Example Output

```text
[wp] Goal add_Post proved.
[wp] Proved goals: 1 / 1
```

---

## 2. Runtime Error Analysis (RTE)

Run:

```bash
frama-c-gui -wp -rte add.c
```

### Analysis

Initially, Frama-C reports a potential signed overflow in:

```c
x + y
```

After introducing ACSL preconditions restricting the valid input range, all runtime checks are verified as safe.

### Example Output

```text
[rte] No possible runtime errors detected.
[wp] Proved goals: 4 / 4
```

---

# 📊 Results and Interpretation

## Verification Summary

| Verification Type | Tool / Plugin | Purpose | Result |
|---|---|---|---|
| Function Contract | WP | Prove postcondition correctness | ✅ Passed |
| Runtime Errors | RTE + WP | Detect integer overflow | ✅ Passed |

---

## Interpretation

The program satisfies its formal specification:

- If the preconditions hold,
- The addition operation always produces the correct result,
- And no signed overflow occurs during execution.

This guarantees both **functional correctness** and **runtime safety**.

---

# 🧠 Background — Frama-C and ACSL

**Frama-C** is a framework for static analysis and formal verification of C programs.

The **WP (Weakest Precondition)** plugin generates logical proof obligations from ACSL annotations and verifies them using automated provers such as **Alt-Ergo**.

---

## ACSL Keywords Used

| Keyword | Meaning |
|---|---|
| `requires` | Defines preconditions |
| `ensures` | Defines postconditions |
| `assigns` | Specifies modified memory |
| `\old(x)` | Value before execution |
| `\result` | Returned value |

---

# 🧠 Concepts Applied

This project applies concepts from:

- Formal Verification
- Static Analysis
- Program Correctness
- ACSL Specifications
- Weakest Preconditions
- Runtime Error Detection
- Hoare-style Reasoning
- Automated Proof Systems

---

# 📚 References & Further Reading

- Allan Blanchard — *Introduction to C Program Proof with Frama-C and its WP Plugin*
- Frama-C Official Documentation
- Alt-Ergo Automated Theorem Prover
- Why3 Platform
- EAFIT University — SI1001 Course Materials

---

# 🤖 Use of AI (ChatGPT)

ChatGPT (OpenAI) was used to:

- Clarify ACSL annotations and formal verification concepts
- Assist with WSL, Frama-C, and Alt-Ergo installation
- Explain WP and RTE analysis workflows
- Improve documentation structure and formatting

---

# 🙏 Acknowledgements

- Professor Andrés Sicard-Ramírez for the assignment and academic guidance
- The Frama-C and Why3 open-source communities
- ChatGPT (OpenAI) for conceptual explanations and documentation support

---

# 📌 Notes

All proofs were executed in Ubuntu (WSL2) using:

- Frama-C 31.0
- Alt-Ergo 2.6.2
```
