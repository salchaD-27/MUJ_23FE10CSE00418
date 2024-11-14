import tkinter as tk
from tkinter import messagebox
import json
import random
import os

# Define the paths for leaderboard and users files in the same directory
LEADERBOARD_FILE = os.path.join(os.path.dirname(__file__), 'leaderboard.json')
USERS_FILE = os.path.join(os.path.dirname(__file__), 'users.json')

# Extended quiz data
quiz_data = {
    "Science": [
        {"question": "What planet is known as the Red Planet?", "answer": "Mars", "hint": "It's the fourth planet from the Sun."},
        {"question": "What is the chemical symbol for water?", "answer": "H2O", "hint": "Two hydrogen atoms and one oxygen atom."},
        {"question": "Who developed the theory of relativity?", "answer": "Einstein", "hint": "He is known for E=mc^2."},
        {"question": "What gas do plants absorb from the atmosphere?", "answer": "Carbon dioxide", "hint": "It is also known as CO2."},
        {"question": "What is the powerhouse of the cell?", "answer": "Mitochondria", "hint": "It's an organelle found in cells."}
    ],
    "Geography": [
        {"question": "What is the capital of France?", "answer": "Paris", "hint": "Known as the city of lights."},
        {"question": "Which country has the largest population?", "answer": "China", "hint": "Located in Asia."},
        {"question": "What is the longest river in the world?", "answer": "Nile", "hint": "It flows through northeastern Africa."},
        {"question": "Which desert is the largest in the world?", "answer": "Sahara", "hint": "Located in Africa."},
        {"question": "Which country has the most natural lakes?", "answer": "Canada", "hint": "It is in North America."}
    ],
    "History": [
        {"question": "Who was the first President of the United States?", "answer": "George Washington", "hint": "He is on the U.S. dollar bill."},
        {"question": "What year did World War II end?", "answer": "1945", "hint": "It ended in the mid-1940s."},
        {"question": "Who was known as the Iron Lady?", "answer": "Margaret Thatcher", "hint": "She was a British Prime Minister."},
        {"question": "What ancient civilization built the pyramids?", "answer": "Egyptians", "hint": "They thrived along the Nile."},
        {"question": "In what city was the Titanic built?", "answer": "Belfast", "hint": "A city in Northern Ireland."}
    ]
}

def load_leaderboard():
    try:
        with open(LEADERBOARD_FILE, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return {}

def save_leaderboard(leaderboard):
    with open(LEADERBOARD_FILE, 'w') as f:
        json.dump(leaderboard, f)

def load_users():
    try:
        with open(USERS_FILE, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return {}

def save_users(users):
    with open(USERS_FILE, 'w') as f:
        json.dump(users, f)

class QuizApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Quiz Application")
        self.current_user = None
        self.current_score = 0
        self.timer = 10
        self.users = load_users()

        # Main frame
        self.main_frame = tk.Frame(self.root)
        self.main_frame.pack(pady=20)
        self.show_login_screen()

    def show_login_screen(self):
        self.clear_frame()
        tk.Label(self.main_frame, text="Quiz Login", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        tk.Label(self.main_frame, text="Username:").grid(row=1, column=0)
        self.username_entry = tk.Entry(self.main_frame)
        self.username_entry.grid(row=1, column=1)

        tk.Label(self.main_frame, text="Password:").grid(row=2, column=0)
        self.password_entry = tk.Entry(self.main_frame, show="*")
        self.password_entry.grid(row=2, column=1)

        tk.Button(self.main_frame, text="Login", command=self.login).grid(row=3, column=0, pady=10)
        tk.Button(self.main_frame, text="Register", command=self.register).grid(row=3, column=1)

    def clear_frame(self):
        for widget in self.main_frame.winfo_children():
            widget.destroy()

    def register(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        if username in self.users:
            messagebox.showerror("Error", "Username already exists")
        else:
            self.users[username] = {"password": password, "score": 0}
            save_users(self.users)
            messagebox.showinfo("Success", f"User {username} registered successfully!")

    def login(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        if username in self.users and self.users[username]["password"] == password:
            self.current_user = username
            self.show_category_screen()
        else:
            messagebox.showerror("Error", "Invalid login credentials")

    def show_category_screen(self):
        self.clear_frame()
        tk.Label(self.main_frame, text=f"Welcome, {self.current_user}", font=("Arial", 16)).pack()
        tk.Label(self.main_frame, text="Choose a category:", font=("Arial", 14)).pack(pady=10)

        for category in quiz_data.keys():
            tk.Button(self.main_frame, text=category, command=lambda c=category: self.start_quiz(c)).pack(pady=5)

        tk.Button(self.main_frame, text="View Leaderboard", command=self.show_leaderboard).pack(pady=10)
        tk.Button(self.main_frame, text="Logout", command=self.show_login_screen).pack(pady=5)

    def start_quiz(self, category):
        self.category = category
        self.questions = quiz_data[category]
        self.current_score = 0
        self.current_question = 0
        self.show_question()

    def show_question(self):
        self.clear_frame()
        question = self.questions[self.current_question]
        
        tk.Label(self.main_frame, text=f"Category: {self.category}", font=("Arial", 14)).pack()
        tk.Label(self.main_frame, text=f"Question {self.current_question + 1}: {question['question']}", font=("Arial", 12)).pack(pady=10)
        
        self.hint_used = False
        self.answer_entry = tk.Entry(self.main_frame)
        self.answer_entry.pack(pady=5)
        
        tk.Button(self.main_frame, text="Submit Answer", command=self.check_answer).pack(pady=5)
        tk.Button(self.main_frame, text="Get Hint", command=lambda: messagebox.showinfo("Hint", question["hint"])).pack(pady=5)

    def check_answer(self):
        question = self.questions[self.current_question]
        answer = self.answer_entry.get().strip()

        if answer.lower() == question["answer"].lower():
            points = 10 if not self.hint_used else 5
            self.current_score += points
            messagebox.showinfo("Correct!", f"Correct! You earned {points} points.")
        else:
            messagebox.showinfo("Incorrect", "Incorrect answer. Try again.")

        self.next_question()

    def next_question(self):
        self.current_question += 1
        if self.current_question < len(self.questions):
            self.show_question()
        else:
            self.end_quiz()

    def end_quiz(self):
        messagebox.showinfo("Quiz Completed", f"Quiz finished! Your score is {self.current_score}.")
        leaderboard = load_leaderboard()
        leaderboard[self.current_user] = max(leaderboard.get(self.current_user, 0), self.current_score)
        save_leaderboard(leaderboard)
        self.show_category_screen()

    def show_leaderboard(self):
        leaderboard = load_leaderboard()
        sorted_leaderboard = sorted(leaderboard.items(), key=lambda x: x[1], reverse=True)
        
        self.clear_frame()
        tk.Label(self.main_frame, text="--- Leaderboard ---", font=("Arial", 16)).pack()
        
        for rank, (user, score) in enumerate(sorted_leaderboard, start=1):
            tk.Label(self.main_frame, text=f"{rank}. {user}: {score}").pack()
        
        tk.Button(self.main_frame, text="Back to Categories", command=self.show_category_screen).pack(pady=10)

if __name__ == "__main__":
    root = tk.Tk()
    app = QuizApp(root)
    root.mainloop()
