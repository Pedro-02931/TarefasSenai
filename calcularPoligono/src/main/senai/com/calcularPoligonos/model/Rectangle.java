package main.senai.com.calcularPoligonos.model;

public final class Rectangle extends Shape {
    private final double width;
    private final double height;

    public Rectangle(double width, double height) {
        validate(width, height);
        this.width = width;
        this.height = height;
    }

    @Override
    public final double getArea() {
        return width * height;
    }

    @Override
    public final double getPerimeter() {
        return 2 * (width + height);
    }
}
