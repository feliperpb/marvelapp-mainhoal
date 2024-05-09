
import 'dart:io';

import 'app.dart';
import 'database.dart';
import 'package:mysql1/mysql1.dart';



class Producto{
  String? _id;
  String? _tipo_calzado;
  String? _talla;
  String? _color;
  double? _precio;
  String? _modelo;
 
   get id => this._id;

 set id( value) => this._id = value;
 
 String? get modelo => this._modelo;

 set modelo(String? value) => this._modelo = value;
 String? get tipo_calzado => this._tipo_calzado;

 set tipo_calzado(String? value) => this._tipo_calzado = value;
   String? get talla => this._talla;

  set talla(String? value) => this._talla = value;
   String? get color => this._color;

 set color(String? value) => this._color = value;


  double? get precio => this._precio;

 set precio(double? value) => this._precio = value;



 
    Producto();

  Producto. fromMap(ResultRow map) {
    this._tipo_calzado = map['tipo_calzado'];
    this._talla = map['talla'];
    this._color = map['color'];
    this._precio = map['precio'];
    this._modelo = map['modelo'];
  
  }



 insertarProducto() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO productos (tipo_calzado, talla, color, precio, modelo ) VALUES (?,?,?,?,? )',
          [ _tipo_calzado, _talla, _color, _precio, _modelo]);
      print('Zapa insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }


}
 all() async {
    var conn = await Database().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM productos');
      List<Producto> productos =
          resultado.map((row) => Producto.fromMap(row)).toList();
      return productos;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }


  crearProducto() async {
    Producto producto = new Producto();
    stdout.writeln('Introduce el tipo de calzado');
    tipo_calzado = stdin.readLineSync();
    stdout.writeln('introduce la talla');
    talla = stdin.readLineSync();
    stdout.writeln('introduce el color');
    color = stdin.readLineSync();
    stdout.writeln('introduce el precio ');
        var elprecio = stdin.readLineSync();
    precio =  double.tryParse(elprecio!); 
    stdout.writeln('Introduce el tipo de modelo');
    modelo = stdin.readLineSync();
    await insertarProducto();
    app().menuInicial();
  }
  buscarProducto() async {
    stdout.writeln('Introduce el modelo del producto:');
    String? modeloBuscado = stdin.readLineSync();
    stdout.writeln('Introduce la talla del producto:');
    String? tallaBuscada = stdin.readLineSync();
    stdout.writeln('Introduce el color del producto:');
    String? colorBuscado = stdin.readLineSync();

    var conn = await Database().conexion();
    try {
      var resultado = await conn.query(
        'SELECT * FROM productos WHERE modelo = ? AND talla = ? AND color = ?',
        [modeloBuscado, tallaBuscada, colorBuscado],
      );

      if (resultado !=null) {
        var row = resultado.first;
        Producto productoEncontrado = Producto.fromMap(row);
        print('Producto encontrado:');
        print('ID: ${row['id_producto']}');
        print('Tipo de calzado: ${productoEncontrado.tipo_calzado}');
        print('Talla: ${productoEncontrado.talla}');
        print('Color: ${productoEncontrado.color}');
        print('Precio: ${productoEncontrado.precio}');
        print('Modelo: ${productoEncontrado.modelo}');
        return productoEncontrado;
      } else {
        print('No se encontró ningún producto con esas características.');
      }
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
   obtenerProductosDisponibles() async {
  List<Producto> productos = [];

  var conn = await Database().conexion();

  try {
    var resultados = await conn.query('SELECT * FROM productos');

    for (var row in resultados) {
      Producto producto = Producto.fromMap(row);
      productos.add(producto);
    }
  } catch (e) {
    print('Error al obtener los productos: $e');
  } finally {
    await conn.close();
  }

  return productos;
}
}


