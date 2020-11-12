import processing.serial.*;    // Importing the serial library to communicate with the Arduino 
import processing.sound.*;


Serial myPort;      // Initializing a vairable named 'myPort' for serial communication

int level = -1; //level of questions
int score = 0;
boolean gameCompleted = false;

String[] questions = {"What is the meaning of life?", "What is 2 + 2?", "How many letters compose: dog?"};
String[][] optionsList = {  {
                              "8",
                              "42",
                              "5"
                            }, 
                            {
                              "4",
                              "8",
                              "77"
                            }, 
                            {
                              "6",
                              "90",
                              "3"
                            }
                          };
float[] answers = {2, 1, 3};

PFont currentQuestion;

String currentText = "Press any button to continue.";

PImage icon;
PImage options;

SoundFile correctAudio;
SoundFile wrongAudio;

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
  println("the input", guess);
  float numGuess;
  if(guess.length() > 0){
    numGuess = float(guess);
    println("the input 2", numGuess);
    setText(numGuess);
  }
} 


void draw ( ) {

  background(0,0,0);
  textFont(currentQuestion,30);                  
  fill(255, 255, 255);
  textAlign(CENTER);
  //text(currentText,width / 4,350);
  text(currentText,width / 2.2,370); 
  image(icon, width/7.3, 0, width/1.5, height/2.4);
  if(showOptions){
    image(options, width/7.3, 400, width/1.5, height/2.4);
    text(optionsList[level][0],width / 3.2,460); //option A
    text(optionsList[level][1],width / 3.2,580); //option B
    text(optionsList[level][2],width / 3.2,695); //option C
  }
  
  correctAudio = new SoundFile(this, "correct.wav");
  wrongAudio = new SoundFile(this, "wrong.wav");
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
    print("the guess", guess);
    print("the answer", answers[level]);
    if(guess == answers[level]){
      myPort.write('1');
      correctAudio.play();
      score++;
    }else{
      myPort.write('0');
       wrongAudio.play();
    }
  }
  
  if(level + 1 >= questions.length || gameCompleted){
    currentText = "You completed the game!";
    showOptions = false;
    println("Your score", score);
    gameCompleted = true;
    return;
  }
 
  
  showOptions = true;
  level++;
  currentText = questions[level];
}

    