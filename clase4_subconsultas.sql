--Para la vigilancia epidemiológica, necesito identificar los municipios donde el número de casos positivos supera el promedio de casos positivos por municipio a nivel nacional — son los que requieren atención prioritaria.
SELECT resumen.municipio,
       resumen.casos_positivos
FROM (
    SELECT municipio,
           COUNT(*) AS casos_positivos
    FROM casos_brucelosis
    WHERE resultado = 'positivo'
    GROUP BY municipio
) AS resumen
WHERE resumen.casos_positivos > (
    -- Esta subconsulta calcula el promedio de la MISMA agregación,
    -- por eso repetimos la lógica de agrupación aquí adentro
    SELECT AVG(sub.casos_positivos)
    FROM (
        SELECT municipio, COUNT(*) AS casos_positivos
        FROM casos_brucelosis
        WHERE resultado = 'positivo'
        GROUP BY municipio
    ) AS sub
)
ORDER BY resumen.casos_positivos DESC;

Ejercicio 1: 
--Trae los casos cuya edad sea menor al promedio general de edad de todos los casos
SELECT municipio, edad_meses
FROM casos_brucelosis
WHERE edad_meses < (
    SELECT AVG(edad_meses) FROM casos_brucelosis   
);

--Ejercicio 2:
--Trae todos los casos que pertenezcan a laboratorios no certificados por el ICA
SELECT municipio, resultado, id_laboratorio
FROM casos_brucelosis
WHERE id_laboratorio IN (
    SELECT id_laboratorio FROM laboratorios WHERE certificado_ica = FALSE 
);

--Ejercicio 3:
--Muestra los departamentos con su total de casos, pero solo aquellos con más de 3 casos en total (sin importar el resultado)
SELECT *
FROM (
    SELECT departamento, COUNT(*) AS total_casos
    FROM casos_brucelosis
    GROUP BY departamento
) AS resumen       
WHERE resumen.total_casos > 3;

--Ejercicio 4:
--Encuentra el municipio (o municipios) con la mayor cantidad de casos positivos
SELECT resumen.municipio,
       resumen.total_casos
FROM (
    SELECT municipio, COUNT(*) AS total_casos
    FROM casos_brucelosis
    WHERE resultado = 'positivo'
    GROUP BY municipio
) AS resumen
WHERE resumen.total_casos = (
    SELECT MAX(sub.total_casos)
    FROM (
        SELECT municipio, COUNT(*) AS total_casos
        FROM casos_brucelosis
        WHERE resultado = 'positivo'
        GROUP BY municipio
    ) AS sub
);

