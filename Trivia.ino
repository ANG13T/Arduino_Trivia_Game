//Define variables
#define redLight 2
#define greenLight 3
#define button1 4
#define button2 5
#define button3 6

void setup() {
  //Setup button pins as input, and LED pins as output
  pinMode(button1, INPUT);
  pinMode(button2, INPUT);
  pinMode(button3, INPUT);
  pinMode(redLight, OUTPUT);
  pinMode(greenLight, OUTPUT);
  //Begin the Serial
  Serial.begin(9600);
}

void loop() {

  //if button one is pressed (option A)  
  if(digitalRead(button1) == HIGH){
    Serial.println("1"); //send 1 to Processor through Serial
  }

  //if button two is pressed (option B)  
  if(digitalRead(button2) == HIGH){
    Serial.println("2"); //send 2 to Processor through Serial
  }

//if button two is pressed (option C)
  if(digitalRead(button3) == HIGH){
    Serial.println("3"); //send 3 to Processor through Serial
  }

  if (Serial.available ( ) > 0) {   // Checking if the Processing IDE has send a value or not
    char state = Serial.read ( );    // Reading the data received and saving in the state variable
    
    if(state == '1') { // if guess was correct, turn the green LED on for a second
      digitalWrite (greenLight, HIGH); 
      delay(1000);
      digitalWrite (greenLight, LOW); 
    }  

    if (state == '0') { // if guess was incorrect, turn the red LED on for a second
     digitalWrite (redLight, HIGH);
     delay(1000);
     digitalWrite (redLight, LOW); 
    } 
} 

  delay(500); //wait half a second intervals
}
