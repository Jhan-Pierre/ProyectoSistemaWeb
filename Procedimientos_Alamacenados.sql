USE DB_CAR;
GO

create proc sp_RegistrarUsuario(
@Nombres varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@clave varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado	int output
)
as
begin
	Set @Resultado = 0
	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo)
	begin
		insert into USUARIO(Nombres,Apellidos,Correo,Clave,Activo) values
		(@Nombres,@Apellidos,@Correo,@clave,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	 set @Mensaje = 'El correo del usuario ya existe'
end


go

create proc sp_EditarUsuario(
@IdUsuario int,
@Nombres varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado	int output
)
as
begin
	Set @Resultado = 0
	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo and IdUsuario != @IdUsuario)
	begin
		update top (1) USUARIO set
		Nombres = @Nombres,
		Apellidos = @Apellidos,
		Correo = @Correo,
		Activo = @Activo
		where IdUsuario = @IdUsuario

		SET @Resultado = 1
	end
	else
	 set @Mensaje = 'El correo del usuario ya existe'
end

go


create proc sp_RegistrarCategoria(
@Descripcion varchar (100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	begin
		insert into CATEGORIA(Descripcion,Activo) Values
		(@Descripcion,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	 set @Mensaje = 'La categoria ya existe'
end

GO

create proc sp_EditarCategoria(
@IdCategoria int,
@Descripcion varchar (100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion and IdCategoria !=@IdCategoria)
	begin
		update top (1) CATEGORIA Set
		Descripcion = @Descripcion,
		Activo = @Activo
		where IdCategoria = @IdCategoria

		SET @Resultado = 1
	end
	else
	 set @Mensaje = 'La categoria ya existe'
end
GO

create proc sp_EliminarCategoria(
@IdCategoria int,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO p 
	inner join CATEGORIA c on c.IdCategoria = p.IdCategoria
	WHERE p.IdCategoria = @IdCategoria)
	begin
		delete top (1) from CATEGORIA where IdCategoria = @IdCategoria
		SET @Resultado = 1
	end
	else
	 set @Mensaje = 'La categoria se encuentra relacionada a un producto'
end

GO

create proc sp_RegistrarMarca(
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
	begin
		insert into MARCA (Descripcion,Activo) values
		(@Descripcion,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	 set @Mensaje = 'La marca ya existe'
end

GO

create proc sp_EditarMarca(
@IdMarca int,
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion and IdMarca != @IdMarca)
	begin
		update top (1) MARCA Set
		Descripcion = @Descripcion,
		Activo = @Activo
		where IdMarca = @IdMarca

		SET @Resultado = 1
	end
	else
	 set @Mensaje = 'La marca ya existe'
end
GO



create proc sp_EliminarMarca(
@IdMarca int,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO p 
	inner join MARCA m on m.IdMarca = p.IdMarca 
	WHERE p.IdMarca = @IdMarca)
	begin
		delete top (1) from MARCA where IdMarca = @IdMarca

		SET @Resultado = 1
	end
	else
	 set @Mensaje = 'La marca se encuentra relacionada a un producto'
end

go

DECLARE @Mensaje VARCHAR(500), @Resultado BIT;

EXEC sp_EditarMarca 
    @IdMarca = 10,             
    @Descripcion = 'Nueva Marca', 
    @Activo = 1,             
    @Mensaje = @Mensaje OUTPUT,  
    @Resultado = @Resultado OUTPUT;  

SELECT @Mensaje AS Mensaje, @Resultado AS Resultado;

-- Verificar si la marca fue editada
SELECT * FROM MARCA WHERE IdMarca = 1;
