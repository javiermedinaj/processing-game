import java.util.ArrayList;
import processing.core.PGraphics;
import processing.core.PImage;

public class GeometryDashGame {
    private Player player;
    private ArrayList<Obstacle> obstacles;
    private int score;
    private boolean gameOverFlag;
    private PImage backgroundImage;
    private final float floorY = 550; 

    public GeometryDashGame(PImage backgroundImage, PImage cubeImage) {
        this.backgroundImage = backgroundImage;
        initializeGame(cubeImage);
    }

    public void initializeGame(PImage cubeImage) {
        player = new Player(100, floorY - 50, 50, cubeImage);
        obstacles = new ArrayList<>();
        score = 0;
        gameOverFlag = false;

        obstacles.add(new TriangleObstacle(800, floorY - 50, 50, 5));
        obstacles.add(new RectangleObstacle(1200, floorY - 0, 50, 5));
        obstacles.add(new CircleObstacle(1600, floorY - 0, 50, 5));
        obstacles.add(new SpikeObstacle(2000, floorY - 0, 50, 5));
    }

    public void updateGame() {
        player.move();
        moveObstacles();
        checkCollisions();
        updateScore();
    }

    public void drawGame(PGraphics pg) {
        pg.background(backgroundImage);
        player.draw(pg);
        for (Obstacle obs : obstacles) {
            obs.draw(pg);
        }
        pg.stroke(255); 
        pg.strokeWeight(2);
        pg.line(0, floorY, width, floorY); 
        pg.textSize(32);
        pg.fill(255);
        pg.text("Score: " + score, 20, 40);
        if (gameOverFlag) {
            displayRestartButton(pg);
        }
    }

    private void moveObstacles() {
        for (Obstacle obs : obstacles) {
            obs.move();
        }
        for (int i = obstacles.size() - 1; i >= 0; i--) {
            if (obstacles.get(i).getX() + obstacles.get(i).getSize() < 0) {
                obstacles.remove(i);
            }
        }
    }

    private void checkCollisions() {
        for (Obstacle obs : obstacles) {
            if (player.checkCollision(obs)) {
                gameOver();
            }
        }
    }

    private void updateScore() {
        if (!gameOverFlag) {
            score = frameCount / 60;
        }
    }

    public void gameOver() {
        gameOverFlag = true;
        noLoop();
    }

    public void jumpPlayer() {
        player.jump();
    }

    public void displayRestartButton(PGraphics pg) {
        pg.textSize(32);
        pg.fill(255, 255, 0);
        pg.text("Click to Restart", width / 2 - 100, height / 2 + 50);
    }
}
