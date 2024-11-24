public interface ObstacleInterface {
    void move();
    void draw(PGraphics pg);
    float getX();
    float getY();
    float getSize();
    boolean isScored();
    void setScored(boolean scored);
}