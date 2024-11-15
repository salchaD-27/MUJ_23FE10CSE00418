import tkinter as tk
from tkinter import messagebox
import random
import time


class SudokuGame:
    def __init__(self, root):
        self.root = root
        self.root.title("Sudoku Game")
        self.root.geometry("400x500")

        # Sudoku grid (9x9)
        self.grid = self.generate_puzzle()
        self.solution = self.solve_puzzle([row[:] for row in self.grid])

        # Tkinter Entry Widgets
        self.entries = [[None for _ in range(9)] for _ in range(9)]

        # Counters and Limits
        self.fail_count = 0
        self.hint_count = 0
        self.start_time = time.time()

        # UI Setup
        self.create_ui()

    def create_ui(self):
        """Create the Sudoku grid, timer, and control buttons."""
        # Timer label
        self.timer_label = tk.Label(self.root, text="Time: 0 sec", font=("Helvetica", 14))
        self.timer_label.pack(pady=5)

        # Sudoku grid
        frame = tk.Frame(self.root)
        frame.pack(pady=10)

        for row in range(9):
            for col in range(9):
                value = self.grid[row][col]
                entry = tk.Entry(
                    frame,
                    width=2,
                    font=("Helvetica", 18),
                    justify="center",
                    fg="white" if value != 0 else "black",
                    bg="black" if value != 0 else "white",
                )
                entry.grid(row=row, column=col, padx=5, pady=5)
                if value != 0:
                    entry.insert(0, str(value))
                    entry.config(state="disabled")
                else:
                    # Bind input validation
                    entry.bind("<KeyRelease>", lambda e, r=row, c=col: self.validate_input(r, c))
                self.entries[row][col] = entry

        # Control buttons
        control_frame = tk.Frame(self.root)
        control_frame.pack(pady=10)

        tk.Button(control_frame, text="Validate", command=self.validate).pack(side=tk.LEFT, padx=10)
        tk.Button(control_frame, text="Hint", command=self.get_hint).pack(side=tk.LEFT, padx=10)
        tk.Button(control_frame, text="Reset", command=self.reset_grid).pack(side=tk.LEFT, padx=10)

        # Timer update
        self.update_timer()

    def update_timer(self):
        """Update the timer label."""
        elapsed_time = int(time.time() - self.start_time)
        self.timer_label.config(text=f"Time: {elapsed_time} sec")
        self.root.after(1000, self.update_timer)

    def reset_grid(self):
        """Reset the Sudoku grid to its initial state."""
        self.fail_count = 0
        self.hint_count = 0
        self.start_time = time.time()
        for row in range(9):
            for col in range(9):
                entry = self.entries[row][col]
                if self.grid[row][col] == 0:
                    entry.delete(0, tk.END)
                    entry.config(state="normal", bg="white", fg="black")
                else:
                    entry.config(state="disabled", bg="black", fg="white")

    def validate(self):
        """Validate the current Sudoku grid."""
        user_grid = self.get_user_grid()
        errors = 0

        for row in range(9):
            for col in range(9):
                entry = self.entries[row][col]
                if self.solution[row][col] != user_grid[row][col]:
                    entry.config(bg="red")
                    errors += 1
                else:
                    entry.config(bg="white")

        if errors == 0:
            messagebox.showinfo("Success", "Congratulations! You solved the Sudoku!")
        else:
            self.fail_count += 1
            messagebox.showwarning("Incorrect", f"There are {errors} mistakes. Fail count: {self.fail_count}/5.")
            if self.fail_count >= 5:
                messagebox.showerror("Game Over", "You failed 5 times. Game over!")
                self.reset_grid()

    def get_hint(self):
        """Provide a hint to the user."""
        if self.hint_count >= 3:
            messagebox.showwarning("No Hints Left", "You have used all 3 hints!")
            return

        empty_cells = [(row, col) for row in range(9) for col in range(9) if not self.entries[row][col].get()]
        if not empty_cells:
            messagebox.showinfo("No Hints Needed", "The grid is already filled!")
            return

        row, col = random.choice(empty_cells)
        self.entries[row][col].insert(0, str(self.solution[row][col]))
        self.entries[row][col].config(state="disabled", disabledforeground="green")
        self.hint_count += 1
        messagebox.showinfo("Hint Used", f"Hint {self.hint_count}/3 used.")

    def get_user_grid(self):
        """Retrieve the current grid values entered by the user."""
        grid = [[0 for _ in range(9)] for _ in range(9)]
        for row in range(9):
            for col in range(9):
                value = self.entries[row][col].get()
                grid[row][col] = int(value) if value.isdigit() else 0
        return grid

    def validate_input(self, row, col):
        """Ensure only single-digit values (1-9) are allowed."""
        entry = self.entries[row][col]
        value = entry.get()
        if not (value.isdigit() and 1 <= int(value) <= 9):
            entry.delete(0, tk.END)

    def generate_puzzle(self):
        """Generate a Sudoku puzzle with a valid solution."""
        base_grid = self.solve_puzzle([[0] * 9 for _ in range(9)])  # Start with a solved grid
        for _ in range(40):  # Remove 40 cells for the puzzle
            row, col = random.randint(0, 8), random.randint(0, 8)
            base_grid[row][col] = 0
        return base_grid

    def solve_puzzle(self, grid):
        """Solve a Sudoku grid using backtracking."""
        for row in range(9):
            for col in range(9):
                if grid[row][col] == 0:
                    for num in range(1, 10):
                        if self.can_place(grid, row, col, num):
                            grid[row][col] = num
                            if self.solve_puzzle(grid):
                                return grid
                            grid[row][col] = 0
                    return False
        return grid

    def can_place(self, grid, row, col, num):
        """Check if a number can be placed in the specified cell."""
        for i in range(9):
            if grid[row][i] == num or grid[i][col] == num:
                return False

        start_row, start_col = 3 * (row // 3), 3 * (col // 3)
        for r in range(start_row, start_row + 3):
            for c in range(start_col, start_col + 3):
                if grid[r][c] == num:
                    return False

        return True


# Run the game
if __name__ == "__main__":
    root = tk.Tk()
    game = SudokuGame(root)
    root.mainloop()
