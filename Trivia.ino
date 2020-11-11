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
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(greenLight, HIGH);
  digitalWrite(redLight, HIGH);
  if(digitalRead(button1) == "HIGH"){
    Serial.println("button presed");
  }

  if(digitalRead(button2) == "HIGH"){
    Serial.println("button presed");
  }

  if(digitalRead(button3) == "HIGH"){
    Serial.println("button presed");
  }
}
