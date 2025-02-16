// Chesster main control loop 

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


// Include relevant libraries 
#include <ArduinoJson.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
#include <avr/wdt.h>

//Instantiate Display 
LiquidCrystal_I2C lcd(0x27, 20, 4);

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

  // define buffer size 
  #define SERIAL_BUFFER_SIZE 512
  
  // Instanitate Linear servo
  Servo linearServo;

  // initialize variables 
  int xorig = 0;
  int yorig = 0;
  int xnew = 0;
  int ynew = 0;
  bool kill = 0;

  int turn = 0;

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

  // initialize serial connection
  Serial.begin(9600);

}

void loop() {

  int buttonState = digitalRead(turnBut);

  // Standby for serial transmission from matlab 
  if (buttonState == LOW) {
  // Button is pressed (transition from HIGH to LOW)
    if (turn == 0) 
    {
      startPlay();
      turn += 1;
      lcd.setCursor(18,3);
      lcd.print(turn);
      delay(1000);
    } 
    else {
      signalMove();
      turn += 1;
      lcd.setCursor(18,3);
      lcd.print(turn);
      delay(1000);
    }
  }


 if (Serial.available() > 0) {

    String incomingData = "";
    incomingData = Serial.readStringUntil('\n');
    delay(100);
    lcd.setCursor(1, 1);
    lcd.print(incomingData);

    // Check for a trigger signaling move data is incoming at the beginning of the string
    if (incomingData.startsWith("** MOVE:")) {
      updateFromJson(incomingData, xorig, yorig, xnew, ynew, kill);

      lcd.clear();
      lcd.setCursor(1, 0);
      lcd.print("Move Received");
      delay(1000);

      String response = "** Arduino Received Move \n";
      Serial.print(response);

      if ( kill == 1){
        lcd.clear();
        lcd.setCursor(1, 0);
        lcd.print("Move Received - kill");
        delay(1000);
        killMove();
      }
      else if ( kill == 0){
        lcd.clear();
        lcd.setCursor(1, 0);
        lcd.print("Move Received - No kill");
        delay(1000);
        emptyMove();
      }
      else {
        lcd.clear();
        lcd.setCursor(1, 0);
        lcd.print("ERROR W/ KILL LOGIC");
        Serial.print("** ERROR W/ KILL LOGIC");
      }
      lcd.clear();
      lcd.setCursor(1, 0);
      lcd.print("Move Complete");
      Serial.print("** MOVED\n");

      lcd.setCursor(1, 1);
      lcd.print("Your Move");
   
       turn += 1;
    }
  }
}
// Move x poisiton motor
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

// home all motors 
void home(){
  homex();
  delay(1500);
  homey();
  delay(1500);
}

// Move to empty space 
void emptyMove(){

  // Move motors to current location of piece 
  movex(xorig);
  movey(yorig);
  delay(1000);

  // grab piece 
  extendz();
  delay(1000);
  retractz();

  // Move motors to new locations 
  movex(xnew);
  movey(ynew);

  // Release piece 
  extendz();
  delay(1000);
  retractz();

  // home motors 
  home();
}

// Move to occupied space
void killMove(){

  int xgrave = 100; // CHANGE TO ACTUAL VALUE 
  int ygrave = 100; // CHANGE TO ACTUAL VALUE 

  // Move motors to currently occupied new space 
  movex(xnew);
  movey(ynew);
  delay(1000);

  // grab piece 
  extendz();
  delay(1000);
  retractz();

  // Move motors to graveyard
  movex(xgrave);
  movey(ygrave);
  delay(1000);

  // Release piece 
  extendz();
  delay(1000);
  retractz();

  // home motors 
  home();

  // Move motors to current location of piece 
  movex(xorig);
  movey(yorig);
  delay(1000);

  // grab piece 
  extendz();
  delay(1000);
  retractz();

  // Move motors to new locations 
  movex(xnew);
  movey(ynew);
  delay(1000);

  // Release piece 
  extendz();
  delay(1000);
  retractz();

  // home motors 
  home();
}

void updateFromJson(const String& incomingData, int &xorig, int &yorig, int &xnew, int &ynew, bool &kill) {

  // Extract the JSON string after the start command
  String jsonStr = incomingData.substring(8); // Skip "** MOVE: "

  // Parse the JSON string
  StaticJsonDocument<512> doc;
  DeserializationError error = deserializeJson(doc, jsonStr);

  // Check for parsing errors
  if (error) {
    Serial.print("** Error parsing JSON: ");
    Serial.println(jsonStr);
    return;
  }

  // Update the function parameters with the JSON values
  xorig = doc["xo"];
  yorig = doc["yo"];
  xnew = doc["xn"];
  ynew = doc["yn"];
  kill = doc["kill"];

}

void startPlay(){

    lcd.clear();
    lcd.setCursor(1, 0);
    lcd.print("GETTING READY TO PLAY");

    home();
    lcd.clear();
    lcd.setCursor(1, 0);
    String mess = "** ARDUINO READY \n";
    lcd.print(mess);
    Serial.print(mess);

  // Matlab will send ready signal back 
    String incomingData = Serial.readStringUntil('\n');
    lcd.clear();
    lcd.setCursor(1, 0);
    lcd.print(incomingData);

    if (incomingData.startsWith("MATLAB READY")){
      lcd.clear();
      lcd.setCursor(1, 0);
      lcd.print("YOUR MOVE");
      lcd.setCursor(1, 1);
      lcd.print("PRESS BUTTON AFTER MOVE");
  } 
}

void signalMove() {
    lcd.clear();
    lcd.setCursor(1, 0);
    lcd.print("...Thinking...");
    Serial.print("** PLAY \n");
}
