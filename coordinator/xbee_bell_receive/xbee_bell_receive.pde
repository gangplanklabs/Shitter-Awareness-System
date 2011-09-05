/* Digital pin connected to the counter's clock pin */
int shitter_clock_pin = 2; 
/* Digital pin connected to the counter's reset pin */
int shitter_reset_pin = 3;
boolean shitter_occupied = false;
/* Digital pin connected to the counter's clock pin */
int pisser_clock_pin = 4; 
/* Digital pin connected to the counter's reset pin */
int pisser_reset_pin = 5;
boolean pisser_occupied = false;

void setup(){
  Serial.begin(9600);
  pinMode(shitter_clock_pin,OUTPUT);
  pinMode(shitter_reset_pin,OUTPUT);
  pinMode(pisser_clock_pin,OUTPUT);
  pinMode(pisser_reset_pin,OUTPUT);
  reset(0);
  pinMode(13,OUTPUT);
}

void loop(){
  int n = 7;
  int primary = -1;
  int secondary = -1;
  
  if (Serial.available() > 0){
    primary = Serial.read();
    if (primary == 'S' || primary == 'P'){
      delay(50);
      secondary = Serial.read();
      if (primary == 'S'){
        if (secondary == 'R'){
          shitter_occupied = true;
        } else {
          shitter_occupied = false;
        }
      } else if (primary == 'P'){
        if (secondary == 'R'){
          pisser_occupied = true;
        } else {
          pisser_occupied = false;
        }
      }
    }
  }
  
  primary = -1;
  secondary = -1;
  
  if (shitter_occupied == true && pisser_occupied == true){
    for( int i = 0; i < n; i++ ) {
      delay(50);
      clock(3);
    }
  } else if (pisser_occupied == true) {
    for( int i = 0; i < n; i++ ) {
      delay(50);
      clock(1);
    }
    reset(2);
  } else if (shitter_occupied == true) {
    for( int i = 0; i < n; i++ ) {
      delay(50);
      clock(2);
    }
    reset(1);  
  } else {
    reset(3);
  }
}

/*
 * Sends a clock pulse to the counter making it advance.
 */
void clock(int lights) {
  
  switch (lights) {
    case 1:
      digitalWrite(pisser_clock_pin,HIGH);
      delay(1);
      digitalWrite(pisser_clock_pin,LOW);
    case 2:
      digitalWrite(shitter_clock_pin,HIGH);
      delay(1);
      digitalWrite(shitter_clock_pin,LOW);
      break;
    case 3:
      digitalWrite(pisser_clock_pin,HIGH);
      delay(1);
      digitalWrite(pisser_clock_pin,LOW);
      digitalWrite(shitter_clock_pin,HIGH);
      delay(1);
      digitalWrite(shitter_clock_pin,LOW);
      break;
    default:
      break;
  }
}
 
/*
 * Resets the counter making it start counting from zero.
 */
void reset(int lights) {
  switch (lights) {
    case 1:
      digitalWrite(pisser_reset_pin,HIGH);
      delay(1);
      digitalWrite(pisser_reset_pin,LOW);
      break;
    case 2:
      digitalWrite(shitter_reset_pin,HIGH);
      delay(1);
      digitalWrite(shitter_reset_pin,LOW);
      break;
    default:
      digitalWrite(pisser_reset_pin,HIGH);
      delay(1);
      digitalWrite(pisser_reset_pin,LOW);
      digitalWrite(shitter_reset_pin,HIGH);
      delay(1);
      digitalWrite(shitter_reset_pin,LOW);
      break;
  }
}
