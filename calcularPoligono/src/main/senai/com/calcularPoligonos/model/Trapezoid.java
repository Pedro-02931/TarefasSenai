package main.senai.com.calcularPoligonos.model;

public final class Trapezoid extends Shape {
    private final double height;
    private final double biggerBase;
    private final double smallerBase;

    public Trapezoid(double biggerBase, double smallerBase, double height) {
        validate(biggerBase, smallerBase, height);
        this.biggerBase = biggerBase;
        this.smallerBase = smallerBase;
        this.height = height;
    }

    @Override
    public final double getArea() {
        return (biggerBase + smallerBase) * height * 0.5;
    }

    @Override
    public final double getPerimeter() {
        return biggerBase + smallerBase + (2 * height);
    }
}
