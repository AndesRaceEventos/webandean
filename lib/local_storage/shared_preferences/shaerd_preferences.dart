// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefencesGlobal {
  //Vamos utilizar un singleton para utilizar una sola instancia
  //HEMOS creado singleton para llamar una sola vez esta clase.
  static final SharedPrefencesGlobal _instance = SharedPrefencesGlobal._();

  SharedPrefencesGlobal._(); //Constructor privado

  factory SharedPrefencesGlobal() {
    return _instance; //singleton
  }

  //Instancia de sharedPreferecnes
  late SharedPreferences _pref;

  //CREAMSO un metodo initsharedpreferences para  inicializar una sola vez el sharedpreferences
  Future<void> initSharedPreferecnes() async {
    _pref = await SharedPreferences.getInstance();
  }

  //COLABORADOR
  // Función para obtener el estado de inicio de sesión desde shared preferences
  Future<bool> getLoggedIn() async {
    // Obtiene el valor de isLoggedIn, si no existe devuelve false por defecto
    return _pref.getBool('isLoggedIn') ?? false;
  }

  // Función para cerrar sesión
  // Future<void> logout(BuildContext context) async {
  //   await _pref.setBool('isLoggedIn', false);
  //   // Redirige a la página de inicio de sesión después de cerrar sesión
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (_) => const SplashScreen()),
  //   );
  // }

  // Función para guardar el estado de inicio de sesión en shared preferences
  Future<void> setLoggedIn() async {
    await _pref.setBool('isLoggedIn', true);
  }

  //RUNNER
  // Función para obtener el estado de inicio de sesión desde shared preferences
  Future<bool> getLoggedInRunner() async {
    // Obtiene el valor de isLoggedIn, si no existe devuelve false por defecto
    return _pref.getBool('isLoggedInRun') ?? false;
  }

  // Función para cerrar sesión
  // Future<void> logoutRunner(BuildContext context) async {
  //   await _pref.setBool('isLoggedInRun', false);
  //   // Redirige a la página de inicio de sesión después de cerrar sesión
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (_) => const SplashScreen()),
  //   );
  // }

  // Función para guardar el estado de inicio de sesión en shared preferences
  Future<void> setLoggedInRunner() async {
    await _pref.setBool('isLoggedInRun', true);
  }


// //********************EMPLEADO MODEL TEMPLEADOMODEL *******************  */
// // Guardar ParticipantesModel como JSON
//   Future<void> saveEmpleado(TEmpleadoModel empleado) async {
//     empleado.sexo = empleado.imagen!;
//     String jsonString = json.encode(empleado.toJson());
//     await _pref.setString('empleadoKey', jsonString);
//     print('Empleado guardado como JSON: $jsonString');
//   }

//   // Obtener ParticipantesModel desde JSON
//   Future<TEmpleadoModel> getEmpleado() async {
//     String? jsonString = _pref.getString('empleadoKey');
//     if (jsonString != null) {
//       Map<String, dynamic> jsonMap = json.decode(jsonString);
//       return TEmpleadoModel.fromJson(jsonMap);
//     }
//     return tEmpleadoModelDefault();
//   }

//   // Eliminar ParticipantesModel
//   Future<void> deleteEmpleado() async {
//     await _pref.remove('empleadoKey');
//     print('Empleado eliminado');
//   }


// //********************RUNNER MODEL PARTICIPANTE *******************  */
//   // Guardar ParticipantesModel como JSON
//   Future<void> savePartipante(ParticipantesModel participante) async {
//     participante.alergias = participante.imagen!;
//     String jsonString = json.encode(participante.toJson());
//     await _pref.setString('participanteKey', jsonString);
//     print('Participante guardado como JSON: $jsonString');
//   }

//   // Obtener ParticipantesModel desde JSON
//   Future<ParticipantesModel> getParticipante() async {
//     String? jsonString = _pref.getString('participanteKey');
//     if (jsonString != null) {
//       Map<String, dynamic> jsonMap = json.decode(jsonString);
//       return ParticipantesModel.fromJson(jsonMap);
//     }
//     return participantesModelDefault();
//   }

  // Eliminar ParticipantesModel
  Future<void> deleteParticipante() async {
    await _pref.remove('participanteKey');
    print('Participante eliminado');
  }

//**************************  ISOFFLINE ESTAUS APP **** ** ***************
  // Método para obtener el estado de modo offline desde SharedPreferences
  Future<bool?> getIsOffline() async {
    return _pref.getBool('isOffline');
  }

// Método para guardar el estado de modo offline en SharedPreferences
  Future<void> saveIsOffline(bool isOffline) async {
    await _pref.setBool('isOffline', isOffline);
  }
}


  //RUNNER
  // Guardar Lista ParticipantesModel como JSON
  // Future<void> saveParticipantesModel(List<ParticipantesModel> participantes) async {
  //   final jsonString = json.encode(participantes);
  //   await _pref.setString('participantesKey', jsonString);
  //   print('Participantes guardados como JSON: $jsonString');
  // }