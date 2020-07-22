What did you make?

This week I used my arduino to make indicator lights. I made it so that the red light would be on until the switch was pushed, and the green light to blink when the switch was not pressed, however the it required that the light in the room was bright enough. If there was not enough light given my a room, there would be no blinking green light. The idea was that the green light would be telling the person to press the switch if it was bright, and not to tell you to do anything when the lights were off. There was another light on the arduino (from pin 13) which would indicate whether or not the button was pressed by blinking twice quickly, then once slowly. Put simply:

RED: Indicates button not pressed

Blinking Green: Lights are on indicator

Board light blinking: Indicates Button is pressed

Green light on: button pressed

This is my Schematic: ![](Schematic.HEIC)

This is my Arduino Circuit: ![](Arduino.HEIC)


Problems:

I found that for a little bit the arduino was not recognizing the button press when I had the voltage splitter (for the light sensor) was plugged into the circuit. After some hair pulling and an hour break, I came back, re-ran the program and it happened to work.

Besides this, I had a hard time wiring everything up. To make sense of everything, I unplugged everything when I got stuck and did what I knew worked and plugged it in, then continued until I found something that was not working and tried to figure out where I went wrong with the circuit. This would always be before checking the software to make sure I had properly written my code.


Interesting:

It was interesting to find the balance in values that worked for the light sensor as sometimes even when it was dark, the light would continue to blink telling me the lights were on even if they weren't.


Credits:

I took some ideas from class and implemented them into my program.
