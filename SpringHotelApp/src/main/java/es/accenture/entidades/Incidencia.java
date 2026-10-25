package es.accenture.entidades;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.time.LocalDate;

@Entity
@Table(name = "incidencias")
public class Incidencia {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private String descripcion;
	
	@Column
	private String estado;
	
	@Column
	private String prioridad;
	
	@Column(name = "fecha_reporte")
	private LocalDate fechaApertura;
	
	
	@ManyToOne
    @JoinColumn(name = "habitacion_id")
    private Habitacion habitacion;
	
	
	public Incidencia(Long id, String descripcion, String estado, String prioridad, LocalDate fechaApertura,
		 Habitacion habitacion) {
		this.id = id;
		this.descripcion = descripcion;
		this.estado = estado;
		this.prioridad = prioridad;
		this.fechaApertura = fechaApertura;
		this.habitacion = habitacion;
	}

	public Incidencia() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getPrioridad() {
		return prioridad;
	}

	public void setPrioridad(String prioridad) {
		this.prioridad = prioridad;
	}

	public LocalDate getFechaApertura() {
		return fechaApertura;
	}

	public void setFechaApertura(LocalDate fechaApertura) {
		this.fechaApertura = fechaApertura;
	}
	
	public Habitacion getHabitacion() {
		return habitacion;
	}
	
	public void setHabitacion(Habitacion habitacion) {
		this.habitacion = habitacion;
	}
	
	
}
