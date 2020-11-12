import processing.serial.*;    // Importing the serial library to communicate with the Arduino 

Serial myPort;      // Initializing a vairable named 'myPort' for serial communication

int level = 0; //level of questions

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
int[] answers = {1, 3, 2};

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
  int numGuess;
  if(guess.length() > 0){
    numGuess = int(guess);
    print(guess);
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
}

void setText(int guess){
  if(level == 0){
    showOptions = true;
  }
  if(level == 1){
    if(guess == answers[level]){
      myPort.write('1');
    }else{
      myPort.write ('0');
    }
  }
  level++;
  print("lvel", level);
  
  if(level == questions.length){
    level = 0;
  }
  currentText = questions[level];
}

    