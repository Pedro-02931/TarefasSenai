package main.senai.com.calcularPoligonos.model;


public final class Circle extends Shape {
    private final double radius;

    public Circle(double radius) {
        super.validate(radius);
        this.radius = radius;
    }

    @Override
    public double getArea() {
        return Math.PI * Math.pow(radius, 2);
    }

    @Override
    public double getPerimeter() {
        return 2 * Math.PI * radius;
    }
}