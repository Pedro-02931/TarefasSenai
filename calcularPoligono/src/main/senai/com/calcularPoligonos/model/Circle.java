package main.senai.com.calcularPoligonos.model;

public final class Circle extends Shape {
    private final double radius;

    public Circle(double radius) {
        validate(radius);
        this.radius = radius;
    }

    @Override
    public final double getArea() {
        return Math.PI * radius * radius;
    }

    @Override
    public final double getPerimeter() {
        return 2 * Math.PI * radius;
    }
}
