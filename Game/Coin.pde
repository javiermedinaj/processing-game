public class Coin {
    private float x, y, size;
    private boolean collected;
    private PImage coinImage;

    public Coin(float x, float y, float size, PImage coinImage) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.collected = false;
        this.coinImage = coinImage;
    }

    public void move(float speed) {
        x -= speed;
    }

    public void draw(PGraphics pg) {
        if (!collected) {
            pg.image(coinImage, x, y, size, size);
        }
    }

    public boolean isCollected() {
        return collected;
    }

    public void collect() {
        collected = true;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getSize() {
        return size;
    }
}