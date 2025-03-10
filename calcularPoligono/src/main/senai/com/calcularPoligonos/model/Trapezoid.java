package main.senai.com.calcularPoligonos.model;

public final class Trapezoid extends Shape {
    private final double biggerBase;
    private final double smallerBase;
    private final double height;

    public Trapezoid(double biggerBase, double smallerBase, double height) {
        validate(biggerBase, smallerBase, height);
        this.biggerBase = biggerBase;
        this.smallerBase = smallerBase;
        this.height = height;
    }

    @Override
    public double getArea() {
        return ((biggerBase + smallerBase) / 2) * height;
    }

    @Override
    public double getPerimeter() {
        return biggerBase + smallerBase + (2 * height);
    }
}
