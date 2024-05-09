

import 'dart:io';
import 'producto.dart';
import 'database.dart';

class Venta {
  int? _id;
  double? _total;
  DateTime? _fecha;
  List<Producto> _productos = [Producto().all()];

  int? get id => _id;
  double? get total => _total;
  DateTime? get fecha => _fecha;
  List<Producto> get productos => _productos;

  set id(int? value) => _id = value;
  set total(double? value) => _total = value;
  set fecha(DateTime? value) => _fecha = value;

  Venta();
  agregarProducto(Producto producto) async {
    var conn = await Database().conexion();
    try {
      await conn.query(
        'INSERT INTO productos_venta (id_venta, id_producto, cantidad) VALUES (?, ?, ?)',
        [_id, producto.id, 1],
      );
      _total = (_total ?? 0.0) + producto.precio!;
      print('Producto agregado a la venta: ${producto.modelo}');
    } catch (e) {
      print('Error al agregar el producto a la venta: $e');
    } finally {
      await conn.close();
    }
  }
  

 
  mostrarDetalles() {
    print('Detalles de la venta:');
    print('ID: $_id');
    print('Fecha: $_fecha');
    print('Total: $_total');
    print('Productos:');
    for (var producto in _productos) {
      print('- ${producto.modelo} (${producto.tipo_calzado}, ${producto.talla}, ${producto.color}) - ${producto.precio}');
    }

  }



}


