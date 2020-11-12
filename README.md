# Arduino Trivia Processor

A fun trivia game made with the Arduino and Processor langauge.

## Materials

- Breadboard
- 2 LED
- Arduino Uno
- Around 20 jumper wires
- 5 220ohm resistors
- 3 Buttons

## Schematic

![design image](https://github.com/angelina-tsuboi/Trivia_Processor/blob/master/images/design.png)

## How It Works

This project utilizes combines concepts from breadboarding/hardware, Arduino C, and Processing in order to produce a fully functioning trivia game. In this guide, I will break down the project into three sections (game/code, hardware, and interfacing).

### How the Game Works

 The trivia game works by receiving input from the Serial port. This allows our processor code to receive and send data to the Arduino. Our trivia game keeps track of the following variables:
 - the current text (currentText)
 - whether to show the buttons or not (showOptions)
 - the current level (level)
 - the score (score)
 - whether the game is completed or not (gameCompleted)
 The game starts off with a simple text stating, "Press any button to continue." A button press from the Arduino is detected by the **serialEvent()** function which calls the **setText()** function with the number of the button pressed (ie. if the first button is pressed it will pass in '1'). The **setText()** code: 
 ```
 if(gameCompleted){
    showOptions = true;
    level = 0;
    score = 0;
    gameCompleted = false;
    currentText = questions[0];
    return;
  }
 ```
 runs when the game is already completed, and the user wants to start over again. This will restore all the default values of the first level.

 The second if statement:

 ```
 if(level > -1 && !gameCompleted){
    if(guess == answers[level]){
      myPort.write('1');
      score++;
    }else{
      myPort.write('0');
    }
  }
 ```
 runs when the level is not on the starting home page (level = -1) and the game is not completed it. This if statement runs during the trivia portion of the game. Inside the if statement, we check if the answer the user pressed was correct. If the answer is correct, we send '1' through the port and increment the score. Otherwise, we send '0'.

 The third if statement:
 ```
 if(level + 1 >= questions.length || gameCompleted){
    currentText = "You completed the game!";
    showOptions = false;
    println("Your score", score);
    gameCompleted = true;
    return;
  }
 ```
 runs if the user has gone all the questions, therefore, completing the game. This will set the text to say, "You completed the game!", hide the option buttons, and set the gameCompleted variable to true.

 The general case for this function is the following:
 ```
 showOptions = true;
 level++;
 currentText = questions[level];
 ``` 
 This code shows the option buttons, increments the level, and sets the text to show the next question.

 We set up most of trivia game visuals/audio inside **setup()**. Inside the setup(), the images/audio are initialized and we setup the serial communication between Processing and the Arduino.

 Inside the **draw()** function, we display the images and the text for the game. We only show the option buttons, if the *showOptions* variable is true. Likewise, when *gameCompleted* is true, we display the game over stats.

### Hardware Functionality

The wiring and hardware setup for this project is pretty strightforward. We have three push buttons wired up to their respective digital pins, and two LEDs (one green, one red) to indicate whether the guess was correct or incorrect. When a push button is pressed, it sends a signal to the Arduino. This signal is used to determine whether the answer was correct. (eg.when the third button is pressed it represents that the user chose choice C). Follow the schematic image shown above in order to create the circuit.

### Hardware/Software Interfacing

 In this project, the interfacing between hardware and software occurs when we use the push buttons connected to the Arduino (hardware) to send data to Processor (software) which in turn uses that data to progress the trivia game. Also, the Processor code (software) sends data to the Arduino (hardware) in order to turn on the red or green LED. For the Processor code to communicate to the Arduino Uno, we need to utilize serial communication. Processing has an amazing serial library which makes communicating with the Arduino super easy! In order to really understand whats happening, I suggest that you look over both the Trivia.ino and Arduino_Trivia.pde files.

 Application: 
 Theres A TON of applications for serial communication. If you are intrested in this particular topic, I would recommend that you check out ![this article](https://en.wikipedia.org/wiki/Serial_communication#:~:text=In%20telecommunication%20and%20data%20transmission,link%20with%20several%20parallel%20channels.)

## Completed Project

![trivia game photo](https://github.com/angelina-tsuboi/Trivia_Processor/blob/master/images/gui.png)

![project photo](https://github.com/angelina-tsuboi/Trivia_Processor/blob/master/images/final.jpg)

## Sources

[arduino/processor communication source](https://maker.pro/arduino/tutorial/how-to-make-arduino-and-processing-ide-communicate)
[blog on hardware/software interfaces](https://www.embedded-computing.com/guest-blogs/the-hardware-software-interface-where-weve-been-and-where-were-going)

