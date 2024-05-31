# Run
#### Video Demo:  <https://youtu.be/ApzZoHp6Gf8>
#### Description:
WELCOME PLAYER TO THE ARENA!!!!
I am the Game Master. Here's what you need to know.

There is no hiding. There is no killing. There is no escape. Your only option left? Run.

Run from the monsters for as long as you can to achieve a high score.

Want that score number to get bigger faster? I mean who doesn't! Simply press ENTER to make that number get bigger faster.......... and maybe let some more monsters into the arena at the same time.  So, I get it you may be saying "I just want to see small number be bigger number faster, why more monsters". I get it, I truly do.  But I have got to keep it interesting for all of my adoring fans. So, more monsters mean more risk and more risk means more points. Good? Good! Glad we are on the same page.

Find yourself surrounded by monsters with no way out? Simply press SPACE and dash through them like they aren't even there! But just be careful you may or not be able to use it again for a bit. Just warning you. I do have to be a good Game Master for my adoring fans.

Oh, and by the way the game ends when you're dead, no biggie right, you signed the papers right? Good!

LET THE GAME BEGIN!

Run is a 2D, top-down, arcade, survival game made within the Godot game engine. The objective of the game is for the player to earn as many points as possible before being hit three times by enemies. More enemies spawn every few seconds increasing the difficulty. The more enemies in the arena the more points you earn. As a result, the game features a risk reward system. Players are able to manually add enemies to the arena to increase the number of points earned at the risk of high difficulties.

The Godot engine is a bit different than other game engines like Unity and Unreal Engine. Godot is built around the concepts of nodes and combining different nodes (along with scripts written in GD Script, their language) to create scenes (file type “.tscn”) that can then themselves be used as nodes to create more complex scenes. Therefore, I will focus on describing what each scene does.

Zombie.tscn is the scene for the main enemy type in the game. It utilizes the built-in navigation system to track and path find to the player. However, this system has an issue where the enemy gets stuck on the corners of obstacles. To prevent this, I implemented a system to course correct the enemy around corners and in tight spaces. To do so I use three vectors. The first vector is the vector derived from the navigation system and this is the direction that the enemy wants to go based on the path finding algorithm included with Godot. My algorithm then uses eight ray casts that check for collisions in the eight cardinal directions (N, NE, E, SE, S, SW, W, and NW). The second vector is inverse of the average of the vectors in each direction where there is a collision. This creates a vector that points away from any collisions. The final vector which is the actual direction the enemy will move in, is the average of the first two vectors.

Ghost.tscn is the scene for the second enemy type in the game. It too utilizes the built-in navigation system to track and path find to the player. However, unlike the Zombie the Ghost does not require correction with its path finding as like ghosts do, the Ghost is able to pass through obstacles and thus does not need to worry about getting stuck on corners.

Player.tscn is the scene for the player. In the script for this scene is the code for controlling the player movement and actions. Actions include a dash and the option to spawn in a new enemy. To dash the players movement speed is simply increased and the sprite changed. While dashing the player is invincible and is able to pass through enemies without getting damaged. This is done by turning off collisions with enemies so that essentially the player code can no longer sense enemies. When choosing to spawn a new enemy the player script emits a signal to the game controller to add a new enemy. The player script also checks if an enemy has entered its hitbox. When entered the player takes damage and then becomes invincible for a short time. If at the end of being invincible an enemy is still touching the player then the player will take damage again.

Game.tscn is the scene of the main game. Attached to this scene is the game controller script. In this script is the functionality to spawn in an enemy, checking if the game is over and if the user has paused the game.

Other scenes are just user interface menus, such as, main menu, pause menu, and high scores. Most of the scripts for these menus are simply text that either is permanent or will simply read some data and set the text to the values on being loaded in.

However, the main component of these menus is the options that can be selected. To create this a tutorial was followed and the link for the video can be found below. I highly recommend it:

Tutorial URL: https://www.youtube.com/watch?v=p_m3xgWAFo0
