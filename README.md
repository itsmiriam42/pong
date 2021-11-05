# CESP Pong

**Retro multiplayer Pong Game:**

![image](https://user-images.githubusercontent.com/44570841/140504595-6d2e1c79-c619-4128-9c12-99f364c8ade0.png)
## Authors

_Contributors names and contact info_
- Lena Gerken
- Tina Höflich
- Miriam Penger

## Demo Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/-h3eH4ubuno/0.jpg)](http://www.youtube.com/watch?v=-h3eH4ubuno "Video Title")

Replace -h3eH4ubuno in the this .md by your YT video

## Description

### How to run

### Requirements:

To be able to play the game, it is necessary to change the path of the different images, that will be displayed throughout the game. This can be done in [`src/display_image.asm`](src/display_image.asm), where the paths are inserted at the beginning of the document, separated by a slash `/`.  
Specify which file need to be used to run your program:
e.g.
To run the game, open [`src/main.asm`](src/main.asm) in [Rars](https://github.com/TheThirdOne/rars). 
To get started, the _Bitmap Display_ and _Keyboard Simulator_ must be configured. To do so, the display width of the _Bitmap Display_ needs to be set to **256 pixels** and the height of the Display is set to **128 pixels**. Both tools are then connected to the program.

Now two Players can start playing the game. 

### Game instructions 
The two Players use different keys on the keybard to control their paddles:
#### Left Player:
- `w`: moving paddle upwards
- `s`: moving paddle downwards

#### Right Player
+ `o`: moving paddle upwards
+ `l`: moving paddle downwards 

### Game logic
Whenever the ball hits the left border of the display, the right player gets a point. The same applies when the ball hits the right edge of the display, the left player gets a point. 
Once a player reaches 11 points, the game is over.

## Files
Describe the content of each file of your application: e.g.
### Libs and resources
- [`src/cesplib_rars.asm`](src/cesplib_rars.asm): File conatining DISPLAY_ADDRESS and further details of the bitmap display of RARS. It is required, only wors when using [Rars](https://github.com/TheThirdOne/rars)
- [`src/images`](src/images):Folder containing images, displayed on the screen, while the game is running

### Game
- [`src/main.asm`](src/main.asm): Main file of the program in which the game flow is located
- [`src/display_image.asm`](src/display_image.asm): Function to display a picture on the bitmap display
- [`src/ball_actions.asm`](src/ball_actions.asm): Moves and draws the ball, checks for collisions and calls different functions
- [`src/draw_ball.asm`](src/draw_ball.asm): Initial draw of the ball of the pong game using the draw_circle function
- [`src/draw_circle.asm`](src/draw_circle.asm): Function to draw a colored circle with given radius and x- and y-coordinates of center
- [`src/draw_line.asm`](src/draw_line.asm): Draws a line from one position defined by as x1,y1 to another position defined as x2,y2 and fill it with color
- [`src/draw_paddles.asm`](src/draw_line.asm): Initially draws both paddles using the draw_rectangle function.
- [`src/draw_pixel.asm.asm`](src/draw_pixel.asm): Draws a colored pixel at position (x,y)  
- [`src/draw_rectangle.asm`](src/draw_rectangle.asm): Draws a rectangle from one position defined by as x1,y1 to another position defined as x2,y2 and fill it with color
- [`src/move_ball.asm`](src/move_ball.asm): Moves the ball of the pong game using the draw_rectangle function and painting the pixel differences of old and new position after movement
- [`src/move_paddles.asm`](src/move_paddles.asm): Moves paddles according to keyboard inputs
- [`src/play_sound_win.asm`](src/play_sound_win.asm): Plays a short melody using rars ecall. It is played, when the game is over
- [`src/play_soundeffect.asm`](src/play_soundeffect.asm): Plays a short soundeffect, that is used, when a player scored
- [`src/readwordunaligned.asm`](src/readwordunaligned.asm): Function is required when displaying an image on the bitmap display 
- [`src/scoreboard.asm`](src/scoreboard.asm): Draws the scoreboard of the pong game pixel by pixel using the draw pixel function

### Tests
- [`src/test_ball_actions.asm`](src/test_ball_actions.asm): Tests for the functions in ball_actions.asm


## Test evidence
Screenshot that shows succedded (unit) tests 
