package es.accenture.entidades;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "habitaciones")
public class Habitacion {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private String numero;
	
	@Column
	private String tipo;
	
	@Column
	private Double precio;
	
	@Column
	private Boolean disponible;
	
	@OneToMany(mappedBy = "habitacion", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Incidencia> incidencias = new ArrayList<>();

	public Habitacion(Long id, String numero, String tipo, Double precio, Boolean disponible, List<Incidencia> incidencias) {
		this.id = id;
		this.numero = numero;
		this.tipo = tipo;
		this.precio = precio;
		this.disponible = disponible;
		this.incidencias = incidencias;
		
	}
	
	public Habitacion() {}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Double getPrecio() {
		return precio;
	}

	public void setPrecio(Double precio) {
		this.precio = precio;
	}

	public Boolean getDisponible() {
		return disponible;
	}

	public void setDisponible(Boolean disponible) {
		this.disponible = disponible;
	}
	
	public List<Incidencia> getIncidencias(){
		return incidencias;
	}
	
	public void setIncidencias(List<Incidencia> incidencias) {
		this.incidencias = incidencias;
	}
	
	

	
}
