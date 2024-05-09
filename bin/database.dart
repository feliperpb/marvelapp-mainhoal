
import 'package:mysql1/mysql1.dart';

class Database {
  // Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      await _crearTablaproductos(conn);
      await _crearTablainventario(conn);
      await _crearTablaventa_productos(conn);
        await _crearTablaclientes(conn);
      await _crearTablapedidos(conn);
      await _crearTablaproveedores(conn);
      await _crearTablaequipo(conn);
      await _creartablaventas(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    } 
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'tiendazapas'
    );
      
    return await MySqlConnection.connect(settings);
 
  }
  
  _crearDB (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS tiendazapas');
    await conn.query('USE tiendazapas');
    print('Conectado a tiendazapas');
  }

  _crearTablaproductos(conn) async {
    await conn.query(''' CREATE TABLE IF NOT EXISTS productos(
      id_producto INT PRIMARY KEY AUTO_INCREMENT,
      modelo VARCHAR (50) NOT NULL,
      tipo_calzado VARCHAR(50) NOT NULL,
      talla VARCHAR(10) NOT NULL,
      color VARCHAR(20) NOT NULL,
      precio DECIMAL(10,2) NOT NULL
      )''');
    print('Tabla productos creada');
  }

  _creartablaventas(conn) async{
    await conn.query('''CREATE TABLE IF NOT EXISTS ventas(
      id_venta INT PRIMARY KEY AUTO_INCREMENT,
    total DOUBLE(10, 2),
    fecha TIMESTAMP,
    
    )''');
print("tabla ventas cread<");
  }

  _crearTablainventario(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS inventario(
      id_inventario INT PRIMARY KEY AUTO_INCREMENT,
      id_producto INT,
      cantidad_stock INT,
      ubicacion_almacen VARCHAR(50),
       FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
      )''');
    print('Tabla inventario creada');
  }
   _crearTablapedidos(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS pedidos(
    id_pedidos INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_pedido DATE,
    fecha_envio DATE,
    fecha_entrega DATE,
    estado_pedido VARCHAR(20),
    info_envio TEXT,
    info_pago TEXT,
      FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
      )''');
    print('Tabla pedidos creada');
  }
   _crearTablaclientes(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS clientes(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50),
    fecha_nacimiento DATE
      )''');
    print('Tabla clientes creada');
  }
  _crearTablaventa_productos(conn)async{
    await conn.query('''CREATE TABLE IF NOT EXISTS productos_venta (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_venta INT,
  id_producto INT,
  cantidad INT,
  FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


''');
print('siuuuu');
  }
   _crearTablaproveedores(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS proveedor(
     id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    contacto VARCHAR(50),
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50)
      )''');
    print('Tabla proveedor creada');
  }
   _crearTablaequipo(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS equipo(
     id_equipos INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) ,
    apellidos VARCHAR(50) ,
    funcion VARCHAR(50),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50),
    contraseña VARCHAR(50),
    Rango INT (50)
      )''');
    print('Tabla equipo creada');
  }
 
  
}
