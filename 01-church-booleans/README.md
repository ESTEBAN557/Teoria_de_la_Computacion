# 🧠 HW1 — Church Booleans

## Academic Context

**Course:** SI1001 — Theory of Computation  
**Professor:** Andrés Sicard-Ramírez  
**Institution:** EAFIT University  
**Creation Date:** 19th August 2025  
**Version:** 0.1

---

## 👥 Team Members

- Joan Stiven Peralta Bedoya
- Esteban Alvarez Garcia

---

# 📌 Project Description

This homework implements **Church’s encoding of Boolean logic** in Haskell using pure λ-calculus representations.

The project defines the following λ-encoded Boolean operations:

- `cTrue`
- `cFalse`
- `cIf`
- `cNot`
- `cAnd`
- `cOr`

---

## Constraints

The implementation follows these restrictions:

- Only λ-terms are allowed
- No use of Haskell’s built-in `Bool` type
- No use of:
  - `if-then-else`
  - `case` expressions

The goal is to simulate Boolean logic entirely through higher-order functions.

---

# 📁 Repository Contents

```bash
📦 01-church-booleans
 ┣ 📄 ChurchBool.hs
 ┗ 📄 README.md
```

### Files

| File | Description |
|---|---|
| `ChurchBool.hs` | Church Boolean implementation and test driver |
| `README.md` | Project documentation |

---

# ⚙️ Development Environment

The project was developed and tested on different operating systems.

---

## Joan Stiven Peralta Bedoya

### Environment

- Manjaro Linux
- GHC installed through GHCup

### Installation Commands

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
ghcup install ghc latest
ghcup set ghc latest
```

### Verification

```bash
ghc --version
ghci --version
```

---

## Esteban Alvarez Garcia

### Environment

- Windows 11
- GHCup for Windows

### Verification (PowerShell)

```powershell
ghc --version
ghci --version
```

Both environments successfully compiled and executed the project using:

```text
GHC 9.12.2
```

---

# ▶️ Compilation and Execution

## Compile

```bash
ghc ChurchBool.hs -o hw1
```

---

## Run

### Linux / WSL

```bash
./hw1
```

### Windows PowerShell

```powershell
.\hw1.exe
```

---

## Interactive Execution with GHCI

```bash
ghci ChurchBool.hs
```

Examples:

```haskell
*Main> testing
*Main> cIf cTrue "hello" "bye"
"hello"

*Main> show (cNot cTrue)
"cFalse"
```

---

# 🧪 Expected Output

```text
cIf cTrue 42 24 = 42
cIf cFalse cTrue cFalse = cFalse
cNot cTrue = cFalse
cAnd cTrue cFalse = cFalse
cOr cTrue cFalse = cTrue
```

---

# 📚 Background — Church Booleans

Church encoding represents Boolean logic using pure λ-calculus.

Each Boolean operation is represented as a higher-order function.

---

## λ-Calculus Definitions

| Concept | λ-Calculus Definition | Haskell Equivalent | Description |
|---|---|---|---|
| `cTrue` | `λx.λy.x` | `\x y -> x` | Selects first argument |
| `cFalse` | `λx.λy.y` | `\x y -> y` | Selects second argument |
| `cIf` | `b x y = b x y` | `cb x y = cb x y` | Conditional evaluation |
| `cNot` | `b False True` | `b cFalse cTrue` | Logical negation |
| `cAnd` | `p q False` | `p q cFalse` | Logical conjunction |
| `cOr` | `p True q` | `p cTrue q` | Logical disjunction |

These functions satisfy classical Boolean truth tables through λ-reduction.

---

# 🔍 Logical Validation

To validate correctness, the Church Boolean operations were compared against classical Boolean logic.

| Expression | Result |
|---|---|
| `cIf cTrue x y` | `x` |
| `cIf cFalse x y` | `y` |
| `cNot cTrue` | `cFalse` |
| `cNot cFalse` | `cTrue` |
| `cAnd cTrue cTrue` | `cTrue` |
| `cAnd cTrue cFalse` | `cFalse` |
| `cAnd cFalse cTrue` | `cFalse` |
| `cOr cTrue cFalse` | `cTrue` |
| `cOr cFalse cFalse` | `cFalse` |

These results confirm that the λ-encoded functions behave equivalently to classical Boolean operators.

---

# 🧠 Concepts Applied

This project applies concepts from:

- Lambda Calculus
- Church Encoding
- Functional Programming
- Higher-Order Functions
- Boolean Logic
- Type Systems
- β-Reduction
- Formal Computation Models

---

# 📖 References

- Church encoding (Wikipedia)
- Rank-N Types in Haskell (HaskellWiki)
- GHC User’s Guide — RankNTypes
- GHCup Installer
- Church Booleans in Haskell (and Morte!)
- Church-encoded Boolean Values — P. M. Ploeh
- Haskell Church Encodings (GitHub)
- Stack Overflow — Church Booleans in STLC
- Reddit — Church Booleans in Haskell

---

# 🤖 Use of AI (ChatGPT)

ChatGPT (OpenAI) was used to:

- Clarify λ-calculus concepts and β-reduction
- Explain Haskell polymorphism and Rank-N types
- Review and refine function definitions
- Suggest tests and desk-checks
- Improve documentation and README structure

---

# 🙏 Acknowledgements

- Professor Andrés Sicard-Ramírez for the assignment and academic guidance
- Open-source community resources referenced above
- ChatGPT (OpenAI) for conceptual explanations and documentation support
