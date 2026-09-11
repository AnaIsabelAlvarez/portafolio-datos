CREATE TABLE casos_brucelosis (
    id SERIAL PRIMARY KEY,          
    departamento VARCHAR(50),       
    municipio VARCHAR(50),
    fecha_reporte DATE,            
    resultado VARCHAR(10),          
    especie VARCHAR(20)            
);

INSERT INTO casos_brucelosis (departamento, municipio, fecha_reporte, resultado, especie)
VALUES
    ('Antioquia', 'Rionegro', '2026-01-15', 'positivo', 'bovino'),
    ('Antioquia', 'Marinilla', '2026-01-18', 'negativo', 'bovino'),
    ('Córdoba', 'Montería', '2026-01-20', 'positivo', 'bovino'),
    ('Córdoba', 'Cereté', '2026-02-02', 'positivo', 'caprino'),
    ('Antioquia', 'La Ceja', '2026-02-10', 'negativo', 'bovino'),
    ('Sucre', 'Sincelejo', '2026-02-14', 'positivo', 'bovino');

-- Ejercicio 1
-- Saber qué casos de brucelosis bovina dieron positivo en Antioquia, ordenados del más reciente al más antiguo
SELECT municipio, fecha_reporte, resultado, especie  
FROM casos_brucelosis                                  
WHERE departamento = 'Antioquia'                        
  AND especie = 'bovino'                                
  AND resultado = 'positivo'                             
ORDER BY fecha_reporte DESC;                             

-- Ejercicio 2
--Todas las columnas de todos los casos reportados en el departamento de Córdoba
SELECT * 
FROM casos_brucelosis
WHERE  departamento = 'Córdoba';

-- Ejercicio 3
--Solo el municipio y la fecha de los casos que dieron negativo
SELECT municipio, fecha_reporte
FROM casos_brucelosis
WHERE resultado = 'negativo';

-- Ejercicio 4
--Todos los casos (cualquier resultado) de la especie caprino
SELECT * 
FROM casos_brucelosis
WHERE especie = 'caprino';

--Ejercicio 5
--Casos positivos de bovinos en Antioquia o en Córdoba
SELECT *
FROM casos_brucelosis
WHERE (departamento = 'Antioquia' OR departamento = 'Córdoba')
  AND resultado = 'positivo'
  AND especie = 'bovino';

--Ejercicio 6
--Casos reportados después del 1 de febrero de 2026, ordenados del más antiguo al más reciente
SELECT *
FROM casos_brucelosis
WHERE fecha_reporte < '2026-01-20'
ORDER BY fecha_reporte ASC;