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
go

--- PRODUCTO SP
create proc sp_RegistrarProducto(
    @Nombre varchar(100),
    @Descripcion varchar(100),
    @IdMarca varchar(100),
    @IdCategoria varchar(100),
    @Precio decimal(10,2),
    @Stock int,
    @Activo bit,
    @Mensaje varchar(500) output,
    @Resultado int output
)
as
begin
    SET @Resultado = 0
    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre)
    begin
        insert into PRODUCTO(Nombre, Descripcion, IdMarca, IdCategoria, Precio, Stock, Activo) 
        values (@Nombre, @Descripcion, @IdMarca, @IdCategoria, @Precio, @Stock, @Activo)

        SET @Resultado = scope_identity()
    end
    else
        SET @Mensaje = 'El producto ya existe'
end
go

create proc sp_EditarProducto(
    @IdProducto int,
    @Nombre varchar(100),
    @Descripcion varchar(100),
    @IdMarca varchar(100),
    @IdCategoria varchar(100),
    @Precio decimal(10,2),
    @Stock int,
    @Activo bit,
    @Mensaje varchar(500) output,
    @Resultado bit output
)
as
begin
    SET @Resultado = 0
    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre and IdProducto != @IdProducto)
    begin
        update PRODUCTO set
            Nombre = @Nombre,
            Descripcion = @Descripcion,
            IdMarca = @IdMarca,
            IdCategoria = @IdCategoria,
            Precio = @Precio,
            Stock = @Stock,
            Activo = @Activo
        where IdProducto = @IdProducto

        SET @Resultado = 1
    end
    else
        SET @Mensaje = 'El producto ya existe'
end
go

create proc sp_EliminarProducto(
    @IdProducto int,
    @Mensaje varchar(500) output,
    @Resultado bit output
)
as
begin
    SET @Resultado = 0
    IF NOT EXISTS (select * from DETALLE_VENTA dv
    inner join PRODUCTO p on p.IdProducto = dv.IdProducto
    where p.IdProducto = @IdProducto)
    begin
        delete top (1) from PRODUCTO where IdProducto = @IdProducto
        SET @Resultado = 1
    end
    else
        set @Mensaje = 'El producto se encuentra relacionado a una venta'
end
go

--- DASHBOARD SP
CREATE PROCEDURE sp_ReporteDashboard
AS
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM CLIENTE) AS TotalCliente,
        (SELECT ISNULL(SUM(cantidad), 0) FROM DETALLE_VENTA) AS TotalVenta,
        (SELECT COUNT(*) FROM PRODUCTO) AS TotalProducto;
END;
GO

EXEC sp_ReporteDashboard;
GO

create proc sp_ReporteVentas(
    @fechainicio varchar(10),
    @fechafin varchar(10),
    @idtransaccion varchar(50)
)
as
begin
    set dateformat dmy;

    select CONVERT(char(10), v.FechaVenta, 103) [FechaVenta], 
           CONCAT(c.Nombres, ' ', c.Apellidos) [Cliente], 
           p.Nombre [Producto], p.Precio, dv.Cantidad, dv.Total, v.IdTransaccion
    from DETALLE_VENTA dv
    inner join PRODUCTO p on p.IdProducto = dv.IdProducto
    inner join VENTA v on v.IdVenta = dv.IdVenta
    inner join CLIENTE c on c.IdCliente = v.IdCliente
    where CONVERT(date, v.FechaVenta) between @fechainicio and @fechafin
          and v.IdTransaccion = iif(@idtransaccion = '', v.IdTransaccion, @idtransaccion)
end
go

------------------------------

create proc sp_RegistrarCliente(
@Nombres varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@clave varchar(100),
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CLIENTE WHERE Correo = @Correo)
	begin
		insert into CLIENTE(Nombres,Apellidos,Correo,Clave,Reestablecer) values
		(@Nombres,@Apellidos,@Correo,@clave,0)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	 set @Mensaje = 'El correo del usuario ya existe'
end

GO

create proc sp_ExisteCarrito(
@IdCliente int,
@IdProducto int,
@Resultado bit output
)
as
begin
	if exists(select * from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto)
		set @Resultado = 1
	else
		set @Resultado = 0
end

go


create proc sp_OperacionCarrito(
@IdCliente int,
@IdProducto int,
@Sumar bit,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	set @Resultado = 1
	set @Mensaje = ''

	declare @existecarrito bit = iif(exists(select * from carrito where idcliente = @IdCliente and idproducto = @IdProducto),1,0)
	declare @stockproducto int = (select stock from PRODUCTO where IdProducto = @IdProducto)

	BEGIN TRY
		
		BEGIN TRANSACTION OPERACION

		if(@Sumar = 1)
		begin

			if(@stockproducto > 0)
			begin
			
				if(@existecarrito = 1)
					update CARRITO set Cantidad	= Cantidad + 1 where IdCliente = @IdCliente and IdProducto = @IdProducto
				else
					insert into CARRITO (IdCliente,IdProducto,Cantidad) values(@IdCliente,@IdProducto,1)

				update PRODUCTO set Stock = Stock - 1 where IdProducto = @IdProducto
			end
			else
			begin
				set @Resultado = 0
				set @Mensaje = 'El producto no cuenta con stock disponible'
			end

		end
		else
		begin
			update CARRITO set Cantidad = Cantidad - 1 where IdCliente = @IdCliente and IdProducto = @IdProducto
			update PRODUCTO set Stock = Stock + 1 where  IdProducto = @IdProducto
		end

		COMMIT TRANSACTION OPERACION


	END TRY
	BEGIN CATCH
		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()
		ROLLBACK TRANSACTION OPERACION
	END CATCH

end
 go