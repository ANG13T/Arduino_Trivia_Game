#include <Wire.h>
#include <LiquidCrystal_I2C.h>

#define redLight 2
#define greenLight 3
#define button1 4
#define button2 5
#define button3 6

LiquidCrystal_I2C lcd = LiquidCrystal_I2C(0x27, 20, 4);

void setup() {
  // put your setup code here, to run once:
  pinMode(button1, INPUT);
  pinMode(button2, INPUT);
  pinMode(button3, INPUT);
  pinMode(redLight, OUTPUT);
  pinMode(greenLight, OUTPUT);
  Serial.begin(9600);
  lcd.init();
  lcd.backlight();
  lcd.print("UWU");
}

void loop() {
  // put your main code here, to run repeatedly:
  
  if(digitalRead(button1) == HIGH){
    Serial.println("1");
  }

  if(digitalRead(button2) == HIGH){
    Serial.println("2");
  }

  if(digitalRead(button3) == HIGH){
    Serial.println("3");
  }

  if (Serial.available ( ) > 0) {   // Checking if the Processing IDE has send a value or not
    char state = Serial.read ( );    // Reading the data received and saving in the state variable
    
    if(state == '1') { 
      digitalWrite (greenLight, HIGH); 
      delay(1000);
      digitalWrite (greenLight, LOW); 
    }  

    if (state == '0') {     // If received data is '0', then turn off led
     digitalWrite (redLight, HIGH);
     delay(1000);
     digitalWrite (redLight, LOW); 
    } 
} 

  delay(500);
}
