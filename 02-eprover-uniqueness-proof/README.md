# HW2 – Uniqueness and Existence Proofs using E Prover and ENIGMA

**Course:** SI1001 — Theory of Computation  
**Professor:** Andrés Sicard-Ramírez  
**Date:** 12th October 2025  
**Version:** 1.0

---

## 👥 Team Members

- Joan Stiven Peralta Bedoya  
- Esteban Alvarez Garcia  

---

## 📘 Project Description

This homework explores **automated theorem proving (ATP)** in **first-order logic** using the **E Prover** system. 
The goal is to formally demonstrate the logical equivalence between **existence** and **uniqueness** conditions for a property `P(x)`:

```
∃x [P(x) ∧ ∀y (P(y) ⇒ y = x)] ⇔ (∃x P(x)) ∧ (∀y∀z ((P(y) ∧ P(z)) ⇒ y=z))
```

This corresponds to the **Uniqueness** section (5.6.3) and exercises from **Section 5.7** of the course material.

---

## 📂 Repository Structure

```
hw2/
 ├── hw2_dir1.tptp
 ├── hw2_dir2.tptp
 ├── hw2_dir1_output.txt
 ├── hw2_dir2_output.txt
 └── README.md
```

- `hw2_dir1.tptp` — Expanded form implies existence and uniqueness  
- `hw2_dir2.tptp` — Existence and uniqueness imply expanded form  
- `hw2_dir1_output.txt` — Output log for `hw2_dir1.tptp`  
- `hw2_dir2_output.txt` — Output log for `hw2_dir2.tptp`  
- `README.md` — This documentation file

---

## 🖥️ Development Environment

We used **Windows Subsystem for Linux (WSL)** with **Ubuntu 22.04 LTS** to run and compile E Prover.

### 1. Install WSL and Ubuntu

Open PowerShell and run:

```powershell
wsl --install -d Ubuntu
```

Then open Ubuntu from the Start Menu and create a new Linux user.

### 2. Install Dependencies in Ubuntu

```bash
sudo apt update
sudo apt install -y build-essential git cmake python3 python3-pip libgmp-dev
```

- `build-essential`: compiler and make utilities  
- `git`: source code management  
- `cmake`: build automation tool  
- `python3`, `pip`: scripting utilities  
- `libgmp-dev`: library for large integer arithmetic

### 3. Install and Build E Prover

```bash
git clone https://github.com/eprover/eprover.git
cd eprover
./configure
make
```

Check the installation:

```bash
cd ~/eprover
ls PROVER
./PROVER/eprover --version ----> Verificar la instalacion
```

---

## 🧩 Proof Files and Execution

Each `.tptp` file describes a logical statement using TPTP syntax (`fof` = first-order formula).

### 1. `hw2_dir1.tptp`  
**Goal:** Show that the expanded definition implies existence and uniqueness.

```tptp
fof(def_expanded, axiom,
    ? [X] : ( p(X) & ! [Y] : ( p(Y) => ( Y = X ) ) )
).

fof(conj_existence, conjecture,
    ? [X] : p(X)
).

fof(conj_uniqueness, conjecture,
    ! [Y,Z] : ( ( p(Y) & p(Z) ) => ( Y = Z ) )
).
```

### 2. `hw2_dir2.tptp`  
**Goal:** Show that existence and uniqueness imply the expanded definition.

```tptp
fof(ax_exist, axiom,
    ? [X] : p(X)
).

fof(ax_unique, axiom,
    ! [X,Y] : ( ( p(X) & p(Y) ) => ( X = Y ) )
).

fof(conj_expanded, conjecture,
    ? [X] : ( p(X) & ! [Y] : ( p(Y) => ( Y = X ) ) )
).
```

### Running the Proofs

Navigate to your working directory:

```bash
cd ~/hw2
```

Run each proof and store its output:

```bash
eprover --auto hw2_dir1.tptp > hw2_dir1_output.txt 2>&1
eprover --auto hw2_dir2.tptp > hw2_dir2_output.txt 2>&1
```

---

## 📊 Results and Interpretation

Successful execution produces:

```
% Presaturation interreduction done
% Proof found!
```

**Internal Proof Trace (excerpt):**
```
%cnf(i_0_3, negated_conjecture, (~p(X1))).
%cnf(i_0_4, negated_conjecture, (esk3_0!=esk2_0)).
%cnf(i_0_5, negated_conjecture, (p(esk3_0))).
%cnf(i_0_6, negated_conjecture, (p(esk2_0))).
```

**Logical Explanation:**
- **CNF Transformation:** All formulas converted to clausal normal form.
- **Negation of Conjecture:** E assumes ¬(conjecture) to search for contradiction.
- **Skolemization:** Existential quantifiers replaced by constants.
- **Resolution:** Inference rules applied until contradiction is derived.
- **Result:** Contradiction (⊥) means the original formula is true.

**Summary Table:**

| Direction                       | Meaning                                                        | Result  |
|----------------------------------|----------------------------------------------------------------|---------|
| Expanded ⇒ Existence + Uniqueness| If there exists exactly one x such that P(x), then P is both existent and unique. | Proved  |
| Existence + Uniqueness ⇒ Expanded| If P exists and is unique, then there exists exactly one x such that P(x).        | Proved  |

---

## 🧠 Background: E Prover

**E Prover** is a state-of-the-art automated theorem prover for first-order logic with equality.  
It uses superposition calculus to efficiently search for proofs in first-order logic.

---
## 📚 References & Further Reading

- WSL Documentation: [docs.microsoft.com/en-us/windows/wsl](https://docs.microsoft.com/en-us/windows/wsl)
- E Prover Official Repository: [github.com/eprover/eprover](https://github.com/eprover/eprover)
- Automated Theorem Proving (Wikipedia): [en.wikipedia.org/wiki/Automated_theorem_proving](https://en.wikipedia.org/wiki/Automated_theorem_proving)

---

## 🤖 Use of AI (ChatGPT)

ChatGPT (OpenAI) was used to:
- Refine the explanation of automated theorem proving and first-order logic concepts.
- Assist with the installation and configuration of E Prover and ENIGMA in WSL.
- Guide the interpretation of proof outputs and TPTP file structure.
- Improve the organization, clarity, and formatting of this README.md.

---

## 🙏 Acknowledgements

- Professor Andrés Sicard-Ramírez for providing the assignment and academic guidance.
- Open-source community for their work on E Prover and related logic tools.
- ChatGPT (OpenAI) for explanations, technical support, and document structuring.


All proofs were executed in Ubuntu (WSL) using E Prover 3.0.1 first-order logic theorem proving.

