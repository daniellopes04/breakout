![Breakout](https://github.com/daniellopes04/breakout/blob/main/graphics/breakout-text1.png)

***Lecture 2* on "S50's Intro to Game Development" course, available on [YouTube](https://www.youtube.com/playlist?list=PLWKjhJtqVAbluXJKKbCIb4xd7fcRkpzoz)**
 
Implementation of retro game ["Breakout"](https://en.wikipedia.org/wiki/Breakout_(video_game)).

![Screen1](https://github.com/daniellopes04/breakout/blob/main/graphics/print1.png)

## Objectives

- [x] Implement a version from the game Breakout.
- [x] Add a powerup to the game that spawns two extra Balls.
- [x] Grow and shrink the Paddle when the player gains enough points or loses a life.
- [x] Add a locked Brick that will only open when the player collects a second new powerup, a key, which should only spawn when such a Brick exists and randomly as per the Ball powerup.

## Possible updates

- [x] Show visual response to when the key powerup is active.
- [ ] Add extra powerups to the game.

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
* "Space" to pause the game

![Screen3](https://github.com/daniellopes04/breakout/blob/main/graphics/print3.png)
![Screen4](https://github.com/daniellopes04/breakout/blob/main/graphics/print4.png)

### In-game powerups 

There are several powerups to enhance game experience and help the player in progressing through the levels. Their effects are activated once the player "catches" the powerup with the paddle. The powerups implemented are listed below.

| Powerup                                                      | Effect                                  |
|:------------------------------------------------------------:|-----------------------------------------|
| <img src="graphics/powerup1.png" alt="PowerUp1" width="30"/> | Gain extra heart                        |
| <img src="graphics/powerup2.png" alt="PowerUp2" width="30"/> | Adds 5 extra balls to the game          |
| <img src="graphics/powerup3.png" alt="PowerUp3" width="30"/> | Increase paddle size                    |
| <img src="graphics/powerup4.png" alt="PowerUp4" width="30"/> | 1000 extra points                       |
| <img src="graphics/powerup5.png" alt="PowerUp5" width="30"/> | All balls in game inflict 2x damage     |
| <img src="graphics/powerup6.png" alt="PowerUp6" width="30"/> | All balls in game inflict critic damage |
| <img src="graphics/powerup7.png" alt="PowerUp7" width="30"/> | Adds two extra balls to the game        |
| <img src="graphics/powerup8.png" alt="PowerUp8" width="30"/> | Enables to break a locked brick         |

![Screen6](https://github.com/daniellopes04/breakout/blob/main/graphics/print6.png)
![Screen7](https://github.com/daniellopes04/breakout/blob/main/graphics/print7.png)

### Pause feature

![Screen5](https://github.com/daniellopes04/breakout/blob/main/graphics/print5.png)

### High-score feature

The game stores all the player's high scores.

![Screen8](https://github.com/daniellopes04/breakout/blob/main/graphics/print8.png)
![Screen2](https://github.com/daniellopes04/breakout/blob/main/graphics/print2.png)
