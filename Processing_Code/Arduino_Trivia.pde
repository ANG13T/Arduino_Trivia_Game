import processing.serial.*;    // Importing the serial library to communicate with the Arduino 



Serial myPort;      // Initializing a vairable named 'myPort' for serial communication

int level = -1; //level of questions
int score = 0;
boolean gameCompleted = false;

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

PFont currentQuestion;

String currentText = "Press any button to continue.";

PImage icon;
PImage options;

boolean showOptions = false;

void setup ( ) {

size (670,  800);     // Size of the serial window
currentQuestion = createFont("Arial",32,true);
icon = loadImage("arduino.png");
options = loadImage("gameOptions.png");

printArray(Serial.list());
myPort  =  new Serial (this, Serial.list()[1],  9600); // Set the com port and the baud rate according to the Arduino IDE

myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE

} 

void serialEvent  (Serial myPort) {
  String guess = myPort.readStringUntil('\n');
  float numGuess;
  if(guess.length() > 0){
    numGuess = float(guess);
    setText(numGuess);
  }
} 


void draw ( ) {
  background(0,0,0);
  textFont(currentQuestion,30);                  
  fill(255, 255, 255);
  textAlign(CENTER);
  text(currentText,width / 2.2,370); 
  image(icon, width/7.3, 0, width/1.5, height/2.4);
  if(showOptions){
    image(options, width/7.3, 400, width/1.5, height/2.4);
    text(optionsList[level][0],width / 3.2,460); //option A
    text(optionsList[level][1],width / 3.2,580); //option B
    text(optionsList[level][2],width / 3.2,695); //option C
  }
  
  if(gameCompleted){
    String scoreString = "Score: " + score;
    text(scoreString, width / 3.2,460); //option A
    text("Press a button to play again!", width / 2,580); //option B
  }
}

void setText(float guess){
  
  if(gameCompleted){
    showOptions = true;
    level = 0;
    score = 0;
    gameCompleted = false;
    currentText = questions[0];
    return;
  }
  
  if(level > -1 && !gameCompleted){
    if(guess == answers[level]){
      myPort.write('1');
      score++;
    }else{
      myPort.write('0');
    }
  }
  
  if(level + 1 >= questions.length || gameCompleted){
    currentText = "You completed the game!";
    showOptions = false;
    gameCompleted = true;
    return;
  }
 
  
  showOptions = true;
  level++;
  currentText = questions[level];
}

    