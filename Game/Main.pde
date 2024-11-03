PImage backgroundImage;
PImage cubeImage;
PImage coinImage;
GeometryDashGame game;

void setup() {
    size(800, 600);
    backgroundImage = loadImage("background1.jpg");
    backgroundImage.resize(width, height);
    cubeImage = loadImage("cube.png");
    coinImage = loadImage("coin.png");
    game = new GeometryDashGame(backgroundImage, cubeImage, coinImage);
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