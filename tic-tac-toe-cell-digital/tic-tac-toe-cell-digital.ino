/*

*/

bool isPlayed1;
bool button1Player1;
bool prevButton1;

bool isPlayed2;
bool button2Player1;
bool prevButton2;

bool isPlayed3;
bool button3Player1;
bool prevButton3;

bool player1Turn;

bool prevOtherBoardsButtonPressed;

bool circuit1Pressed;
bool circuit2Pressed;

void setup() {
    Serial.begin(9600);

    pinMode(3, OUTPUT);

    pinMode(10, INPUT); // Cell 1
    pinMode(11, INPUT); // Cell 2
    pinMode(12, INPUT); // Cell 3

    pinMode(4, OUTPUT); // Player 1
    pinMode(7, OUTPUT); // Player 2

    pinMode(5, OUTPUT); // Player 1
    pinMode(8, OUTPUT); // Player 2

    pinMode(6, OUTPUT); // Player 1
    pinMode(9, OUTPUT); // Player 2

    isPlayed1 = false;
    isPlayed2 = false;
    isPlayed3 = false;

    prevButton1 = false;
    prevButton2 = false;
    prevButton3 = false;

    button1Player1 = false;
    button2Player1 = false;
    button3Player1 = false;

    player1Turn = true;

    circuit1Pressed = false;
    circuit2Pressed = false;
}

void loop() {
    bool button1 = digitalRead(10);
    bool button2 = digitalRead(11);
    bool button3 = digitalRead(12);

    digitalWrite(3, (button1 && !isPlayed1) || (button2 && !isPlayed2) || (button3 && !isPlayed3));

    if (button1 && !prevButton1 && !isPlayed1) {
      isPlayed1 = true;
      button1Player1 = player1Turn;
      player1Turn = !player1Turn;
    }

    if (button2 && !prevButton2 && !isPlayed2) {
      isPlayed2 = true;
      button2Player1 = player1Turn;
      player1Turn = !player1Turn;
    }

    if (button3 && !prevButton3 && !isPlayed3) {
      isPlayed3 = true;
      button3Player1 = player1Turn;
      player1Turn = !player1Turn;
    }

    bool otherBoardsButtonsPressed = (analogRead(A0) > 500) || (analogRead(A1) > 500);

    if (otherBoardsButtonsPressed && !prevOtherBoardsButtonPressed) {
      player1Turn = !player1Turn;
    }

    Serial.println(player1Turn);

    digitalWrite(4, isPlayed1 && button1Player1);
    digitalWrite(7, isPlayed1 && !button1Player1);

    digitalWrite(5, isPlayed2 && button2Player1);
    digitalWrite(8, isPlayed2 && !button2Player1);

    digitalWrite(6, isPlayed3 && button3Player1);
    digitalWrite(9, isPlayed3 && !button3Player1);

    prevButton1 = button1;
    prevButton2 = button2;
    prevButton3 = button3;

    prevOtherBoardsButtonPressed = otherBoardsButtonsPressed;
    delay(50);
}
