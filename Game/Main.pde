PImage backgroundImage;
PImage cubeImage;
GeometryDashGame game;

void setup() {
    size(800, 600);
    backgroundImage = loadImage("background1.jpg");
    backgroundImage.resize(width, height);
    cubeImage = loadImage("cube.png");
    game = new GeometryDashGame(backgroundImage, cubeImage);
}

void draw() {
    game.updateGame();
    game.drawGame(this.g);
}

void keyPressed() {
    if (key == ' ' && !game.gameOverFlag) {
        game.jumpPlayer();
    }
}

void mousePressed() {
    if (game.gameOverFlag) {
        game.initializeGame(cubeImage);
        loop();
    }
}