package main.senai.com.calcularPoligonos;

import main.senai.com.calcularPoligonos.model.*;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        while (running) {
            System.out.println("\n=== Menu de Formas Geométricas ===");
            System.out.println("1. Círculo");
            System.out.println("2. Retângulo");
            System.out.println("3. Quadrado");
            System.out.println("4. Triângulo Equilátero");
            System.out.println("5. Trapézio");
            System.out.println("6. Sair");
            System.out.print("Escolha uma opção: ");

            String escolha = scanner.nextLine();
            Shape forma = null; // Variável para armazenar a forma escolhida

            try {
                switch (escolha) {
                    case "1": // Círculo
                        System.out.print("Digite o raio do círculo: ");
                        double raio = scanner.nextDouble();
                        forma = new Circle(raio);
                        break;

                    case "2": // Retângulo
                        System.out.print("Digite a largura do retângulo: ");
                        double largura = scanner.nextDouble();
                        System.out.print("Digite a altura do retângulo: ");
                        double altura = scanner.nextDouble();
                        forma = new Rectangle(largura, altura);
                        break;

                    case "3": // Quadrado
                        System.out.print("Digite o lado do quadrado: ");
                        double lado = scanner.nextDouble();
                        forma = new Square(lado);
                        break;

                    case "4": // Triângulo Equilátero
                        System.out.print("Digite o lado do triângulo equilátero: ");
                        double ladoTriangulo = scanner.nextDouble();
                        forma = new Triangle(ladoTriangulo);
                        break;

                    case "5": // Trapézio
                        System.out.print("Digite a base maior do trapézio: ");
                        double baseMaior = scanner.nextDouble();
                        System.out.print("Digite a base menor do trapézio: ");
                        double baseMenor = scanner.nextDouble();
                        System.out.print("Digite a altura do trapézio: ");
                        double alturaTrapezio = scanner.nextDouble();
                        forma = new Trapezoid(baseMaior, baseMenor, alturaTrapezio);
                        break;

                    case "6": // Sair
                        System.out.println("Encerrando o programa. Até mais!");
                        running = false;
                        break;

                }


            } catch (Exception e) {
                System.out.println("Entrada inválida! Certifique-se de inserir valores numéricos positivos.");
                scanner.nextLine(); // Limpa o buffer do scanner
            }
        }

        scanner.close();
    }

    private static void exibirResultados(Shape forma) {
        System.out.printf("\nÁrea: %.2f\n", forma.getArea());
        System.out.printf("Perímetro: %.2f\n", forma.getPerimeter());
    }
}
