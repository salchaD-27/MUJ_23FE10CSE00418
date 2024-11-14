import tkinter as tk
from tkinter import *
from tkinter import messagebox
import random
import time

root = tk.Tk()
root.title("Numericket: The Numeric Cricket")
root.geometry("1654x1227")

# Initializing Frames
matchSettings_frame = tk.Frame(root)
toss_frame = tk.Frame(root)
continueToss_frame = tk.Frame(root)
playerBatting_frame = tk.Frame(root)
playerBowling_frame = tk.Frame(root)

def hide_all_frames():
    for widget in root.winfo_children():
        widget.pack_forget() 
def flip_x(x):
    return 380 - x

# Match Settings Phase
def matchSettings():
    hide_all_frames()
    matchSettings_frame.pack(fill="both", expand=True)

    ms1_label = tk.Label(matchSettings_frame, text="Match Settings", font=('Time New Roman', 54, 'bold'))
    ms1_label.place(x=638, y=54)
    ms2_label = tk.Label(matchSettings_frame, text="Enter Number of Matches", font=('Time New Roman', 17))
    ms2_label.place(x=727, y=327)
    matches_input = tk.Entry(matchSettings_frame, font=('Times New Roman', 22), width=38, justify=CENTER)
    matches_input.place(x=617, y=354)

    def continueGame():
        try:
            global matches
            matches = int(matches_input.get())
            messagebox.showinfo("Success", f"Starting Game of {matches} matches.")
            toss(matches)
        except ValueError:
            messagebox.showerror("ValueError", "Value for number of matches can only be numeric")

    continue_button = Button(matchSettings_frame, text="Continue", command=continueGame, font=('Time New Roman', 17, 'bold'), fg='black', bg='white', padx=20, pady=10, relief='groove')
    continue_button.place(x=688, y=427)
    exit_button = Button(matchSettings_frame, text="Exit", command=root.destroy, font=('Time New Roman', 17, 'bold'), fg='black', bg='white', padx=20, pady=10, relief='groove')
    exit_button.place(x=854, y=427)

# Toss Phase
def toss(matches):
    hide_all_frames()
    toss_frame.pack(fill="both", expand=True)

    toss_label = tk.Label(toss_frame, text="Toss", font=('Time New Roman', 54, 'bold'))
    toss_label.pack(anchor='n', pady=54)
    t1_label = tk.Label(toss_frame, text="You Choose:", font=('Time New Roman', 17))
    t1_label.pack(anchor='n', pady=54)

    head_button = Button(toss_frame, text="Head", command=lambda: continueToss(1), font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
    head_button.pack(side=LEFT, padx=254)
    tail_button = Button(toss_frame, text="Tail", command=lambda: continueToss(2), font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
    tail_button.pack(side=RIGHT, padx=254)

def continueToss(n):
        hide_all_frames()
        continueToss_frame.pack(fill="both", expand=True)

        toss_label = tk.Label(continueToss_frame, text="Toss", font=('Time New Roman', 54, 'bold'))
        toss_label.pack(anchor='n', pady=54)
        toss_result = random.choice([1, 2])
        if n==toss_result:
            t1_label = tk.Label(continueToss_frame, text="You Won. You Choose:", font=('Time New Roman', 17))
            t1_label.pack(anchor='n', pady=54)
            head_button = Button(continueToss_frame, text="Batting", command=playerBatting, font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
            head_button.pack(side=LEFT, padx=254)
            tail_button = Button(continueToss_frame, text="Bowling", command=playerBowling, font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
            tail_button.pack(side=RIGHT, padx=254)
        else:
            system_choice=random.choice(["Bat", "Bowl"])
            t1_label = tk.Label(continueToss_frame, text=f"Sytem Won. System Chose To {system_choice}", font=('Time New Roman', 17))
            t1_label.pack(anchor='n', pady=54)
            if system_choice=="Bat":
                head_button = Button(continueToss_frame, text="Contine", command=playerBowling, font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
                head_button.pack(side=LEFT, padx=254)
                tail_button = Button(continueToss_frame, text="Exit", command=root.destroy, font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
                tail_button.pack(side=RIGHT, padx=254)
            else:
                head_button = Button(continueToss_frame, text="Contine", command=playerBatting, font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
                head_button.pack(side=LEFT, padx=254)
                tail_button = Button(continueToss_frame, text="Exit", command=root.destroy, font=('Time New Roman', 27, 'bold'), fg='black', bg='white', padx=54, pady=27, relief='groove')
                tail_button.pack(side=RIGHT, padx=254)

# Player Batting Phase
def playerBatting():
    hide_all_frames()
    playerBatting_frame.pack(fill="both", expand=True)
    toss_label = tk.Label(playerBatting_frame, text="Batting", font=('Time New Roman', 54, 'bold'))
    toss_label.pack(anchor='n', pady=54)
    match_label = tk.Label(playerBatting_frame, text="Match 1", font=('Time New Roman', 17))
    match_label.pack(anchor='n', pady=54)

    for i in range(matches):
            match_label.config(playerBatting_frame, text=f"Match {i+1}", font=('Time New Roman', 17))
            # Canvas1 for Player Move
            canvas1 = Canvas(playerBatting_frame, width=380, height=380, bg=None)
            canvas1.pack(side=LEFT, anchor="n", padx=170, pady=170)
            canvas1.create_text(200, 354, text="Your Move", font=('TIme New Roman', 24, 'bold'), fill='white', anchor='center', justify='center')
            # Canvas2 for System Move
            canvas2 = Canvas(playerBatting_frame, width=380, height=380, bg=None)
            canvas2.pack(side=RIGHT, anchor="n", padx=170, pady=170)
            canvas2.create_text(200, 354, text="System Move", font=('TIme New Roman', 24, 'bold'), fill='white', anchor='center', justify='center')
            
            def playerMove(n):
                canvas1Hand(n)
                system_move=random.choice([1,2,3,4,5,6,7,8,9,10])
                def canvas2Hand(system_move):
                    canvas2.create_line(flip_x(86.5), 287.2, flip_x(186.5), 287.2, fill="black", width=4)
                    canvas2.create_line(flip_x(86.5), 287.2, flip_x(86.5), 199.2, fill="black", width=4)
                    canvas2.create_line(flip_x(213.5), 199.2, flip_x(86.5), 199.2, fill="black", width=4)
                    canvas2.create_line(flip_x(213.5), 199.2, flip_x(213.5), 253.2, fill="black", width=4)
                    canvas2.create_line(flip_x(186.5), 287.2, flip_x(213.5), 253.2, fill="black", width=4)
                    if n==1:
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                    if n==2:
                        canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                    if n==3:
                        canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
                    if n==4:
                        canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(86.5), 199.2, flip_x(114.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(86.5), 139.2, flip_x(114.5), 84.2, fill=None, width=4, outline="black")
                    if n==5:
                        canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(86.5), 199.2, flip_x(114.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(86.5), 139.2, flip_x(114.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
                        canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
                        canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
                    if n==6:
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
                        canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
                        canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
                    if n==7:
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
                        canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
                        canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                    if n==8:
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
                        canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
                        canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
                    if n==9:
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
                        canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
                        canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
                        canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
                        canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
                    if n==10:
                        pass
                canvas2Hand(system_move)
                
                if system_move!=n:
                    updateScore()
                else:
                    playerOut()

            def canvas1Hand(n):
                canvas1.create_line(86.5, 287.2, 186.5, 287.2, fill="black", width=4)
                canvas1.create_line(86.5, 287.2, 86.5, 199.2, fill="black", width=4)
                canvas1.create_line(213.5, 199.2, 86.5, 199.2, fill="black", width=4)
                canvas1.create_line(213.5, 199.2, 213.5, 253.2, fill="black", width=4)
                canvas1.create_line(186.5, 287.2, 213.5, 253.2, fill="black", width=4)
                if n==1:
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                if n==2:
                    canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                if n==3:
                    canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")   
                if n==4:
                    canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")   
                    canvas1.create_rectangle(86.5, 199.2, 114.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(86.5, 139.2, 114.5, 84.2, fill=None, width=4, outline="black")
                if n==5:
                    canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")   
                    canvas1.create_rectangle(86.5, 199.2, 114.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(86.5, 139.2, 114.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
                    canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
                    canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
                    canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
                if n==6:
                    canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
                    canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
                    canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
                    canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
                if n==7:
                    canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
                    canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
                    canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
                    canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                if n==8:
                    canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
                    canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
                    canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
                    canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
                if n==9:
                    canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
                    canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
                    canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
                    canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
                    canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
                    canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
                    canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")
                if n==10:
                    pass
            button1 = tk.Button(playerBatting_frame, text="1", command=lambda: playerMove(1), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, anchor='center', relief='groove')
            button1.place(x=170, y=600)
            button2 = tk.Button(playerBatting_frame, text="2", command=lambda: playerMove(2), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button2.place(x=270, y=600)
            button3 = tk.Button(playerBatting_frame, text="3", command=lambda: playerMove(3), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button3.place(x=370, y=600)
            button4 = tk.Button(playerBatting_frame, text="4", command=lambda: playerMove(4), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button4.place(x=470, y=600)
            button5 = tk.Button(playerBatting_frame, text="5", command=lambda: playerMove(5), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button5.place(x=170, y=700)
            button6 = tk.Button(playerBatting_frame, text="6", command=lambda: playerMove(6), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button6.place(x=270, y=700)
            button7 = tk.Button(playerBatting_frame, text="7", command=lambda: playerMove(7), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button7.place(x=370, y=700)
            button8 = tk.Button(playerBatting_frame, text="8", command=lambda: playerMove(8), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button8.place(x=470, y=700)
            button9 = tk.Button(playerBatting_frame, text="9", command=lambda: playerMove(9), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
            button9.place(x=270, y=800)
            button10 = tk.Button(playerBatting_frame, text="10", command=lambda: playerMove(10), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=15, pady=20, relief='groove')
            button10.place(x=370, y=800)
    
    matchResults()



def updateScore(): pass
def playerOut(): pass

# Player Bowling Phase
def playerBowling(): pass

# Match Results Phase
def matchResults(): pass

matchSettings()
root.mainloop()







# # Canvas1 for Player Move
# canvas1 = Canvas(root, width=380, height=380, bg="lightgrey")
# canvas1.pack(side=LEFT, anchor="n", padx=170, pady=170)
# canvas1.create_text(200, 354, text="Your Move", font=('TIme New Roman', 24, 'bold'), fill='black', anchor='center', justify='center')
# # Canvas2 for System Move
# canvas2 = Canvas(root, width=380, height=380, bg="lightgrey")
# canvas2.pack(side=RIGHT, anchor="n", padx=170, pady=170)
# canvas2.create_text(200, 354, text="System Move", font=('TIme New Roman', 24, 'bold'), fill='black', anchor='center', justify='center')



# def canvas1Hand(n):
#     canvas1.create_line(86.5, 287.2, 186.5, 287.2, fill="black", width=4)
#     canvas1.create_line(86.5, 287.2, 86.5, 199.2, fill="black", width=4)
#     canvas1.create_line(213.5, 199.2, 86.5, 199.2, fill="black", width=4)
#     canvas1.create_line(213.5, 199.2, 213.5, 253.2, fill="black", width=4)
#     canvas1.create_line(186.5, 287.2, 213.5, 253.2, fill="black", width=4)
#     if n==1:
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#     if n==2:
#         canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#     if n==3:
#         canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")   
#     if n==4:
#         canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")   
#         canvas1.create_rectangle(86.5, 199.2, 114.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(86.5, 139.2, 114.5, 84.2, fill=None, width=4, outline="black")
#     if n==5:
#         canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")   
#         canvas1.create_rectangle(86.5, 199.2, 114.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(86.5, 139.2, 114.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
#         canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
#         canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
#         canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
#     if n==6:
#         canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
#         canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
#         canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
#         canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
#     if n==7:
#         canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
#         canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
#         canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
#         canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#     if n==8:
#         canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
#         canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
#         canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
#         canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
#     if n==9:
#         canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
#         canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
#         canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
#         canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
#         canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)
#         canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
#         canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")
#     if n==10:
#         pass
# def canvas2Hand(n):
#     canvas2.create_line(flip_x(86.5), 287.2, flip_x(186.5), 287.2, fill="black", width=4)
#     canvas2.create_line(flip_x(86.5), 287.2, flip_x(86.5), 199.2, fill="black", width=4)
#     canvas2.create_line(flip_x(213.5), 199.2, flip_x(86.5), 199.2, fill="black", width=4)
#     canvas2.create_line(flip_x(213.5), 199.2, flip_x(213.5), 253.2, fill="black", width=4)
#     canvas2.create_line(flip_x(186.5), 287.2, flip_x(213.5), 253.2, fill="black", width=4)
#     if n==1:
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#     if n==2:
#         canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#     if n==3:
#         canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
#     if n==4:
#         canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(86.5), 199.2, flip_x(114.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(86.5), 139.2, flip_x(114.5), 84.2, fill=None, width=4, outline="black")
#     if n==5:
#         canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(86.5), 199.2, flip_x(114.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(86.5), 139.2, flip_x(114.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
#         canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
#         canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
#     if n==6:
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
#         canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
#         canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
#     if n==7:
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
#         canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
#         canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#     if n==8:
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
#         canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
#         canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
#     if n==9:
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
#         canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
#         canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)
#         canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
#         canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
#     if n==10:
#         pass

# def buttonClick(n): pass

# button1 = tk.Button(root, text="1", command=buttonClick(1), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, anchor='center', relief='groove')
# button1.place(x=170, y=600)
# button2 = tk.Button(root, text="2", command=buttonClick(2), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button2.place(x=270, y=600)
# button3 = tk.Button(root, text="3", command=buttonClick(3), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button3.place(x=370, y=600)
# button4 = tk.Button(root, text="4", command=buttonClick(4), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button4.place(x=470, y=600)
# button5 = tk.Button(root, text="5", command=buttonClick(5), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button5.place(x=170, y=700)
# button6 = tk.Button(root, text="6", command=buttonClick(6), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button6.place(x=270, y=700)
# button7 = tk.Button(root, text="7", command=buttonClick(7), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button7.place(x=370, y=700)
# button8 = tk.Button(root, text="8", command=buttonClick(8), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button8.place(x=470, y=700)
# button9 = tk.Button(root, text="9", command=buttonClick(9), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
# button9.place(x=270, y=800)
# button10 = tk.Button(root, text="10", command=buttonClick(10), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=15, pady=20, relief='groove')
# button10.place(x=370, y=800)

# root.mainloop()

# # Hand1 for Canvas1
# # Palm
# canvas1.create_line(86.5, 287.2, 186.5, 287.2, fill="black", width=4)
# canvas1.create_line(86.5, 287.2, 86.5, 199.2, fill="black", width=4)
# canvas1.create_line(213.5, 199.2, 86.5, 199.2, fill="black", width=4)
# canvas1.create_line(213.5, 199.2, 213.5, 253.2, fill="black", width=4)
# canvas1.create_line(186.5, 287.2, 213.5, 253.2, fill="black", width=4)
# # Finger 1
# canvas1.create_rectangle(86.5, 199.2, 114.5, 144.2, fill=None, width=4, outline="black")
# canvas1.create_rectangle(86.5, 139.2, 114.5, 84.2, fill=None, width=4, outline="black")
# # Finger 2
# canvas1.create_rectangle(119.5, 199.2, 147.5, 144.2, fill=None, width=4, outline="black")
# canvas1.create_rectangle(119.5, 139.2, 147.5, 84.2, fill=None, width=4, outline="black")
# # Finger 3
# canvas1.create_rectangle(152.5, 199.2, 180.5, 144.2, fill=None, width=4, outline="black")
# canvas1.create_rectangle(152.5, 139.2, 180.5, 84.2, fill=None, width=4, outline="black")
# # Finger 4
# canvas1.create_rectangle(185.5, 199.2, 213.5, 144.2, fill=None, width=4, outline="black")
# canvas1.create_rectangle(185.5, 139.2, 213.5, 84.2, fill=None, width=4, outline="black")
# # Thumb
# canvas1.create_line(213.5, 253.2, 267.5, 199.2, fill="black", width=4)
# canvas1.create_line(213.5, 215.2, 229.5, 199.2, fill="black", width=4)
# canvas1.create_line(213.5, 253.2, 213.5, 215.2, fill="black", width=4)
# canvas1.create_line(229.5, 199.2, 267.5, 199.2, fill="black", width=4)
# canvas1.create_line(299.5, 167.2, 272.5, 194.2, fill="black", width=4)
# canvas1.create_line(261.5, 167.2, 234.5, 194.2, fill="black", width=4)
# canvas1.create_line(299.5, 167.2, 261.5, 167.2, fill="black", width=4)
# canvas1.create_line(272.5, 194.2, 234.5, 194.2, fill="black", width=4)

# # Hand2 for Canvas2
# # Palm
# canvas2.create_line(flip_x(86.5), 287.2, flip_x(186.5), 287.2, fill="black", width=4)
# canvas2.create_line(flip_x(86.5), 287.2, flip_x(86.5), 199.2, fill="black", width=4)
# canvas2.create_line(flip_x(213.5), 199.2, flip_x(86.5), 199.2, fill="black", width=4)
# canvas2.create_line(flip_x(213.5), 199.2, flip_x(213.5), 253.2, fill="black", width=4)
# canvas2.create_line(flip_x(186.5), 287.2, flip_x(213.5), 253.2, fill="black", width=4)
# # Finger 1
# canvas2.create_rectangle(flip_x(86.5), 199.2, flip_x(114.5), 144.2, fill=None, width=4, outline="black")
# canvas2.create_rectangle(flip_x(86.5), 139.2, flip_x(114.5), 84.2, fill=None, width=4, outline="black")
# # Finger 2
# canvas2.create_rectangle(flip_x(119.5), 199.2, flip_x(147.5), 144.2, fill=None, width=4, outline="black")
# canvas2.create_rectangle(flip_x(119.5), 139.2, flip_x(147.5), 84.2, fill=None, width=4, outline="black")
# # Finger 3
# canvas2.create_rectangle(flip_x(152.5), 199.2, flip_x(180.5), 144.2, fill=None, width=4, outline="black")
# canvas2.create_rectangle(flip_x(152.5), 139.2, flip_x(180.5), 84.2, fill=None, width=4, outline="black")
# # Finger 4
# canvas2.create_rectangle(flip_x(185.5), 199.2, flip_x(213.5), 144.2, fill=None, width=4, outline="black")
# canvas2.create_rectangle(flip_x(185.5), 139.2, flip_x(213.5), 84.2, fill=None, width=4, outline="black")
# # Thumb
# canvas2.create_line(flip_x(213.5), 253.2, flip_x(267.5), 199.2, fill="black", width=4)
# canvas2.create_line(flip_x(213.5), 215.2, flip_x(229.5), 199.2, fill="black", width=4)
# canvas2.create_line(flip_x(213.5), 253.2, flip_x(213.5), 215.2, fill="black", width=4)
# canvas2.create_line(flip_x(229.5), 199.2, flip_x(267.5), 199.2, fill="black", width=4)
# canvas2.create_line(flip_x(299.5), 167.2, flip_x(272.5), 194.2, fill="black", width=4)
# canvas2.create_line(flip_x(261.5), 167.2, flip_x(234.5), 194.2, fill="black", width=4)
# canvas2.create_line(flip_x(299.5), 167.2, flip_x(261.5), 167.2, fill="black", width=4)
# canvas2.create_line(flip_x(272.5), 194.2, flip_x(234.5), 194.2, fill="black", width=4)












# import tkinter as tk
# from tkinter import messagebox
# import random

# # Create main window
# root = tk.Tk()
# root.title("Numericket: The Numeric Cricket")

# # Canvas for Player Move
# canvas1 = tk.Canvas(root, width=380, height=380, bg="lightgrey")
# canvas1.pack(side=tk.LEFT, anchor="n", padx=170, pady=170)
# canvas1.create_text(200, 354, text="Your Move", font=('Time New Roman', 24, 'bold'), fill='black', anchor='center', justify='center')

# # Canvas for System Move
# canvas2 = tk.Canvas(root, width=380, height=380, bg="lightgrey")
# canvas2.pack(side=tk.RIGHT, anchor="n", padx=170, pady=170)
# canvas2.create_text(200, 354, text="System Move", font=('Time New Roman', 24, 'bold'), fill='black', anchor='center', justify='center')

# # Score and Ball Labels
# total_score_label = tk.Label(root, text="Total Score: 0", font=('Time New Roman', 16, 'bold'))
# total_score_label.place(x=370, y=100)

# balls_label = tk.Label(root, text="Balls: 0", font=('Time New Roman', 16, 'bold'))
# balls_label.place(x=370, y=130)

# # Game Variables
# total_score = 0
# balls = 0
# user_turn = True  # Track if it's player's turn to bat
# num_matches = 0  # Number of matches to be played
# current_match = 1  # Start with match 1
# player_bat = True  # Track whether player is batting or bowling

# # Function to handle toss and determine bat/bowl choice
# def toss():
#     global player_bat
#     toss_result = random.choice(["Player wins", "System wins"])
#     if toss_result == "Player wins":
#         # Ask player to choose to bat or bowl
#         choice = messagebox.askquestion("Toss Result", "You won the toss! Do you want to Bat?", icon='question')
#         if choice == 'yes':
#             player_bat = True
#             messagebox.showinfo("Choice", "You chose to Bat. Good Luck!")
#         else:
#             player_bat = False
#             messagebox.showinfo("Choice", "You chose to Bowl. Good Luck!")
#     else:
#         player_bat = False
#         messagebox.showinfo("Toss Result", "System won the toss and chose to Bowl!")

#     start_match()

# # Function to start the match
# def start_match():
#     global current_match, total_score, balls
#     if current_match <= num_matches:
#         total_score = 0
#         balls = 0
#         update_score_balls()
#         if player_bat:
#             player_batting()
#         else:
#             player_bowling()
#     else:
#         messagebox.showinfo("Game Over", "All matches are finished!")
#         root.quit()

# # Update score and balls label
# def update_score_balls():
#     total_score_label.config(text=f"Total Score: {total_score}")
#     balls_label.config(text=f"Balls: {balls}")

# # Player batting turn (Player chooses a number)
# def player_batting():
#     global balls
#     if balls < 6:  # A turn consists of 6 balls
#         # Buttons for player to click
#         def buttonClick(n):
#             global total_score, balls
#             total_score += n
#             balls += 1
#             update_score_balls()
#             canvas1Hand(n)
#             system_turn()

#         create_buttons(buttonClick)
#     else:
#         system_turn()  # After 6 balls, it's system's turn

# # Player bowling turn
# def player_bowling():
#     global balls
#     if balls < 6:  # A turn consists of 6 balls
#         # System randomly generates a score (simulating the system hitting)
#         n = random.randint(1, 10)
#         total_score += n  # System gets the score (simulating hitting)
#         balls += 1
#         update_score_balls()
#         canvas2Hand(n)
#         if balls < 6:
#             player_batting()  # Next ball is player's turn to bat
#         else:
#             end_innings()

# # System's turn (Random number selected for system)
# def system_turn():
#     global balls
#     if balls < 6:
#         n = random.randint(1, 10)
#         total_score += n
#         balls += 1
#         update_score_balls()
#         canvas2Hand(n)
#         if balls < 6:
#             player_batting()  # Next ball is player's turn
#         else:
#             end_innings()

# # Display player's move on canvas
# def canvas1Hand(n):
#     canvas1.create_rectangle(0, 0, 380, 380, fill="lightgrey")
#     canvas1.create_text(200, 200, text=str(n), font=('Time New Roman', 48, 'bold'), fill='black', anchor='center')

# # Display system's move on canvas
# def canvas2Hand(n):
#     canvas2.create_rectangle(0, 0, 380, 380, fill="lightgrey")
#     canvas2.create_text(200, 200, text=str(n), font=('Time New Roman', 48, 'bold'), fill='black', anchor='center')

# # Button creation for player move
# def create_buttons(buttonClick):
#     button1 = tk.Button(root, text="1", command=lambda: buttonClick(1), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button1.place(x=170, y=600)
#     button2 = tk.Button(root, text="2", command=lambda: buttonClick(2), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button2.place(x=270, y=600)
#     button3 = tk.Button(root, text="3", command=lambda: buttonClick(3), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button3.place(x=370, y=600)
#     button4 = tk.Button(root, text="4", command=lambda: buttonClick(4), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button4.place(x=470, y=600)
#     button5 = tk.Button(root, text="5", command=lambda: buttonClick(5), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button5.place(x=170, y=700)
#     button6 = tk.Button(root, text="6", command=lambda: buttonClick(6), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button6.place(x=270, y=700)
#     button7 = tk.Button(root, text="7", command=lambda: buttonClick(7), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button7.place(x=370, y=700)
#     button8 = tk.Button(root, text="8", command=lambda: buttonClick(8), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button8.place(x=470, y=700)
#     button9 = tk.Button(root, text="9", command=lambda: buttonClick(9), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=20, pady=20, relief='groove')
#     button9.place(x=270, y=800)
#     button10 = tk.Button(root, text="10", command=lambda: buttonClick(10), font=('Time New Roman', 16, 'bold'), fg='black', bg='white', padx=15, pady=20, relief='groove')
#     button10.place(x=370, y=800)

# # End the innings (Switch turns or end the match)
# def end_innings():
#     global player_bat, balls
#     if player_bat:
#         messagebox.showinfo("Innings Over", "You are out! System will now bat.")
#         player_bat = False
#         system_turn()
#     else:
#         messagebox.showinfo("Innings Over", "System is out! Your turn to bat.")
#         player_bat = True
#         player_batting()

# # Function to start the match and handle user input for number of matches
# def start_game():
#     global num_matches
#     num_matches = int(messagebox.askquestion("Number of Matches", "How many matches do you want to play?"))
#     toss()

# # Start the game
# start_game()

# # Main loop
# root.mainloop()
