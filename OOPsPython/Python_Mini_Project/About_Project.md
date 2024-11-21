# Snake and Ladder Game - Python Mini Project

## Overview
The **Snake and Ladder Game** is a digital recreation of the classic board game, developed in Python using the Tkinter library for GUI. It simulates a 10x10 board featuring ladders and snakes, where players roll dice to move and aim to reach the 100th position to win the game. The project integrates graphical elements to visualize the board and player movements dynamically.

## Features
- **Interactive Board**: A 10x10 board with cells numbered from 1 to 100.
- **Random Ladders and Snakes**: 
  - Ladders (7 pairs) allow players to climb up.
  - Snakes (7 pairs) cause players to slide down.
  - The positions are randomly generated at the start of each game.
- **Game Mechanics**:
  - Players start at position 1 and roll the dice until they roll a 6 to begin.
  - Movement is based on dice rolls, respecting board limits and special rules for ladders and snakes.
- **Winning Condition**: Reach position 100 to win, with the number of rolls tracked.
- **User Feedback**: 
  - Displays current and last positions, dice rolls, and chances taken.
  - Provides pop-up messages when encountering ladders or snakes.

## Libraries Used
- **Tkinter**: For creating the graphical user interface.
- **Random**: For generating positions of ladders, snakes, and dice rolls.

## How It Works
1. **Starting the Game**:
   - The player begins at position 1.
   - A dice roll is required to get a 6 before progressing further.
2. **Movement**:
   - Based on the dice roll, the player moves forward.
   - Encounters with ladders or snakes update the player's position accordingly.
3. **Feedback**:
   - The current position is highlighted in blue with white text.
   - Messages appear for ladder climbs and snake slides.
4. **Winning**:
   - The game ends when the player reaches position 100, with the total number of rolls displayed.

## Customization
- **Color Scheme**:
  - Light green and green for ladder start and end points.
  - Light coral and red for snake start and end points.
- **Dynamic Updates**: The board dynamically reflects player movements and retains ladder/snake markings throughout the game.

## How to Run
1. Install Python (version 3.x).
2. Run the script in any Python IDE or terminal.
3. Use the "Roll Dice" button to play the game.

## Future Enhancements
- Add multi-player functionality.
- Include AI for single-player challenges.
- Add animations for player movements.
