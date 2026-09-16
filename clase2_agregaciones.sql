-- ALTER TABLE modifica la estructura de una tabla existente
ALTER TABLE casos_brucelosis ADD COLUMN edad_meses INT;

-- Actualiza los registros que ya existían con edades simuladas
UPDATE casos_brucelosis SET edad_meses = 36 WHERE id = 1;
UPDATE casos_brucelosis SET edad_meses = 48 WHERE id = 2;
UPDATE casos_brucelosis SET edad_meses = 24 WHERE id = 3;
UPDATE casos_brucelosis SET edad_meses = 18 WHERE id = 4;
UPDATE casos_brucelosis SET edad_meses = 60 WHERE id = 5;
UPDATE casos_brucelosis SET edad_meses = 30 WHERE id = 6;

-- Agrega más casos
INSERT INTO casos_brucelosis (departamento, municipio, fecha_reporte, resultado, especie, edad_meses)
VALUES
    ('Antioquia', 'Santa Rosa', '2026-02-20', 'positivo', 'bovino', 42),
    ('Córdoba', 'Sahagún', '2026-03-01', 'positivo', 'bovino', 54),
    ('Sucre', 'Corozal', '2026-03-05', 'negativo', 'bovino', 28),
    ('Sucre', 'Sampués', '2026-03-10', 'positivo', 'caprino', 15),
    ('Antioquia', 'Yarumal', '2026-03-12', 'positivo', 'bovino', 36),
    ('Córdoba', 'Lorica', '2026-03-15', 'negativo', 'caprino', 22);

-- Ejercicio 1
--El ICA necesita un reporte de vigilancia: para cada departamento, cuántos casos positivos de brucelosis bovina se detectaron, 
--cuál fue la edad promedio de los animales afectados, y la fecha del caso más reciente. Solo incluir departamentos con 2 o más casos positivos,
--ordenados de mayor a menor número de casos.
SELECT departamento,
       COUNT(*) AS casos_positivos,
       ROUND(AVG(edad_meses)::numeric, 1) AS edad_promedio_meses,
       MAX(fecha_reporte) AS caso_mas_reciente
FROM casos_brucelosis
WHERE resultado = 'positivo'
  AND especie = 'bovino'
GROUP BY departamento
HAVING COUNT(*) >= 2
ORDER BY casos_positivos DESC;

-- Ejercicio 2
--Cuenta cuántos casos hay en total por cada especie (bovino / caprino)
 SELECT  especie,
       COUNT(*) AS total_casos   
FROM casos_brucelosis
GROUP BY especie;

-- Ejercicio 3
--Para cada departamento, muestra cuántos casos negativos hubo
SELECT  departamento,
       COUNT(*) AS casos_negativos
FROM casos_brucelosis
WHERE resultado = 'negativo'
GROUP BY departamento;

-- Ejercicio 4
--Muestra la edad mínima, máxima y promedio (redondeada a 1 decimal) de todos los animales con resultado positivo
SELECT   MAX(edad_meses) AS edad_maxima,
                    MIN (edad_meses) AS edad_minima,
       ROUND(AVG(edad_meses)::numeric, 1) AS edad_promedio_meses       
FROM casos_brucelosis
WHERE resultado = 'positivo';

-- Ejercicio 5
Para cada departamento, muestra el número total de casos y la fecha del primer caso reportado, pero solo los departamentos que tengan 4 o más casos registrados
SELECT departamento,
       COUNT(*) AS total_casos,
       MIN(fecha_reporte) AS primer_caso
FROM casos_brucelosis
GROUP BY departamento
HAVING COUNT(*) >= 4;