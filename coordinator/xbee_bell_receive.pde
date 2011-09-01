//int BELL = 13;
 /* Digital pin connected to the counter's clock pin */
int clockPin = 2;
 
/* Digital pin connected to the counter's reset pin */
int resetPin = 3;
boolean occupied = false;

void setup(){
  Serial.begin(9600);
  //pinMode(BELL,OUTPUT);
  pinMode(clockPin,OUTPUT);
  pinMode(resetPin,OUTPUT);
  reset();
}

void loop(){
  int n = 7;
  if (Serial.available() > 0){
    if (Serial.read() == 'R'){
      occupied = true;
    } else {
      occupied = false;
    }
  } else {
    occupied = false;
  }
  if (occupied == true){
    //digitalWrite(BELL,HIGH);   
    for( int i = 0; i < n; i++ ) {
      delay(50);
      clock();
    }
  } else {
    //digitalWrite(BELL,LOW);
    reset();
  }
}

/*
 * Sends a clock pulse to the counter making it advance.
 */
void clock() {
  digitalWrite(clockPin,HIGH);
  delay(1);
  digitalWrite(clockPin,LOW);
}
 
/*
 * Resets the counter making it start counting from zero.
 */
void reset() {
  digitalWrite(resetPin,HIGH);
  delay(1);
  digitalWrite(resetPin,LOW);
}
