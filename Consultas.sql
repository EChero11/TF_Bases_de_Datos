--Alex
-----------------------------------------------------------------------------------------
-- Funcion que muestra beneficiario por poliza 

create function f_beneficiario_by_poliza() 
returns table
return 
select b.codigo,nombre, tipo_poliza 
from beneficiarios as b
		join polizas_para_beneficiarios as pb on b.codigo = pb.beneficiarios_codigo
		join polizas as p on pb.polizas_codigo = p.codigo
go;

select * from dbo.f_beneficiario_by_poliza()
go;

-- Funcion que muestra recaudador por sucursal

create function f_recaudador_by_sucursal() 
returns table
return 
select r.nombre, ubicacion 
from recaudadores as r
		join recaudadores_por_sucursal as rs on r.codigo = rs.recaudadores_codigo
		join sucursales as s on rs.sucursales_codigo = s.codigo
go;

select * from dbo.f_recaudador_by_sucursal()
go;

-- Funcion que muestre al asegurado y a la persona que beneficia el seguro por fecha indicada

create function f_asegu_y_pers_benef_by_fecha(
@fecha date) returns table
return 
select a.apellido, b.codigo, b.nombre
from asegurados as a
	join polizas as p on a.codigo = p.asegurados_codigo
	join polizas_para_beneficiarios as pb on p.codigo = pb.polizas_codigo
	join beneficiarios as b on pb.beneficiarios_codigo = b.codigo
where a.fecha_nacimiento = @fecha;
go;

select * from dbo.f_asegu_y_pers_benef_by_fecha('2020')
go;
-----------------------------------------------------------------------------------------
--Eduardo
-----------------------------------------------------------------------------------------
-- Funcion que muestre el nombre del recaudador y la ubicacion de la sucursal por codigo de poliza

create function f_recaudador_y_sucursal_by_poliza(@codigo int) returns table
return
select r.nombre, s.ubicacion
from recaudadores as r
    join recaudadores_por_sucursal as rs on r.codigo = rs.recaudadores_codigo
    join sucursales as s on rs.sucursales_codigo = s.codigo
    join polizas as p on r.codigo = p.codigo
where p.codigo = @codigo;

select * from dbo.f_recaudador_y_sucursal_by_poliza(10)

-- Funcion que devuelva los asegurados que tengan un salario menor a 1000, mostrando su nombre, apellido y salario

create function f_asegurados_by_salario() returns table
return
select a.nombre, a.apellido, t.salario
from asegurados as a
    join trabajos t on a.codigo = t.codigo
where t.salario < 1000;

select * from dbo.f_asegurados_by_salario()

-- Crear una funcion que muestre el nombre y apellido de los beneficiarios que tengan asegurados con polizas cuyas
-- primas sean menores a 1000

create function f_beneficiarios_by_prima() returns table
return
select b.nombre, b.apellido, p.prima
from beneficiarios as b
    join polizas_para_beneficiarios as pb on b.codigo = pb.beneficiarios_codigo
    join polizas as p on pb.polizas_codigo = p.codigo
where p.prima < 1000;

drop function f_beneficiarios_by_prima

select * from dbo.f_beneficiarios_by_prima()
-----------------------------------------------------------------------------------------
--André
-----------------------------------------------------------------------------------------
-- Funcion que retorne los nombres de los asegurados mediante el ingreso del tipo de pago
go;
create function f_nombre_asegurados_por_tipo_pago(
	@tipo_pago varchar(100)
) returns table
return
	select nombre, tipo_pago
	from asegurados as a
		join pagos as p on a.codigo = p.asegurados_codigo
	where tipo_pago = @tipo_pago
go;
select * from dbo.f_nombre_asegurados_por_tipo_pago ('Visa')

-- Funcion que retorne la cantidad de empleados que hay en la ubicacion de una sucursal
go;
create view v_cantidad_empleados_por_ubicacion_sucursal
as
select ubicacion, count(e.codigo) as quantity 
	from Empleado as e
		join sucursales as s on e.sucursales_codigo = s.codigo
group by ubicacion

go;
create function f_cantidad_empleados_por_ubicacion_sucursal(
	@ubicacion varchar(100)
) returns int
as
begin
	declare @quantity int
	set @quantity = (select quantity
	from v_cantidad_empleados_por_ubicacion_sucursal
	where ubicacion = @ubicacion) 
	return @quantity
end
go;
select dbo.f_cantidad_empleados_por_ubicacion_sucursal ('San Pedro Sula')

-- Procedimiento que imprima el nombre de los contactos por un determinado agente
go;
create procedure usp_imprimir_nombre_contacto_por_agente
	@agente_nombre varchar(100)
as
begin
	declare @contacto_nombre varchar(100)
	declare cursor_nombre_contacto cursor for
	select c.nombre
	from contactos as c
		join agentes as a on c.agentes_codigo = a.codigo
	where a.nombre = @agente_nombre
	open cursor_nombre_contacto
	fetch cursor_nombre_contacto into @contacto_nombre
	print('Contactos del agente ingresado: ')
	while (@@FETCH_STATUS = 0)
	begin
		print(@contacto_nombre)
		fetch cursor_nombre_contacto into @contacto_nombre
	end
	close cursor_nombre_contacto
	deallocate cursor_nombre_contacto
end
go;
exec usp_imprimir_nombre_contacto_por_agente 'Aaron'
-----------------------------------------------------------------------------------------
--Sebas
-----------------------------------------------------------------------------------------
-- funcion que muestra los agentes por sucursales

create function f_agentes_por_sucursal()
returns table
return
select a.codigo,a.nombre,a.sucursales_codigo, a.sueldo, s.ubicacion AS ubicaion_sucursal
from agentes a
    join sucursales s on a.sucursales_codigo = s.codigo


select * from f_agentes_por_sucursal();
go;

-- funcion que muestra los asegurados por poliza

drop function if exists f_asegurados_por_poliza;
create function f_asegurados_por_poliza()
returns table
return
select a.codigo,a.nombre,a.apellido,p.descripcion AS descripcion_poliza, p.monto_Seguro AS monto_seguro
from asegurados a
    join polizas p on a.codigo = p.asegurados_codigo

select * from f_asegurados_por_poliza();
go;

-- funcion que muestra el historial de pagos de un asegurado

drop function if exists f_historial_pagos_asegurado;
create function f_historial_pagos_asegurado()
returns table
return
select a.codigo,a.nombre,a.apellido,pa.tipo_pago AS descripcion_pago, pa.codigo AS codigo_pago
from asegurados a
    join pagos pa on a.codigo = pa.asegurados_codigo

select * from f_historial_pagos_asegurado();
go;
-----------------------------------------------------------------------------------------
--Josue
-----------------------------------------------------------------------------------------
/*Funcion que obtiene los contactos (nombre, apellido, teléfono y correo)
  de los agentes que trabajan en una sucursal mediante el ingreso del codigo*/
create function f_agent_by_branch(
    @codigo_sucursal int
)
returns table
return
    select c.nombre, c.apellido, c.telefono, c.correo
    from contactos as c
        join agentes as a on c.agentes_codigo = a.codigo
    where a.sucursales_codigo = @codigo_sucursal;

select * from dbo.f_agent_by_branch(2)


/*Funcion que obtenga los nombres y apellidos de los asegurados
  cuyo monto de cobertura sea mayor a 10000 y pertenezca a una determinada poliza*/

create function f_asegurados_by_poliza(
    @TipoPoliza varchar(100)
)
returns table
return
    select a.nombre, a.apellido
    from asegurados as a
        join polizas as  p on a.codigo = p.asegurados_codigo
    where p.tipo_poliza = @TipoPoliza and p.monto_Seguro > 10000;

select * from dbo.f_asegurados_by_poliza('Vida')


/*Funcion que obtenga el agente con la mayor cantidad de polizas vendidas*/

create function f_agente_by_mayor_cantidad_ventas()
returns table
return
SELECT a.codigo, count(*) as numero_polizas_vendidas
from polizas as p
    join agentes as a on p.agentes_codigo = a.codigo
GROUP BY a.codigo

select * from dbo.f_agente_by_mayor_cantidad_ventas()
-----------------------------------------------------------------------------------------
--Abraham
-----------------------------------------------------------------------------------------
