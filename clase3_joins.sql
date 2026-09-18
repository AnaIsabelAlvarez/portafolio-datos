-- Tabla de laboratorios que procesan las muestras
CREATE TABLE laboratorios (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre_laboratorio VARCHAR(100),
    departamento VARCHAR(50),
    certificado_ica BOOLEAN         
);

INSERT INTO laboratorios (nombre_laboratorio, departamento, certificado_ica)
VALUES
    ('LabVet Antioquia', 'Antioquia', TRUE),
    ('DiagnoVet Córdoba', 'Córdoba', TRUE),
    ('BioSalud Sucre', 'Sucre', FALSE);

-- Conectar casos_brucelosis con la nueva tabla
ALTER TABLE casos_brucelosis ADD COLUMN id_laboratorio INT;

-- Asigna laboratorio según el departamento de cada caso
UPDATE casos_brucelosis SET id_laboratorio = 1 WHERE departamento = 'Antioquia';
UPDATE casos_brucelosis SET id_laboratorio = 2 WHERE departamento = 'Córdoba';
UPDATE casos_brucelosis SET id_laboratorio = 3 WHERE departamento = 'Sucre';

-- Trae datos de ambas tablas en una sola consulta
SELECT c.municipio,
       c.resultado,
       l.nombre_laboratorio,
       l.certificado_ica
FROM casos_brucelosis AS c                       
INNER JOIN laboratorios AS l                         
    ON c.id_laboratorio = l.id_laboratorio            
;

-- Conserva todas las filas de la tabla casos_brucelosis aunque no tengan laboratorio asignado
SELECT c.municipio,
       c.resultado,
       l.nombre_laboratorio
FROM casos_brucelosis AS c
LEFT JOIN laboratorios AS l
    ON c.id_laboratorio = l.id_laboratorio
;

-- ¿Cuántos casos positivos procesó cada laboratorio certificado por el ICA?
SELECT l.nombre_laboratorio,
       COUNT(*) AS casos_positivos
FROM casos_brucelosis AS c
INNER JOIN laboratorios AS l
    ON c.id_laboratorio = l.id_laboratorio
WHERE c.resultado = 'positivo'         
  AND l.certificado_ica = TRUE           
GROUP BY l.nombre_laboratorio
ORDER BY casos_positivos DESC;

--"El ICA quiere saber, para cada municipio, el nombre del laboratorio que procesó sus muestras y si ese laboratorio está certificado. Además, quiere ver explícitamente los casos que no tengan laboratorio certificado asociado (por ejemplo, si falta el dato), para investigarlos."

SELECT c.municipio,
       c.resultado,
       l.nombre_laboratorio,
       l.certificado_ica
FROM casos_brucelosis AS c
LEFT JOIN laboratorios AS l
    ON c.id_laboratorio = l.id_laboratorio
ORDER BY l.certificado_ica ASC NULLS FIRST; 

--Ejercicio 1:
-- Trae el municipio, el resultado del caso y el nombre del laboratorio, solo para los laboratorios que sí están certificados por el ICA
SELECT c.municipio, c.resultado, l.nombre_laboratorio
FROM casos_brucelosis AS c 
INNER JOIN laboratorios AS l
    ON c.id_laboratorio = l.id_laboratorio
WHERE  l.certificado_ica = TRUE

--Ejercicio 2:
--Cuenta cuántos casos procesó cada laboratorio ordenado de mayor a menor.
SELECT l.nombre_laboratorio, 
     COUNT(*) AS total_casos
FROM casos_brucelosis AS c 
 INNER JOIN laboratorios AS l 
         ON c.id_laboratorio = l.id_laboratorio 
GROUP BY l.nombre_laboratorio 
ORDER BY total_casos DESC;

--Ejercicio 3:
-- Trae todos los casos junto con el nombre de su laboratorio — y para los que no tengan laboratorio certificado, que aparezca igual el registro
SELECT c.municipio,
       c.resultado,
       l.nombre_laboratorio,
       l.certificado_ica
FROM casos_brucelosis AS c
LEFT JOIN laboratorios AS l
    ON c.id_laboratorio = l.id_laboratorio
