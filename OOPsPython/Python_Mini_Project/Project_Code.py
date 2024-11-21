import random
import tkinter as tk
from tkinter import messagebox


class SnakeAndLadder:
    def __init__(self, root):
        self.root = root
        self.root.title("Snake and Ladder Game")
        self.board_size = 10
        self.grid_size = 600 // self.board_size
        self.ladders = {}
        self.snakes = {}
        self.player_position = 1
        self.last_position = None
        self.dice_rolls = 0

        self.initialize_board()
        self.create_ladders_and_snakes()

    def initialize_board(self):
        self.canvas = tk.Canvas(self.root, width=600, height=600, bg="white")
        self.canvas.pack()

        # Draw the board and add numbers
        self.board_labels = {}
        for row in range(self.board_size):
            for col in range(self.board_size):
                num = (
                    (self.board_size - 1 - row) * self.board_size + (col + 1)
                    if row % 2 == 0
                    else (self.board_size - 1 - row) * self.board_size
                    + (self.board_size - col)
                )
                x1, y1 = col * self.grid_size, row * self.grid_size
                x2, y2 = x1 + self.grid_size, y1 + self.grid_size
                rect_id = self.canvas.create_rectangle(
                    x1, y1, x2, y2, fill="white", outline="black"
                )
                text_id = self.canvas.create_text(
                    (x1 + x2) // 2, (y1 + y2) // 2, text=str(num), fill="black", font=("Arial", 10)
                )
                self.board_labels[num] = (rect_id, text_id)

        # Add position labels and dice button
        self.info_label = tk.Label(
            self.root,
            text="Last Position: N/A\nCurrent Position: 1\nDice Roll: \nNumber of Chances: 0",
            font=("Arial", 14),
            justify="left",
        )
        self.info_label.pack()
        self.roll_button = tk.Button(self.root, text="Roll Dice", command=self.roll_dice)
        self.roll_button.pack()

    def create_ladders_and_snakes(self):
        all_positions = list(range(2, 100))
        random.shuffle(all_positions)

        ladder_positions = sorted(all_positions[:14])
        self.ladders = {ladder_positions[i]: ladder_positions[i + 7] for i in range(7)}
        snake_positions = sorted(all_positions[14:28], reverse=True)
        self.snakes = {snake_positions[i]: snake_positions[i + 7] for i in range(7)}

        # Paint the ladders and snakes on the board
        for start, end in self.ladders.items():
            self.paint_cell(start, "light green")
            self.paint_cell(end, "green")
        for start, end in self.snakes.items():
            self.paint_cell(start, "light coral")
            self.paint_cell(end, "red")

    def paint_cell(self, position, color, font_color="black"):
        rect_id, text_id = self.board_labels[position]
        self.canvas.itemconfig(rect_id, fill=color)
        self.canvas.itemconfig(text_id, fill=font_color)

    def roll_dice(self):
        dice = random.randint(1, 6)
        self.dice_rolls += 1

        # Waiting for a 6 to start
        if self.player_position == 1:
            if dice != 6:
                self.update_info_label(last="N/A", current=self.player_position, dice=dice)
                return
            else:
                self.last_position = self.player_position
                self.player_position = 2
                self.update_info_label(last=self.last_position, current=self.player_position, dice=dice)
                self.update_board()
                return

        # Move player
        self.last_position = self.player_position
        new_position = self.player_position + dice
        if new_position > 100:
            new_position = self.player_position  # Don't exceed 100

        # Check for ladders or snakes
        if new_position in self.ladders:
            start = new_position
            new_position = self.ladders[new_position]
            messagebox.showinfo(
                "Ladder!", f"You climbed a ladder from {start} to {new_position}!"
            )
        elif new_position in self.snakes:
            start = new_position
            new_position = self.snakes[new_position]
            messagebox.showinfo(
                "Snake!", f"You got bitten by a snake! You slide from {start} to {new_position}!"
            )

        self.player_position = new_position
        self.update_info_label(last=self.last_position, current=self.player_position, dice=dice)
        self.update_board()

        # Check for win
        if self.player_position == 100:
            messagebox.showinfo("Congratulations!", f"You won the game in {self.dice_rolls} rolls!")
            self.reset_game()

    def update_board(self):
        for num, (rect_id, text_id) in self.board_labels.items():
            if num == self.player_position:
                self.canvas.itemconfig(rect_id, fill="blue")
                self.canvas.itemconfig(text_id, fill="white")  # Font color for current position
            elif num in self.ladders.keys():
                self.paint_cell(num, "light green")
            elif num in self.ladders.values():
                self.paint_cell(num, "green")
            elif num in self.snakes.keys():
                self.paint_cell(num, "light coral")
            elif num in self.snakes.values():
                self.paint_cell(num, "red")
            else:
                self.canvas.itemconfig(rect_id, fill="white")
                self.canvas.itemconfig(text_id, fill="black")  # Ensure text is visible

    def update_info_label(self, last, current, dice):
        self.info_label.config(
            text=f"Last Position: {last}\nCurrent Position: {current}\nDice Roll: {dice}\nNumber of Chances: {self.dice_rolls}"
        )

    def reset_game(self):
        self.player_position = 1
        self.last_position = None
        self.dice_rolls = 0
        self.update_info_label(last="N/A", current=self.player_position, dice="N/A")
        self.update_board()


if __name__ == "__main__":
    root = tk.Tk()
    game = SnakeAndLadder(root)
    root.mainloop()
