import 'dart:io';

import 'equipo.dart';
import 'producto.dart';
import 'ventas.dart';

class app {

   
  menuInicial(){
 
    int? opcion;
    do{
      stdout.writeln('''Elige una opción
      1 - Log in empleado
      2 - salir''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2);
    switch(opcion){
      case 1:
      loginusua();
       
    
        
        break;
      case 2:
      
       print('calvo');
        break;
      default:
        print('Opción no válida');
    }

  }
   loginusua() async {
    Equipo equipo = new Equipo();
    stdout.writeln('Introduce tu nombre de usuario');
    equipo.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    equipo.clave = stdin.readLineSync();
    var resultado = await equipo.loginUsuario();
    var sunombre = equipo.nombre;
    if(resultado == false){
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
      menuInicial();
    } else {
      print('bienvenido $sunombre');
      menuLogueado();
    }
  }
 
     listarProductos()async{
    List<Producto> listadoProductos = await Producto().all();
    for(Producto elemento in listadoProductos){
      stdout.writeln("${elemento.modelo} - ${elemento.tipo_calzado}");
    }
  }
  menuLogueado()async {
  int? opcion;
  do {
    stdout.writeln('''Elige una opción
    1 - Crear usuario
    2 - buscar producto
    3 - crear venta
    4 - crear producto''');
    String respuesta = stdin.readLineSync() ?? 'e';
    opcion = int.tryParse(respuesta);
  } while (opcion == null || opcion != 1 && opcion !=3 && opcion !=2 && opcion!=4);

  switch (opcion) {
    case 1:
      Equipo().crearUsuario();
      break;
    case 2:
      Producto().buscarProducto();
      break;
    case 3:
   int? opcion;
 
 do {
    stdout.writeln('''Elige una opción
    1 - Añadir producto
    2 - Terminar venta
    ''');
    String respuesta = stdin.readLineSync() ?? 'e';
    opcion = int.tryParse(respuesta);
  } while (opcion == null || opcion != 1  && opcion !=2);
   switch(opcion){
      case 1:
       Producto  producto = Producto().buscarProducto();
       Venta().agregarProducto(producto);
       print('hola');
        
        break;
      case 2:
      
      ;
        break;
      default:
        print('Opción no válida');
    }
    break;
    case 4 :
      Producto().crearProducto();
      break;
    default:
      print('Opción no válida');
  }
}
  
}