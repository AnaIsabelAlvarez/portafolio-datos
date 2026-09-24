--El ICA quiere digitalizar el registro de vacunación antirrábica en fauna doméstica. Necesitas diseñar la tabla desde cero: cada registro debe tener un identificador único, el nombre del propietario, la especie del animal, su peso, la fecha de vacunación, el lote de la vacuna, y si el animal ya había sido vacunado antes. Además, cada vacunación debe estar asociada a un laboratorio de la tabla laboratorios que ya existe.

CREATE TABLE vacunacion_antirrabica (
    id_vacunacion SERIAL PRIMARY KEY,        
    nombre_propietario VARCHAR(100),          
    especie VARCHAR(20),                      
    peso_kg NUMERIC(5,2),                     
    fecha_vacunacion DATE,                    
    lote_vacuna VARCHAR(20),                 
    vacunado_antes BOOLEAN,                   
    id_laboratorio INT,                       
    FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio)
);


INSERT INTO vacunacion_antirrabica
    (nombre_propietario, especie, peso_kg, fecha_vacunacion, lote_vacuna, vacunado_antes, id_laboratorio)
VALUES
    ('Carlos Restrepo', 'canino', 18.5, '2026-03-01', 'LT-2026-045', TRUE, 1);


--Ejercicio 1:
--Crea una tabla veterinarios con: id_veterinario (llave primaria autogenerada), nombre_completo (texto hasta 100 caracteres), numero_tarjeta_profesional (texto corto), y anios_experiencia (número entero)
CREATE TABLE veterinarios (
    id_veterinario SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(100),
    numero_tarjeta_profesional VARCHAR(10),
    anios_experiencia INT
);

--Ejercicio 2:
--Agrega a esa tabla una columna id_laboratorio (entero) con una FOREIGN KEY que apunte a laboratorios.
ALTER TABLE veterinarios ADD COLUMN id_laboratorio INT REFERENCES laboratorios(id_laboratorio);

--Ejercicio 3:
--Inserta 2 veterinarios válidos, con un id_laboratorio que sí exista en tu tabla laboratorios.
INSERT INTO veterinarios (nombre_completo, numero_tarjeta_profesional,  anios_experiencia,id_laboratorio)
VALUES 
   ('Pedro Perez', '23456',  12, 1),
  ('Susana Santa', '56749', 7, 2);
