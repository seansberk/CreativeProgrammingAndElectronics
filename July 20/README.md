Describe your inspiration and include links:

The inspiration behind this project is an old game that I played growing up where you would have to protect a center base. I cannot remember the name of the game specifically but it was along the lines of asteroid. There is a central base that must be defended and if it gets hit by an enemy, then it loses some of its health.






Describe the rules you used to create this project and briefly how you programmed this to happen:



Describe any difficulties you had and how you overcame them:

One of the issues I had was with output latency for sound and this seems to be an issue resulting from Windows 10. The Error is the following:

[DATE/TIME] com.jsyn.devices.javasound.JavaSoundAudioDevice <init>
INFO: JSyn: default output latency set to 80 msec for Windows 10

While I still could not find a proper fix for this, what I did do was use an external application to cut the audio file to start exactly when the sound plays. This fix does not solve the latency but does minimize it.

Other issues included being able to track the position of certain objects and make sure they interacted correctly with their environment. I had used a lot of debugging print words to make sure certain functions were running properly to isolate problems.

Lastly, figuring out how to reset the game was quite difficult as well. Again this just required making sure I had a function that set the values to their default values.


Mention anything interesting you discovered while doing this assignment:
What was interesting was learning all the different things that could be accessed using processing. I found myself learning about using pixel colors and coordinates to be able to track whether something was intersecting with other parts of the game.


Credits:

Here is the sound effect used for the bounces off of the walls: https://www.youtube.com/watch?v=VdBmx68hlTE

Here is the sound effect used for the attacks by the enemies: https://www.youtube.com/watch?v=XjOtGgxaX5g

I used these as the sounds to signal different types of interactions (such as bouncing off the side of the stage, or when the death of the base occurs there is the sound of an explosion).

I had taken a significant amount of artwork from a texture pack I had purchased as part of a bundle that supported a creator. It can be found at this link!

https://medimongames.itch.io/pixel-spaceships-hd
