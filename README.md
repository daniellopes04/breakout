![Breakout](https://github.com/daniellopes04/breakout/blob/main/graphics/breakout-text.png)

***Lecture 2* on "S50's Intro to Game Development" course, available on [YouTube](https://www.youtube.com/playlist?list=PLWKjhJtqVAbluXJKKbCIb4xd7fcRkpzoz)**
 
Implementation of retro game ["Breakout"](https://en.wikipedia.org/wiki/Breakout_(video_game)).

![Screen1](https://github.com/daniellopes04/breakout/blob/main/graphics/print1.png)

## Objectives

- [x] Implement a version from the game Breakout.
- [x] Add a powerup to the game that spawns two extra Balls.
- [x] Grow and shrink the Paddle when the player gains enough points or loses a life.
- [ ] Add a locked Brick that will only open when the player collects a second new powerup, a key, which should only spawn when such a Brick exists and randomly as per the Ball powerup.
- [ ] Add extra powerups to the game.

## Possible updates

- [ ] Show visual response to when the player gets a powerup.

## Installation

### Build

First, you have to install [LÖVE2D](https://love2d.org/), then run the following.

```bash
git clone https://github.com/daniellopes04/breakout
```
```bash
cd breakout
```
```bash
love .
```

### Play

Simply go to ["Releases"](https://github.com/daniellopes04/breakout/releases) and download the version compatible with your system.

## The game

### Controls

* Left and right arrows to control the paddle

![Screen3](https://github.com/daniellopes04/breakout/blob/main/graphics/print3.png)
![Screen4](https://github.com/daniellopes04/breakout/blob/main/graphics/print4.png)

### In-game powerups 

![PowerUp1](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup1.png) Gain extra heart
![PowerUp2](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup2.png) Adds 5 extra balls to the game
![PowerUp3](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup3.png) Increase paddle size
![PowerUp4](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup4.png) 1000 extra points
![PowerUp5](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup5.png) All balls in game inflict 2x damage
![PowerUp6](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup6.png) All balls in game inflict critic damage
![PowerUp7](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup7.png) Adds two extra balls to the game
![PowerUp8](https://github.com/daniellopes04/breakout/blob/main/graphics/powerup8.png) Enables to break a locked brick

![Screen5](https://github.com/daniellopes04/breakout/blob/main/graphics/print5.png)
![Screen6](https://github.com/daniellopes04/breakout/blob/main/graphics/print6.png)
![Screen7](https://github.com/daniellopes04/breakout/blob/main/graphics/print7.png)

### High-score feature

The game stores all the player's high scores.

![Screen8](https://github.com/daniellopes04/breakout/blob/main/graphics/print8.png)
![Screen2](https://github.com/daniellopes04/breakout/blob/main/graphics/print2.png)
