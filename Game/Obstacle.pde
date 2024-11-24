public class Obstacle implements ObstacleInterface {
    protected float x, y, size, speed;
    protected boolean scored;  

    public Obstacle(float x, float y, float size, float speed) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.speed = speed;
        this.scored = false;
    }

    @Override
    public void move() {
        x -= speed;
    }

    @Override
    public void draw(PGraphics pg) {
        // Metodo para subclases como el del rectangulo / triangulo y el spike
    }

    @Override
    public float getX() {
        return x;
    }

    @Override
    public float getY() {
        return y;
    }

    @Override
    public float getSize() {
        return size;
    }
    
    @Override
    public boolean isScored() {
        return scored;
    }

    @Override
    public void setScored(boolean scored) {
        this.scored = scored;
    }
}