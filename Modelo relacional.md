# Modelo Relacional de la empresa Cinemania
En esta sección se presentará el diseño del esquema inicial de las tablas de la base de datos. Para ello se considerará las llaves primarias, foráneas, super llaves, tablas nativas, tablas virtuales y esquemas.
## Notación
Para una mejor interpretación del modelo relacional se explicará la representación de cada símbol utilzado en el modelo relacional.
1. Llave primaria: {}
2. Llave foranea: []
3. Superllave: {.,..}
4. Tabla: ()
5. Tabla virtual: !()
6. Esquema: <Nombre_del_esquema>?
## Modelo Relacional
### 1. Agentes principales
Los agentes principales son los que tiene un grado de participación en el flujo de información de datos. En ellos se encuetra los siguientes agentes.
### 1.1 Descripción de agentes principales
1. **Administradores:** Existen diferentes tipos de administradores: de la sede, del departamento y a nivel nacional. Cada adminsitrador contará con un nivel de acceso a la plataforma del sistema. Es por ello que se ha dividio en **niveles_acceso**, siendo de esa la subdivisión de responsabilidades en el sistema base de la empresa.

2.  **Clientes:** Los principales partícipes del funcionamiento de la empresa. Existen dos tipos de clientes, los que compran en caja directamente sin prestar datos a la empresa y los que indirectamente sí lo hacen por medio de las compras digitales.

3. **Colaboradores:** También conocidos como trabajadores principales. La empresa almacenará la información de cada uno de sus colaboradores, dependiendo de la región de su lugar de trabajo. __Recordar que la empresa es descentralizada a nivel de todo el Perú, y cada trabajador de almacenará en un esquema de acuerdo a la región en la que se encuentra (Esto ayuda a mejorar indirectamente la complejidad de búsqueda en las consultas que se realizarán en el Backend del sistema).__

4. **Socios:** La recurrencia de algunos clientes lleva a la empresa a tener un vía mucho más factible para la adquisión de entradas. Ésta estará relacionada con las promociones que se desarrollará en el transcurso de cada temporada. Por lo que los socios contarán con ofertas y promociones especiales.

### 1.2 Tablas relacional de cada agente principal
### 1.2.1 Clientes

```
Clientes({id}, nombres, apellidos, correo, celular)

TarjetaBancaria({numero_tarjeta}, Cliente.id, tipo_tarjeta)

Membresia({id}, nombre)

Socio({Cliente.tipo_dni}, {Cliente.nro_dni}, Membresia.id)
```
### 1.2.2 Colaboradores

```
AreaTrabajo({id}, nombre)

Colaboradores({{id}, nro_documento, tipo_documento}, nombres, apellidos, celular, correo, cuenta_bancaria, AreaTrabajo.id)

SueldoColaborador({Colaboradores.id}, fecha_inicio,fecha_final,sueldo)

```

### 1.2.3 Administradores

```
Administradores({Colaboradores.id}, nivel_permiso)
```
## **Usuarios**
El sistema contará contará con tres tipos de usuarios de trabajador: administrador, colaborador principal, colaborador general.

**Administrador:** el administrador principal es aquel que tiene acceso por completo a toda la plataforma. Es quien podrá realizar los cambios tanto en la plataforma con enfoque al cliente como en la plataforma con enfoque al monitoreo de trabajador.

**Colaborador principal:** es aquel encargado de administrar las operaciones en cada sede. Además, será el encargado de monitorear la participación de los colaboradores generales.

**Colaborador general:** Es el colaborador que se encarga en la ejecución de su función (seguridad, caja, etc).

### 1.2.4 Colaboradores
```
TipoColaborador({ {id}, especialidad, rango_permiso})
Usuario({ {Colaboradores.id}, usuario }, contrasena, TipoColaborador.especialidad, TipoColaborador.id) 

````
