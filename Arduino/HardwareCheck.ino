////////////// Pinout ////////////// 
// X axis home button pin- 5
// X axis driver step pin - 3
// X axis driver direction pin - 4
// Y axis home button pin- 8
// Y axis driver step pin - 6
// Y axis driver direction pin - 7
// Linear Actuator servo pin - 9
// Play button pin - 12
// LCD SDA - 20
// LCD SCL - 21

//Include Libraries
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
#include <avr/wdt.h>

 // initialize stepper pins and actuator 
  #define dirPinx 4 
  #define stepPinx 3
  #define dirPiny 7 
  #define stepPiny 6
  #define servoPin 9

  // define button pins
  #define xhomePin 5
  #define yhomePin 8
  #define turnBut 12

 // Instanitate Linear servo
  Servo linearServo;

//Instantiate Display 
  LiquidCrystal_I2C lcd(0x27, 20, 4);

void setup() {
    // Declare pins as Outputs
	pinMode(stepPinx, OUTPUT);
	pinMode(dirPinx, OUTPUT);

  pinMode(stepPiny, OUTPUT);
	pinMode(dirPiny, OUTPUT);

  pinMode(servoPin,OUTPUT);

  // Declare Homing pins 
  pinMode(xhomePin, INPUT_PULLUP);
  pinMode(yhomePin, INPUT_PULLUP);
  pinMode(turnBut, INPUT_PULLUP);


  // Attach servo pin
  linearServo.attach(servoPin);

  // Initialize LCD
  lcd.init();
  lcd.backlight();
  lcd.setCursor(1, 0);
  lcd.print("ARDUINO STANDING BY");

}

void loop() {
  // put your main code here, to run repeatedly:

  int buttonState = digitalRead(turnBut);

  // press button to start 
   if (buttonState == LOW) {
    // x 25 steps
    movex(25);
  // y 25 steps
    movey(25);
  // linear actuator down 
    extendz();
  // linear actuator up
    retractz();
  // homex
    homex();
  // homey 
    homey();
   }
}

void movex(int steps){
  // spin stepper clockwise 
  digitalWrite(dirPinx, HIGH);

  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Moving X");
  lcd.setCursor(1, 1);
  lcd.print(steps);

  for(int x = 0; x < steps; x++)
	{
		digitalWrite(stepPinx, HIGH);
		delay(10);
		digitalWrite(stepPinx, LOW);
		delay(10);
	}
}

// Move y poisiton motor 
void movey(int steps){
  // spin stepper clockwise 
  digitalWrite(dirPiny, HIGH);

  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Moving Y");
  lcd.setCursor(1, 1);
  lcd.print(steps);

  for(int y = 0; y < steps; y++)
	{
		digitalWrite(stepPiny, HIGH);
		delay(10);
		digitalWrite(stepPiny, LOW);
		delay(10);
	}
}

//Lower linear actuator
void extendz(){
  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Extending Z");

  linearServo.writeMicroseconds(2000);
  delay(5000);
}

//Raise linear actuator
void retractz(){
  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Retracting Z");
  linearServo.writeMicroseconds(1000);
  delay(5000);
}

// home x stepper 
void homex(){

  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Homing X");

  while (digitalRead(xhomePin)) {    
    digitalWrite(dirPinx, LOW);    
    digitalWrite(stepPinx, HIGH);
    delay(10);                       
    digitalWrite(stepPinx, LOW);
    delay(10);   
  }
  while (!digitalRead(xhomePin)) { 
    digitalWrite(dirPinx, HIGH); 
    digitalWrite(stepPinx, HIGH);
    delay(10);                      
    digitalWrite(stepPinx, LOW);
    delay(10);
  }
  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Homing X - Complete");
}

// home y stepper 
void homey(){

  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Homing Y");

  while (digitalRead(yhomePin)) {    
    digitalWrite(dirPiny, LOW);    
    digitalWrite(stepPiny, HIGH);
    delay(10);                       
    digitalWrite(stepPiny, LOW);
    delay(10);   
  }
  while (!digitalRead(yhomePin)) { 
    digitalWrite(dirPiny, HIGH); 
    digitalWrite(stepPiny, HIGH);
    delay(10);                      
    digitalWrite(stepPiny, LOW);
    delay(10);
  }
  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print("Homing Y - Complete");
}