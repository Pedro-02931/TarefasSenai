//  Criado para rodar em compiladores online

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

// Classe abstrata que define a estrutura para todas as formas geométricas
abstract class Shape {
    protected final void validate(double value) {
        if (value <= 0) {
            throw new IllegalArgumentException("Os valores devem ser > 0");
        }
    }

    protected final void validate(double v1, double v2) {
        if (v1 <= 0 || v2 <= 0) {
            throw new IllegalArgumentException("Os valores devem ser > 0");
        }
    }

    protected final void validate(double v1, double v2, double v3) {
        if (v1 <= 0 || v2 <= 0 || v3 <= 0) {
            throw new IllegalArgumentException("Os valores devem ser > 0");
        }
    }

    public abstract double getArea();
    public abstract double getPerimeter();
}

// Implementação das classes das formas geométricas
final class Circle extends Shape {
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

final class Rectangle extends Shape {
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

final class Square extends Shape {
    private final double side;

    public Square(double side) {
        validate(side);
        this.side = side;
    }

    @Override
    public final double getArea() {
        return side * side;
    }

    @Override
    public final double getPerimeter() {
        return 4 * side;
    }
}

final class Trapezoid extends Shape {
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

final class Triangle extends Shape {
    private static final double AREA_CONSTANT = Math.sqrt(3) * 0.25;
    private final double side;

    public Triangle(double side) {
        validate(side);
        this.side = side;
    }

    @Override
    public final double getArea() {
        return AREA_CONSTANT * side * side;
    }

    @Override
    public final double getPerimeter() {
        return 3 * side;
    }
}

// Classe Main que gerencia a execução do programa
public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        boolean running = true;

        while (running) {
            System.out.println("Escolha a forma geométrica desejada: \n"
                + "1 - Círculo\n"
                + "2 - Retângulo\n"
                + "3 - Quadrado\n"
                + "4 - Triângulo\n"
                + "5 - Trapézio\n"
                + "6 - Sair\n"
                + "Digite o número correspondente: ");

            String input = reader.readLine();

            if (input == null) break; // Evita crash inesperado

            Shape shape = null; // Inicializa sem alocar desnecessariamente

            try {
                switch (input.trim()) {
                    case "1":
                        System.out.print("Digite o raio: ");
                        double radius = parseDouble(reader);
                        shape = new Circle(radius);
                        break;

                    case "2":
                        System.out.print("Digite a largura: ");
                        double width = parseDouble(reader);
                        System.out.print("Digite a altura: ");
                        double height = parseDouble(reader);
                        shape = new Rectangle(width, height);
                        break;

                    case "3":
                        System.out.print("Digite o lado: ");
                        double side = parseDouble(reader);
                        shape = new Square(side);
                        break;

                    case "4":
                        System.out.print("Digite o lado: ");
                        double sideTri = parseDouble(reader);
                        shape = new Triangle(sideTri);
                        break;

                    case "5":
                        System.out.print("Digite a base maior: ");
                        double biggerBase = parseDouble(reader);
                        System.out.print("Digite a base menor: ");
                        double smallerBase = parseDouble(reader);
                        System.out.print("Digite a altura: ");
                        double trapHeight = parseDouble(reader);
                        shape = new Trapezoid(biggerBase, smallerBase, trapHeight);
                        break;

                    case "6":
                        running = false;
                        System.out.println("Saindo do sistema...");
                        break;

                    default:
                        System.out.println("Opção inválida. Por favor, tente novamente.");
                }

                if (shape != null) {
                    exibirResultados(shape);
                }

            } catch (NumberFormatException e) {
                System.out.println("Número inválido. Por favor, tente novamente.");
            } catch (IllegalArgumentException e) {
                System.out.println(e.getMessage());
            }
        }

        reader.close();
    }

    private static double parseDouble(BufferedReader reader) throws IOException {
        String line = reader.readLine();
        if (line == null) throw new IOException("EOF inesperado durante a leitura.");
        return Double.parseDouble(line.trim());
    }

    private static void exibirResultados(Shape shape) {
        System.out.printf("\nÁrea: %.2f\nPerímetro: %.2f\n",
                shape.getArea(), shape.getPerimeter());
    }
}
