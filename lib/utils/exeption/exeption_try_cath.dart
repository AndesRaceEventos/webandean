

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/speack/assets_speack.dart';

// MÉTODOS DE SOPORTE
class ExceptionClass {
  /// Método genérico para manejar cualquier excepción.
  static void handleException(Exception e, String message) {
    print('Error: $e');
    TextToSpeechService().speak(message);
  }
  

  /// Método genérico para ejecutar tareas con manejo centralizado de excepciones.
  static Future<void> tryCathCustom({
    required Future<void> Function() task, // Tarea a ejecutar.
     required Function() onFinally, // Acción final como notifyListeners o cualquier otra.
  }) async {
    try {
      await task(); // Ejecuta la tarea.
   } on SocketException catch (e) {
    socketException(e); // Manejo de errores de red.
  } on TimeoutException catch (e) {
    timeoutException(e); // Manejo de errores por tiempo agotado.
  } on HttpException catch (e) {
    httpException(e); // Manejo de errores HTTP.
  } on FormatException catch (e) {
    formatException(e); // Manejo de errores de formato.
  } on DatabaseException catch (e) {
    databaseException(e); // Manejo de errores en la base de datos.
  } on IOException catch (e) {
    ioException(e); // Manejo de errores de entrada/salida.
  } on Exception catch (e) {
    handleException(e, 'Ocurrió un error inesperado. Exception catch');
  } catch (e, stackTrace) {
    handleException(Exception(e), 'Error crítico no controlado');
    print('StackTrace: $stackTrace');
  } finally {
     onFinally(); // Acción final.
    }
  }

  static void handleTimeout() {
    TextToSpeechService().speak('La solicitud ha tardado demasiado en responder.');
  }

  

  static void timeoutException(TimeoutException e) {
    handleException(e, 'Error al refrescar datos. La solicitud ha tardado demasiado. TimeoutException');
  }

  static void socketException(SocketException e) {
    handleException(e, 'Sin conexión a Internet. SocketException');
  }

  static void httpException(HttpException e) {
    handleException(e, 'Error de comunicación con el servidor. HttpException');
  }

  static void platformException(PlatformException e) {
    handleException(e, 'Error al acceder a servicios del dispositivo. PlatformException');
  }

  static void databaseException(DatabaseException e) {
    handleException(e, 'Error al acceder a la base de datos local. DatabaseException');
  }

  static void unsupportedError(UnsupportedError e) {
    handleException( Exception(e), 'Operación no soportada en este dispositivo. UnsupportedError');
  }

  static void stateError(StateError e) {
    handleException(Exception(e), 'Operación inválida para el estado actual. StateError');
  }

  static void fileSystemException(FileSystemException e) {
    handleException(e, 'Error al acceder a archivos del sistema. FileSystemException');
  }

  static void formatException(FormatException e) {
    handleException(e, 'Error en el formato de los datos recibidos. FormatException');
  }
  /// Excepción general de E/S.
  static void ioException(IOException e) {
    handleException(e, 'Error de entrada/salida. IOException');
  }




  static void actionRealmSpeack(String evetnAction, String name) {
  switch (evetnAction) {
    case 'create':
      TextToSpeechService().speak('Se ha creado un nuevo registro llamado $name.');
      break;
    case 'update':
      TextToSpeechService().speak('El registro de $name ha sido actualizado.');
      break;
    case 'delete':
      TextToSpeechService().speak('Se ha eliminado el registro de $name.');
      break;
    default:
      break;
  }
}

//ACTION SAVE timeout execute: 
Future<void> saveExecuteTimeout({
  required BuildContext context,
  required String nombre,
  required Future<void> operation,
  required int secondsDuration,
  required bool isCreating,
}) async {
  try {
    await operation.timeout(
    Duration(seconds: secondsDuration),
    onTimeout: () {
      // Mostrar diálogo de tiempo de espera agotado
      final  message = 'Tiempo de Espera Agotado';
        TextToSpeechService().speak(message);
      AssetAlertDialogPlatform.show(
        context: context,
        title: message,
        message: 'El registro de "$nombre" no pudo completarse porque la operación tardó demasiado. Verifica tu conexión e inténtalo de nuevo.',
        child: AppSvg().timerAlertSvg
      );
      // return Future.error(TimeoutException('Tiempo de espera agotado'));
      throw TimeoutException('Tiempo de espera agotado'); // Throw the timeout exception
    },
    ).then((_) {
      // Mostrar diálogo según la operación realizada
      final message = isCreating 
          ? 'El registro de "$nombre" se ha creado correctamente.'
          : 'El registro de "$nombre" se ha actualizado correctamente.';

      TextToSpeechService().speak(message);
      AssetAlertDialogPlatform.show(
        context: context,
        title: isCreating ? 'Creación Exitosa' : 'Actualización Exitosa',
        message: message,
        child: AppSvg().fileSvg
      );
    });
  } catch (e) {
     final  message = 'Error';
        TextToSpeechService().speak(message);
        // Manejar cualquier error inesperado
          AssetAlertDialogPlatform.show(
            context: context,
            title: message,
            message: 'No se pudo completar la operación. Error: $e.',
            child: AppSvg().crashSvg
          );
      // Captura cualquier error no previsto fuera del .then y catchError.
      rethrow;
  }
  
}

 Future<void> deleteExecuteTimeout({
    required BuildContext context,
    required String id,
    required Future<void> operation,
    required int secondsDuration,
  }) async {
      // final tiempoinical = DateTime.now().second;
      // final tiempoFinal = DateTime.now().second + secondsDuration;
      // final progress = 
      // Ejecutar operación de eliminación con timeout
    try {
      await operation.timeout(
        Duration(seconds: secondsDuration),
        onTimeout: () {
        
        final  message = 'Tiempo de Espera Agotado';
        TextToSpeechService().speak(message);
        AssetAlertDialogPlatform.show(
          context: context,
          title: message,
          message: 'No se pudo completar la eliminación del registro. Verifica tu conexión e inténtalo de nuevo.',
          child: AppSvg().timerAlertSvg
        );
       throw TimeoutException('Tiempo de espera agotado'); // Throw the timeout exception
      }).then((_){
        // Mostrar diálogo de éxito después de la eliminación
         final  message = 'Eliminación Exitosa';
        TextToSpeechService().speak(message);
        AssetAlertDialogPlatform.show(
          context: context,
          title: message,
          message: 'El registro "$id" ha sido eliminado correctamente.',
           child: AppSvg().trashRepoSvg
        );
      });
    } catch (e) {
       final  message = 'Error';
        TextToSpeechService().speak(message);
        // Manejar cualquier error inesperado
          AssetAlertDialogPlatform.show(
            context: context,
            title: message,
            message: 'No se pudo completar la operación. Error: $e.',
            child: AppSvg().crashSvg
          );
      // Captura cualquier error no previsto fuera del .then y catchError.
      rethrow;
    }
      
    
  }

}






// bool isRefresh = false;

// Future<void> refreshApp() async {
//   if (isRefresh) return; // Evita múltiples llamadas simultáneas.
//   isRefresh = true;
//   notifyListeners();

//   try {
//     await getApp();
//     TextToSpeechService().speak('${listProductos.length} registros actualizados');
//   } on TimeoutException catch (e) {
//     ErrorHandler.timeoutException(e);
//   } on SocketException catch (e) {
//     ErrorHandler.socketException(e);
//   } on FormatException catch (e) {
//     ErrorHandler.formatException(e);
//   } on Exception catch (e) {
//     ErrorHandler.handleException(e, 'Ocurrió un error inesperado.');
//   } finally {
//     isRefresh = false;
//     notifyListeners();
//   }
// }

