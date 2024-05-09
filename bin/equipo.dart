import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'app.dart';
import 'database.dart';

class Equipo{
  int? idusuario;
  String? _nombre;
  String? _apellidos;
  String? _funcion;
  String? _telefono;
  String? _correo_electronico;
  String? _clave;
  int? _rango;
  int? get rango => this._rango;

 set rango(int? value) => this._rango = value;
 
 String? get clave => this._clave;

 set clave( String? value) => this._clave = value;
 
 
  String? get nombre => this._nombre;

    set nombre(String? value) => this._nombre = value;
  String? get apellidos => this._apellidos;

    set apellidos(String? value) => this._apellidos = value;

  String? get funcion => this._funcion;

    set funcion(String? value) => this._funcion = value;

  String? get telefono => this._telefono;

    set telefono(String? value) => this._telefono = value;

  String? get correo_electronico => this._correo_electronico;

    set correo_electronico(String? value) => this._correo_electronico = value;
  Equipo();

  Equipo.fromMap(ResultRow map) {
    this._nombre = map['nombre'];
    this._apellidos = map['apellidos'];
    this._telefono = map['telefono'];
    this._funcion = map['funcion'];
    this._correo_electronico = map['correo_electronico'];
    this._clave = map['contraseña'];
    this._rango = map['Rango'];
  }

  insertarEmpleado() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO equipo ( nombre, apellidos, funcion, telefono, correo_electronico, contraseña, Rango) VALUES (?,?,?,?,?,?,?)',
          [ _nombre, _apellidos, _funcion,_telefono, _correo_electronico, _clave, _rango]);
      print('Usuario insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }


}
  sacarempleado() async {
    var conn = await Database().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM equipo');
      List<Equipo> equipos =
          resultado.map((row) => Equipo.fromMap(row)).toList();
      return equipos;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
    loginUsuario() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn
          .query('SELECT * FROM equipo WHERE nombre = ?', [this._nombre]);
      Equipo equipo = Equipo.fromMap(resultado.first);
       
      if (this._clave == equipo.clave) {
        return equipo;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }
  
  compruebarango()async{
    var conn = await Database().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM Rango WHERE nombre = ?', [this._nombre]);
      Equipo equipo = Equipo.fromMap(resultado.first);
      if(this._rango == 1){
      return 1;
      }else{return 2;}
    } catch(e){
      print(e);
      return false;
    }
    finally{
      await conn.close();
    }
  }
 
   crearUsuario() async {
    Equipo equipo = new Equipo();
    stdout.writeln('Introduce un nombre de usuario');
    nombre = stdin.readLineSync();
    stdout.writeln('Introduce una constraseña');
    clave =  stdin.readLineSync();
    clave = clave;
    stdout.writeln('introduce los apellidos');
    apellidos = stdin.readLineSync();
    stdout.writeln('introduce correo electronico ');
    correo_electronico = stdin.readLineSync();
    stdout.writeln('introduce la funcion en la empresa');
    funcion = stdin.readLineSync();
    stdout.writeln('introduce tu telefono');
    telefono = stdin.readLineSync();
    stdout.writeln('introduce el rango');
    var respuesta = stdin.readLineSync();
    rango =  int.tryParse(respuesta!);
  
    await insertarEmpleado();
    app().menuInicial();
  }
  
}
