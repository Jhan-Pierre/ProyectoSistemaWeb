USE DB_CAR;
GO

---Insercion de Usuario
INSERT INTO USUARIO(Nombres, Apellidos, Correo, Clave) VALUES ('test nombre', 'test apellido', 'test@example.com', 'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae');
GO
SELECT * FROM USUARIO;
GO

---Insercion de Categorias
INSERT INTO CATEGORIA(Descripcion) VALUES
('Tecnologia'),
('Muebles'),
('Dormitorio'),
('Deportes');
GO
SELECT * FROM CATEGORIA;
GO

---Inserciones de Marca
INSERT INTO MARCA(Descripcion) VALUES
('SONYTE'),
('HPTE'),
('LGTE'),
('HYUNDAITE'),
('CANONTE'),
('ROBERTA ALLENTE');
GO
SELECT * FROM MARCA;
GO

---Inserciones de Departamento
INSERT INTO DEPARTAMENTO(IdDepartamento, Descripcion)  
VALUES  
('01', 'Arequipa'),  
('02', 'Ica'),  
('03', 'Lima');
GO
SELECT * FROM DEPARTAMENTO;
GO

---Inserciones de Provincia
INSERT INTO PROVINCIA(IdProvincia, Descripcion, IdDepartamento)  
VALUES 
-- AREQUIPA - PROVINCIAS 
('0101', 'Arequipa', '01'),  
('0102', 'Caman�', '01'),  

-- ICA - PROVINCIAS  
('0201', 'Ica', '02'),  
('0202', 'Chincha', '02'),  

-- LIMA - PROVINCIAS  
('0301', 'Lima', '03'),  
('0302', 'Barranca', '03');  
GO
SELECT * FROM PROVINCIA;
GO

---Inserciones para Distrito
INSERT INTO DISTRITO(IdDistrito, Descripcion, IdProvincia, IdDepartamento) VALUES  
-- AREQUIPA - DISTRITO
('010101', 'Nieva', '0101', '01'),  
('010102', 'El Cenepa', '0101', '01'),  
('010201', 'Caman�', '0102', '01'),  
('010202', 'Jos� Mar�a Quimper', '0102', '01'),  

-- ICA - DISTRITO  
('020101', 'Ica', '0201', '02'),  
('020102', 'La Tingui�a', '0201', '02'),  
('020201', 'Chincha Alta', '0202', '02'),  
('020202', 'Alto Laran', '0202', '02'),  

-- LIMA - DISTRITO  
('030101', 'Lima', '0301', '03'),  
('030102', 'Anc�n', '0301', '03'),  
('030201', 'Barranca', '0302', '03'),  
('030202', 'Paramonga', '0302', '03');  
GO
SELECT * FROM DISTRITO;
GO