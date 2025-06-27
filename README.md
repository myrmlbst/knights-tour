# Knight's Tour Visualization

**The knight's tour is a classic problem in computer science and mathematics, often used to demonstrate backtracking algorithms and heuristic search techniques. This project visualizes a solution to said problem, where a knight must visit every square on an 8x8 chessboard exactly once.**

The knight moves in this algorithm the same way it would on a regular chess board; Its paths may only follow an L-shape in any direction.

![Initialized Board](./assets/images/init-board.jpeg)

The implementation uses Warnsdorff's algorithm to find an open-tour solution where the path cannot be re-traversed according to the Knight's movement rules (as opposed to a closed-tour solution, where the first position can be re-traversed from the last position, creating an endless loop for the Knight to move on). 

![Initialized Board](./assets/images/end-board.jpeg)

## Requirements
- LÖVE2D 11.5 or later

## Running the Project
1. Install LÖVE2D from https://love2d.org/
2. Clone this repository
3. Run the game by dragging the project folder onto the LÖVE2D application, or by using the command line: ```love .```

## Directory Structure
```
knights-tour/
├── src/                   
│   ├── knight.lua      # knight's tour algorithm
│   └── board.lua       # board visualization
├── assets/
│   ├── sounds/         # audio files for visualizations
│   ├── images/         # imgs of board before/after the algorithm runs
├── doc/                # remaining to-do's
├── main.lua
├── conf.lua            # pop-up page configurations
├── .gitignore          # ignore editor configs
├── LICENSE
└── README.md
```
