package es.accenture.dao;

import java.util.List;

import es.accenture.entidades.Incidencia;

public interface IncidenciaDAO {
	
	List<Incidencia> findAll();

    Incidencia findById(int id);

    void save(Incidencia incidencia);

    void update(Incidencia incidencia);

    void delete(int id);


}
