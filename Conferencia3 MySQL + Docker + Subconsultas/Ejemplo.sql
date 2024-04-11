-- Paises que han comprado mas del 25% de las ventas totales de la empresa

-- 25% de las ventas totales de la empresa
select sum(od.cantidad * p.precio) * 0.25 veinticinco_porciento_ventas
from orden o
    inner join orden_det od on o.id_orden = od.id_orden
    inner join producto p on od.id_producto = p.id_producto;

-- Monto comprado por cada país
select p.nombre, sum(od.cantidad * po.precio) monto_comprado
from pais p
    inner join cliente c on p.id_pais = c.id_pais
    inner join orden o on c.id_cliente = o.id_cliente
    inner join orden_det od on o.id_orden = od.id_orden
    inner join producto po on od.id_producto = po.id_producto
GROUP BY p.nombre;

-- Resultado final utilizando subconsultas
select nombre, monto_comprado
from (
        SELECT p.nombre, SUM(od.cantidad * po.precio) monto_comprado
        FROM pais p
            INNER JOIN cliente c ON p.id_pais = c.id_pais
            INNER JOIN orden o ON c.id_cliente = o.id_cliente
            INNER JOIN orden_det od ON o.id_orden = od.id_orden
            INNER JOIN producto po ON od.id_producto = po.id_producto
        GROUP BY p.nombre
      ) paises
where monto_comprado > (
    select sum(od.cantidad * p.precio) * 0.25 veinticinco_porciento_ventas
    from orden o
    inner join orden_det od on o.id_orden = od.id_orden
    inner join producto p on od.id_producto = p.id_producto
)