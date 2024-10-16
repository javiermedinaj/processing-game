import processing.core.PGraphics;
import processing.core.PImage;

public class Player {
    private float x, y, size, speedY;
    private boolean isJumping;
    private final float gravity = 0.6f;
    private PImage cubeImage;
    private float rotationAngle;

    public Player(float x, float y, float size, PImage cubeImage) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.speedY = 0;
        this.isJumping = false;
        this.cubeImage = cubeImage;
        this.rotationAngle = 0;
    }

    public void move() {
        if (isJumping) {
            speedY += gravity;
            y += speedY;
            rotationAngle += 0.1; 
            if (y >= 550 - size) { 
                y = 550 - size;
                isJumping = false;
                rotationAngle = 0; 
            }
        }
    }

    public void jump() {
        if (!isJumping) {
            speedY = -12;
            isJumping = true;
        }
    }

    public void draw(PGraphics pg) {
        pg.pushMatrix();
        pg.translate(x + size / 2, y + size / 2);
        pg.rotate(rotationAngle);
        pg.imageMode(PGraphics.CENTER);
        pg.image(cubeImage, 0, 0, size, size);
        pg.popMatrix();
    }

    public boolean checkCollision(Obstacle obs) {
        return x < obs.getX() + obs.getSize() && x + size > obs.getX() &&
               y < obs.getY() + obs.getSize() && y + size > obs.getY();
    }
}
