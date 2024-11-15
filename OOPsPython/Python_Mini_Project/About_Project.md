# Sudoku Puzzle Game

An interactive and feature-rich implementation of the classic Sudoku game, designed to challenge your logic and problem-solving skills. Built using Python's `tkinter` library, this game offers an engaging experience with additional functionality like a timer, a fail counter, and a hint system to assist players.

---

## Features

### Dynamic Puzzle Generation
- Generates a unique Sudoku puzzle on every run.
- Predefined numbers are displayed in **white** for clear differentiation.

### Input Validation
- Only allows single-digit numbers (1–9) as valid input.
- Highlights incorrect inputs in **red** during validation.

### Validation System
- Players can validate their progress at any time.
- Mistakes are highlighted, and a fail counter tracks incorrect attempts (maximum of 5 fails allowed).

### Hint System
- Provides up to **3 hints** per game.
- Revealed hints are displayed in **green** for easy recognition.

### Timer
- Tracks the total time taken to solve the puzzle, encouraging efficiency and faster gameplay.

### Reset Option
- Allows players to reset the grid to its initial state and start fresh.

---

## How to Play

1. Start the game to see a Sudoku grid with some numbers preloaded.
2. Fill in the missing numbers to complete the puzzle, ensuring:
   - Each row contains digits 1–9 without repetition.
   - Each column contains digits 1–9 without repetition.
   - Each 3x3 subgrid contains digits 1–9 without repetition.
3. Use the **Validate** button to check for correctness.
4. If stuck, use the **Hint** button (maximum 3 hints per game) to reveal correct numbers.
5. Solve the puzzle before reaching the fail limit of 5 incorrect validations or reset to start again.

---

## Technologies Used

- **Python**: Core programming language.
- **Tkinter**: For GUI development.
- **Random**: To dynamically generate Sudoku puzzles.
- **Time**: For timer functionality.

---
