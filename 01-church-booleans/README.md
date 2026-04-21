# HW1 – Church Booleans

**Course**: SI1001 — Theory of Computation  
**Professor**: Andrés Sicard-Ramírez  
**Creation date**: 19th August 2025  
**Version**: 0.1  

---

## Team Members

- Joan Stiven Peralta Bedoya  
- Esteban Alvarez Garcia

---

## Project Description

This homework implements **Church’s encoding of Booleans** in Haskell. The task was to define the λ-terms for:

- `cTrue`, `cFalse`  
- `cIf`, `cNot`, `cAnd`, `cOr`  

**Constraints**: Only λ-terms — no use of Haskell’s built-in `Bool` type, `if-then-else`, or `case` expressions.

---

## Repository Contents

- `ChurchBool.hs` — Implementation and test driver (`main = testing`).  
- `README.md` — This file.

---

## Development Environment

We worked on two different systems:

1. **Joan Stiven Peralta Bedoya** — Manjaro Linux  
   - Installed GHC via [GHCup](https://www.haskell.org/ghcup/).  
   - Commands used:
     ```bash
     curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
     ghcup install ghc latest
     ghcup set ghc latest
     ```
   - Verified with:
     ```bash
     ghc --version
     ghci --version
     ```

2. **Esteban Alvarez Garcia** — Windows 11  
   - Installed **GHCup for Windows** following the official [installation guide](https://www.haskell.org/ghcup/install/).  
   - Added `C:\ghcup\bin` to PATH (automatically done by installer).  
   - Verified with PowerShell:
     ```powershell
     ghc --version
     ghci --version
     ```

Both environments successfully compiled and executed the program with **GHC 9.12.2**.

---

## How to Build and Run

Compile:
```bash
ghc ChurchBool.hs -o hw1

Run:
./hw1


Interactive with GHCI:

ghci ChurchBool.hs
*Main> testing
*Main> cIf cTrue "hello" "bye"
"hello"
*Main> show (cNot cTrue)
"cFalse"

Expected Output

cIf cTrue 42 24 = 42  
cIf cFalse cTrue cFalse = cFalse  
cNot cTrue = cFalse  
cAnd cTrue cFalse = cFalse  
cOr cTrue cFalse = cTrue
```

### Background: Church Booleans

Church encoding represents Boolean logic using pure λ-calculus. Each Boolean operation is defined as a higher-order function:

| Concept   | λ-Calculus Definition     | Haskell Equivalent     | Behavior Description                     |
|-----------|---------------------------|------------------------|------------------------------------------|
| `cTrue`   | `λx.λy.x`                 | `\x y -> x`            | Selects the first argument (True)        |
| `cFalse`  | `λx.λy.y`                 | `\x y -> y`            | Selects the second argument (False)      |
| `cIf`     | `b x y = b x y`           | `cb x y = cb x y`      | Conditional: returns x if cb is True     |
| `cNot`    | `b False True`            | `b cFalse cTrue`       | Logical negation                         |
| `cAnd`    | `p q False`               | `p q cFalse`           | Logical conjunction                      |
| `cOr`     | `p True q`                | `p cTrue q`            | Logical disjunction                      |

These functions satisfy the expected truth tables when evaluated.


### Logical Analysis

To validate correctness, we compare Church Boolean operations with classical logic:

| Expression                  | Result    |
|----------------------------|-----------|
| `cIf cTrue x y`            | `x`       |
| `cIf cFalse x y`           | `y`       |
| `cNot cTrue`               | `cFalse`  |
| `cNot cFalse`              | `cTrue`   |
| `cAnd cTrue cTrue`         | `cTrue`   |
| `cAnd cTrue cFalse`        | `cFalse`  |
| `cAnd cFalse cTrue`        | `cFalse`  |
| `cOr cTrue cFalse`         | `cTrue`   |
| `cOr cFalse cFalse`        | `cFalse`  |

These results confirm that our λ-encoded functions behave identically to classical Boolean logic.

#### Supporting Material & References

- Church encoding (Wikipedia)
- Rank-N types in Haskell (HaskellWiki)
- GHC User’s Guide — RankNTypes
- GHCup installer
- Blog — Church Booleans in Haskell (and Morte!)
- Blog — Church-encoded Boolean values (P. M. Ploeh)
- GitHub — Haskell church encodings
- Stack Overflow — Church booleans in STLC
- Reddit — Church Booleans in Haskell

#### Use of AI (ChatGPT)

We used ChatGPT (OpenAI) to:
- Clarify λ-calculus concepts and β-reduction.
- Explain Haskell type system (forall, Rank2Types, polymorphism).
- Review and complete function definitions.
- Suggest tests, desk-checks, and clean code practices.
- Improve documentation and structure of this README.md.

#### Acknowledgements
- Professor Andrés Sicard-Ramírez for the assignment and academic guidance.
- Open-source community resources cited above.
- ChatGPT (OpenAI) for explanations, guidance, and documentation support.
