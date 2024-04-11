--------------------- DDL CREATE ---------------------

DROP DATABASE IF EXISTS ejemplo;
CREATE DATABASE ejemplo;
USE ejemplo;

CREATE TABLE categoria (
    id_categoria INTEGER NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY (id_categoria)
);

CREATE TABLE producto (
    id_producto INTEGER NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_categoria INTEGER NOT NULL,
    CONSTRAINT producto_pk PRIMARY KEY (id_producto),
    CONSTRAINT producto_categoria_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE pais (
    id_pais INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT pais_pk PRIMARY KEY (id_pais)
);

CREATE TABLE cliente (
    id_cliente INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    tarjeta VARCHAR(20),   
    edad INTEGER(3),
    genero CHAR(1),
    salario DECIMAL(10,2),
    id_pais INTEGER NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (id_cliente),
    CONSTRAINT cliente_pais_fk FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE vendedor (
    id_vendedor INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    id_pais INTEGER NOT NULL,
    CONSTRAINT vendedor_pk PRIMARY KEY (id_vendedor),
    CONSTRAINT vendedor_pais_fk FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE orden (
    id_orden INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT orden_pk PRIMARY KEY (id_orden),
    CONSTRAINT orden_cliente_fk FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE orden_det (
    id_orden INTEGER NOT NULL,
    linea INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad DECIMAL(5,2) NOT NULL,
    CONSTRAINT orden_det_pk PRIMARY KEY (linea, id_orden),
    CONSTRAINT orden_det_orden_fk FOREIGN KEY (id_orden) REFERENCES orden(id_orden),
    CONSTRAINT orden_det_producto_fk FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT orden_det_vendedor_fk FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);
