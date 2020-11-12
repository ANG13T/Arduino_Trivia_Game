import processing.serial.*;    // Importing the serial library to communicate with the Arduino 



Serial myPort;      // Initializing a vairable named 'myPort' for serial communication

int level = -1; //level of questions
int score = 0; //user score
boolean gameCompleted = false; 

//Hardcoded questions, options, and answers
String[] questions = {"When was the Arduino created?", "How many Digital I/O pins does the Arduino Uno have?", "Which country was the Arduino created at?", "What can you make with an Arduino?", "What programming language does Arduino use?", "What is the memory limit of the Arduino Uno?", "True or False: Arduino requires 6 to 20V?", "What microcontroller does the Arduino Uno use?"};
String[][] optionsList = {  {
                              "1996",
                              "2005",
                              "2016"
                            }, 
                            {
                              "14",
                              "8",
                              "25"
                            }, 
                            {
                              "USA",
                              "China",
                              "Italy"
                            },
                            {
                              "Gadgets",
                              "Robots",
                              "Both"
                            },
                            {
                              "Java",
                              "C",
                              "Python"
                            },
                            {
                              "32K",
                              "54K",
                              "2GB"
                            },
                            {
                              "True",
                              "False",
                              "IDK"
                            },
                            {
                              "ATX Mega",
                              "8051",
                              "ATmega328P"
                            }
                          };
float[] answers = {2, 1, 3, 3, 2, 1, 1, 3};

//set up font
PFont currentQuestion;

//text
String currentText = "Press any button to continue.";

//set up images
PImage icon;
PImage options;

//boolean to show option buttons or not
boolean showOptions = false;

void setup ( ) {

size (670,  800);     // Size of the serial window
currentQuestion = createFont("Arial",32,true);
icon = loadImage("arduino.png"); //icon image
options = loadImage("gameOptions.png"); //game buttons image

printArray(Serial.list()); //print all the serial devices
//*Warning*: make sure you choose the right element inside of the Serial.list() array
myPort  =  new Serial (this, Serial.list()[1],  9600); // Set the com port and the baud rate according to the Arduino IDE

myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE

} 

void serialEvent  (Serial myPort) { //when data is passed through the serial
  String guess = myPort.readStringUntil('\n'); //get the data
  float numGuess;
  if(guess.length() > 0){ //if the data is valid
    numGuess = float(guess); //convert data into a float
    setText(numGuess); //call the setText function with the guess number
  }
} 


void draw ( ) {
  background(0,0,0); //set background to black
  textFont(currentQuestion,30); //set fontsize to 30            
  fill(255, 255, 255); //set text to white
  textAlign(CENTER); //align text to center
  text(currentText,width / 2.2,370); 
  image(icon, width/7.3, 0, width/1.5, height/2.4); //adjusting image options
  if(showOptions){ //if showOptions is true: display the options for the questions and show the button background
    image(options, width/7.3, 400, width/1.5, height/2.4);
    text(optionsList[level][0],width / 3.2,460); //option A
    text(optionsList[level][1],width / 3.2,580); //option B
    text(optionsList[level][2],width / 3.2,695); //option C
  }
  
  if(gameCompleted){ //if the game is completed: show the user game stats
    String scoreString = "Score: " + score;
    text(scoreString, width / 3.2,460); //option A
    text("Press a button to play again!", width / 2,580); //option B
  }
}

void setText(float guess){
  
  if(gameCompleted){ //if game is alrady completed: restore default game values
    showOptions = true;
    level = 0; //go back to first level
    score = 0; //set score to 0
    gameCompleted = false;
    currentText = questions[0]; //restore the text
    return;
  }
  
  if(level > -1 && !gameCompleted){ //if the game is not completed, but not on home page
    if(guess == answers[level]){ //check if guess is correct or not
      myPort.write('1'); //send 1 through serial
      score++; //increment score
    }else{ 
      myPort.write('0'); //send 0 through serial
    }
  }
  
  if(level + 1 >= questions.length || gameCompleted){ //if the game is completed
    currentText = "You completed the game!"; //show game completed text
    showOptions = false; //don't show buttons anymore
    gameCompleted = true; 
    return;
  }
 
  
  showOptions = true; 
  level++; //increment level
  currentText = questions[level]; //show the next question
}

    