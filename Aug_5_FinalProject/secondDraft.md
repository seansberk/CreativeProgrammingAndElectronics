**Title**

Mapping my Life

**Proposed Idea**

My proposed idea is to create a robot that interacts with its environment and creates art based on inputs from the sensors onboard. Using the information from the sensors, I plan to make modifications to the way the art may be displayed or represented in graphical form. The idea is that there can be multiple different end art products which are the result of having the robot run around different rooms throughout the day. This will create a map of my life so to speak.

**Inspiration**

I took inspiration from a youtube video I watched of a cleaning robot that vaccuums and cleans floors and it was quite advanced (referenced below). This led me to thinking about how I had held a conversation with someone about these cleaning robots and how they mapped the inside of your home, similar to how google maps the streets of the world. I thought this was an interesting concept and while I was doing research for our presentation, I had come across the creative programmer that I became inspired by. He takes inputs from the world to create generative art. His name is Patrick Hubner and he has produced unique alcohol labels based on weather patterns as well as dynamic art works responsive to twitter interactions. 

Taking the idea of multiple unique and diverse interactions from online, and devloping an artwork out of that became something that I thought could be applied to my life in at home especially while in quarantine where a lot of life has been centered around home based living.

![Dyson 360 Eye Vaccuum](https://www.youtube.com/watch?v=k3uh-gv8Isw)

![Patrick Hubner](https://www.patrik-huebner.com/portfolio/)

**Planned Implementation**

While the robot will be mobile, it will be difficult to properly implement what I want and I am still thinking of how to do this. I had hoped to run it off a raspberry pi but I left mine in Berkeley and so am looking for an alternative to this. My currenty plan is to just walk around with it as it moves managing the cables so that it remains always behind me.

I plan to use the temperature sensors as I live in a tropical country but use the AC often and so seeing how the temperature fluctuates would be interesting. 

I plan to use the ultrasonic sensor to prevent crashes while also gauging the size of the room be finding how far it can go before coming into a crash. This will help indicate what my home space is like and whether I spend most my time in smaller spaces or gravitate to more spacious areas.

I plan to use the light sensor to capture the type of lighting I tend to be around and utilize this information to impact the brightness of the artwork.

Using the data from all these sensors, I plan to map the max and min values found in the environments and use those to augment the color, shape, size and movement of the artwork. This will provide many different and interesting diagrams of my environment displayed in an interesting way.

One thing that I think will be necessary is having a start and stop switch using the switch that isn't a button.

**Concern**

I don't know how good this will look when all is said and done and I am concerned I may end up with something that isn't as interesting as I envision in my mind.

I also have the concern that the variation between rooms and inputs won't be as clearly defined.

Lastly I have a concern about how I plan to have these drawn and saved. I hope to be able to have saved versions of the artwork that is made after the computer has run and stopped the program.

**Riskiest Parts of the Project**

It will be new for me to implement the switch (non-button) but I believe it was not too different in how it was wired up. I will make sure this works in a vaccuum with an LED before I attempt to apply it to the project.

I am thinking an alternative approach to having the robot draw the room in realtime would be to have the robot save a file that is filled with data and then store that data on the computer before uploading that file to processing to create a drawing. This method may provide a more successful. This is difficult because I haven't tried making the arduino write data in a new file but I believe it can be done. I would first conduct research on the capabilites of doing this and then I would test it before trying it out in my own project.

**Expansion**
If this can have an GUI that allows for communication between the arduino and whatever computer is being used, this could open the door to controlling the robot telling it when to start stop and to modify variables via this GUI.

**Additional Reference Material**

In combination with what we have learned in class, I will use reference material from Sparkfun's website: 

https://learn.sparkfun.com/tutorials/sparkfun-inventors-kit-experiment-guide---v41

This has information that I can use to better understand how different components work and test them out before I actually implement them. This also has some information about working with this kit and making it into a robot that can move.
