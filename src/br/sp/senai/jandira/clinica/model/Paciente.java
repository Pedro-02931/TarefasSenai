package br.sp.senai.jandira.clinica.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


public class Paciente {
	private String nome;
	private double peso;
	private double altura;
	private String genero;
	private String telefone;
	private LocalDate dataNascimento;
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

	public void setNome(String nome) {
		if (nome.length() <= 3 | nome.isBlank()) {
			System.out.println("O nome não pode estar vazio ou ter menos que 3 caracteres!");
		} else {
			this.nome = nome;
		}

	}

	public String getNome() {
		return this.nome;
	}

	public void setPeso(double peso) {
		if (peso > 0) {
			this.peso = peso;
		} else {
			System.out.println("O peso deve ser maior que zero!");
		}
	}

	public double getPeso() {
		return this.peso;
	}

	public void setAltura(double altura) {
		if (altura > 1) {
			this.altura = altura;
		} else {
			System.out.println("A altura deve ser maior que zero!");
		}
	}

	public double getAltura() {
		return this.altura;
	}

	public void setGenero(String genero) {
		switch (genero) {
		case "M":
			this.genero = "Masculino";
			break;

		case "F":
			this.genero = "Feminino";
			break;
		default:
			System.out.println("===================");
			System.out.println("O genero deve ser preenchido como 'M' para masculino ou 'F' para feminino");
		}

	}

	public String getGenero() {
		return this.genero;
	}

	public void setTelefone(String telefone) {
		if (telefone.length() < 8 | telefone.isBlank()) {
			System.out.println("O campo telefone não pode estar vazio ou ter menos que 8 caracteres!");
		} else {
			this.telefone = telefone;
		}
	}

	public String getTelefone() {
		return this.telefone;
	}

	
 	public void setDataNascimento(LocalDate dataNascimento) {
		this.dataNascimento = dataNascimento;
	}
	
	public void marcarConsulta() {

	}

	public void calcularIdade() {

	}

	public void calcularImc() {

		double imc = this.peso / (this.altura * this.altura);

	}

	public void classificarImc() {

	}

	public void exibirDados() {

		String unidadePeso = "kg. \n";
		String separadorCampos = "===================";
		System.out.println(separadorCampos);
		System.out.println("DADOS DO PACIENTE");
		System.out.println(separadorCampos);
		if (this.nome != null) {
			System.out.println(("nome: " + nome).toUpperCase());
		} else {
			System.out.println("nome: *****".toUpperCase());
		}

		System.out.println(separadorCampos);
		System.out.printf("PESO: %s %s", peso, unidadePeso);
		System.out.println(separadorCampos);
		System.out.println("ALTURA: " + altura);
		System.out.println(separadorCampos);
		System.out.println(("Genero: " + genero).toUpperCase());
		System.out.println(separadorCampos);
		System.out.println(("Telefone: " + telefone).toUpperCase());
		System.out.println(separadorCampos);
		System.out.println(("data de nascimento: " + dataNascimento.format(formatter)).toUpperCase());

	}

}
