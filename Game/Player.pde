import java.util.ArrayList;

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

    public float getX() {
        return x;
    }

    public void move(ArrayList<Platform> platforms) {
        if (isJumping) {
            speedY += gravity;
            y += speedY;
            rotationAngle += 0.1;
        }

        boolean onPlatform = false;
        for (Platform platform : platforms) {
            if (y + size >= platform.getY() && y + size <= platform.getY() + platform.getHeight() && x + size > platform.getX() && x < platform.getX() + platform.getWidth()) {
                y = platform.getY() - size;
                isJumping = false;
                rotationAngle = 0;
                onPlatform = true;
                break;
            }
        }

        if (!onPlatform) {
            if (y >= 550 - size) {
                y = 550 - size;
                isJumping = false;
                rotationAngle = 0;
            } else {
                isJumping = true;
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

    public boolean checkCollision(Coin coin) {
        return x < coin.getX() + coin.getSize() && x + size > coin.getX() &&
               y < coin.getY() + coin.getSize() && y + size > coin.getY();
    }
}