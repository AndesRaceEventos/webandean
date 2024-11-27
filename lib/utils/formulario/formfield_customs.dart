import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/json_loading/provider_json.dart';
import 'package:webandean/provider/cache/qr_lector/qr_lector_provider.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

class FormWidgets {
  double bottonmargin = 10;
  late BuildContext context;

  FormWidgets(this.context);

  // ************************************* VALIDACIONES *********************************************************
  String? validarCampoObligatorio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    return null; // Se asegura que siempre se retorna algo
  }

  void completeForm({required String title}) {
    AssetAlertDialogPlatform.show(
        context: context,
        message: '🚨 Completa todos los campos obligatorios.',
        title: title);
    TextToSpeechService().speak('Completa todos los campos obligatorios.');
  }

  // **************************************** Type Textform basic******************************************************
  Widget textFormText({
    required TextEditingController controller,
    required String labelText,
    bool isRequired = false,
    bool isAllLines = false,
    Widget? suffixIcon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        title: P3Text(
          text: labelText.toUpperCase(),
          height: 2,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
            //
            textAlignVertical: isAllLines ? TextAlignVertical.top : null,
            maxLength: isAllLines ? 2000 : null,
            maxLines: isAllLines ? 4 : null,
            //
            decoration: AssetDecorationTextField.decorationTextField(
                hintText: isRequired ? 'campo obligatorio' : 'campo opcional',
                // labelText: '$labelText',
                suffixIcon: suffixIcon ?? null,
                prefixIcon: controller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => controller.clear(),
                        icon: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.grey,
                        ))),
            validator: isRequired
                ? (value) {
                    return validarCampoObligatorio(value);
                  }
                : null),
      ),
    );
  }

  Widget textFormEmail(
      {required TextEditingController controller,
      required String labelText,
      bool isRequired = false,
      Widget? suffixIcon}) {
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        title: P3Text(
          text: labelText.toUpperCase(),
          height: 2,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress, // Teclado para email
          decoration: AssetDecorationTextField.decorationTextField(
              hintText: isRequired ? 'campo obligatorio' : 'campo opcional',
              // labelText: '$labelText',
              suffixIcon: suffixIcon ?? null,
              prefixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => controller.clear(),
                      icon: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      ))),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Este campo es obligatorio';
            }
            if (value != null &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Ingrese un email válido';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget textFormDecimal(
      {required TextEditingController controller,
      required String labelText,
      bool isRequired = false,
      Widget? suffixIcon}) {
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        title: P3Text(
          text: labelText.toUpperCase(),
          height: 2,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: AssetDecorationTextField.decorationTextField(
              hintText: isRequired ? 'campo obligatorio' : 'campo opcional',
              // labelText: '$labelText',
              prefixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => controller.clear(),
                      icon: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      )),
              suffixIcon: suffixIcon ?? null),
          validator: isRequired
              ? (value) {
                  return validarCampoObligatorio(value);
                }
              : null,
        ),
      ),
    );
  }

  Widget textFormEntero(
      {required TextEditingController controller,
      required String labelText,
      bool isRequired = false,
      Widget? suffixIcon}) {
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        title: P3Text(
          text: labelText.toUpperCase(),
          height: 2,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: AssetDecorationTextField.decorationTextField(
              hintText: isRequired ? 'campo obligatorio' : 'campo opcional',
              // labelText: '$labelText',
              prefixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => controller.clear(),
                      icon: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      )),
              suffixIcon: suffixIcon ?? null),
          validator: isRequired
              ? (value) {
                  return validarCampoObligatorio(value);
                }
              : null,
        ),
      ),
    );
  }

  Widget textFormfecha({
    required TextEditingController controller,
    required String labelText,
    bool isRequired = false,
    required Function(String) onDateSelected, // Callback para pasar la fecha
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        title: P3Text(
          text: labelText.toUpperCase(),
          height: 2,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextFormField(
          controller: controller,
          decoration: AssetDecorationTextField.decorationTextField(
              hintText: isRequired ? 'campo obligatorio' : 'campo opcional',
              // labelText: '$labelText',
              prefixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => controller.clear(),
                      icon: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      )),
              suffixIcon: Icon(Icons.date_range)),
          style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
          readOnly: true, // Evita que el usuario escriba manualmente la fecha
          // onTap: () async {
          //   DateTime? pickedDate = await showDatePicker(
          //     context: context,
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(2000), // Fecha mínima
          //     lastDate: DateTime(2101), // Fecha máxima
          //   );

          //   if (pickedDate != null) {
          //     // setState(() => controller.text = pickedDate.toIso8601String());
          //     String formattedDate = pickedDate.toIso8601String();
          //     controller.text = formattedDate; // Actualiza el controlador
          //     onDateSelected(formattedDate); // Llama al callback con la fecha
          //   }
          // },
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              builder: (context, child) {
                return Localizations.override(
                  context: context,
                  // locale: const Locale('es', 'ES'), // Forzar español
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.2,
                      alwaysUse24HourFormat: true,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.teal,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.teal),
                        ),
                      ),
                      child: child!,
                    ),
                  ),
                );
              },
            );

            if (pickedDate != null) {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, child) {
                  // Forzar formato 24 horas o seguir configuración del sistema
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child!,
                  );
                },
              );

              if (pickedTime != null) {
                DateTime dateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                // Formato AM/PM por defecto
                // Convertir a formato ISO 8601 (ej. "2024-10-28T14:30:00")
                String isoDateTime = dateTime.toIso8601String();

                controller.text = isoDateTime; // Actualiza el controlador
                onDateSelected(isoDateTime); // Llama al callback
              }
            }
          },
          validator: isRequired
              ? (value) {
                  return validarCampoObligatorio(value);
                }
              : null,
        ),
      ),
    );
  }

  Widget switchAdaptive({
    String isTrue = 'Activo',
    String isFalse = 'Inactivo',
    required TextEditingController controller,
    required Function(String) onSelected, // Callback para pasar la fecha
  }) {
    // Verifica si el texto del controller está vacío
    bool isSwitchOn = controller.text.isEmpty || controller.text == 'true';

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: AssetDecorationBox().decorationBox(color: Colors.white),
        width: 130,
        margin: EdgeInsets.only(bottom: bottonmargin),
        child: Tooltip(
          message: isSwitchOn ? isTrue : isFalse,
          child: SwitchListTile.adaptive(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            visualDensity: VisualDensity.compact,
            dense: true,
            inactiveTrackColor: Colors.red,
            title: isSwitchOn ? AppSvg().fileSvg : AppSvg().trashRepoSvg,
            value: isSwitchOn,
            onChanged: (value) {
              // Llama al callback con el valor seleccionado
              onSelected(value.toString());
              // Actualiza el texto del controller basado en el estado del switch
              controller.text = value.toString();
            },
          ),
        ),
      ),
    );
  }

// **************************************** Type Textform Advance Selector Options******************************************************

  Widget multiSelectDropdown({
    required String key,
    required String subKey,
    bool isRequired = false,
    required TextEditingController controller,
    required Function(String) toggleDropdown, // Callback para pasar la fecha
    required Map<String, bool> showDropdowns, // Mapa como parámetro
  }) {
    final jsonData = Provider.of<JsonLoadProvider>(context, listen: false);
     bool isScroll = jsonData.isScroll;
    // Convierte el contenido del controlador en una lista de opciones seleccionadas
    List<String> _getSelectedOptions() {
      return controller.text.isEmpty ? [] : controller.text.split(', ');
    }

    // Actualiza el controlador con las opciones seleccionadas
    void _updateController(List<String> options) {
      controller.text = options.join(', ');
    }

     void cargarJson() async {
       await jsonData.loadJsonData(key: '$key', subKey: '$subKey');
                  toggleDropdown(subKey);
    }
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: Column(
        children: [
          ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              title: P3Text(
                text: '$subKey'.toUpperCase(),
                height: 2,
                fontWeight: FontWeight.bold,
              ),
              subtitle: TextFormField(
                readOnly: true, // Cambia a readOnly para evitar edición
                controller: controller,
                style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                decoration: AssetDecorationTextField.decorationTextField(
                    hintText:
                        isRequired ? 'campo obligatorio' : 'campo opcional',
                    // labelText: '$labelText',
                   suffixIcon: GestureDetector(
                      onTap: (){
                        cargarJson();
                         jsonData.setScroll(true); 
                      },
                      onDoubleTap: (){
                         cargarJson();
                         jsonData.setScroll(false); 
                      },
                       child: Tooltip(
                       message: isScroll ? 'Double-click to expand' : 'Click a row to select',
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:isScroll ? 
                          Icon(Icons.swap_horiz, size: 20, color: Colors.blueGrey,) : 
                          Icon(Icons.wrap_text, size: 20, color: Colors.blueGrey,),
                        ),
                      )),
                    prefixIcon: controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () => controller.clear(),
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey,
                            ))),
                validator: isRequired
                    ? (value) {
                        return validarCampoObligatorio(value);
                      }
                    : null,
                onTap: () async {
                  // toggleDropdown(subKey);
                  // await jsonData.loadJsonData(key: '$key', subKey: '$subKey');
                  // toggleDropdown(
                  //     subKey); // Muestra el dropdown al cargar las opciones
                  cargarJson();
                  jsonData.setScroll(true); 
                }, // Cierra todos los dropdowns al hacer clic en el texto
              )),
          if (showDropdowns[subKey]!)
            ScrollWeb(
              child: MultiSelectChipDisplay<String>(
                scroll: isScroll,
                textStyle: TextStyle(color: Colors.white, fontSize: 13),
                items:
                    jsonData.options.map((e) => MultiSelectItem(e, e)).toList(),
                colorator: (value) {
                  // Devuelve un color diferente si el valor está en selectedOptions
                  return _getSelectedOptions().contains(value)
                      ? Colors.green.shade500
                      : Colors.grey;
                },
                onTap: (value) {
                  List<String> selectedOptions = _getSelectedOptions();
                  if (selectedOptions.contains(value)) {
                    selectedOptions.remove(value);
                  } else {
                    selectedOptions.add(value);
                  }

                  _updateController(selectedOptions);
                  toggleDropdown(subKey); // Oculta el dropdown
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget singleSelectDropdown({
    required String key,
    required String subKey,
    bool isRequired = false,
    // bool isScroll = true,//Scroll por defecto activo 
    required TextEditingController controller,
    required Function(String) toggleDropdown, // Callback para pasar la fecha
    required Map<String, bool> showDropdowns, // Mapa como parámetro
  }) {
    final jsonData = Provider.of<JsonLoadProvider>(context, listen: false);
    // String? selectedValue;
    bool isScroll = jsonData.isScroll;

     void cargarJson() async {
       await jsonData.loadJsonData(key: '$key', subKey: '$subKey');
                  toggleDropdown(subKey);
    }
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: Column(
        children: [
          //  if (!_showDropdowns[subKey]!)
          ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              title: P3Text(
                text: '$subKey'.toUpperCase(),
                height: 2,
                fontWeight: FontWeight.bold,
              ),
              subtitle: TextFormField(
                readOnly: true, // Cambia a readOnly para evitar edición
                controller: controller,
                style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                decoration: AssetDecorationTextField.decorationTextField(
                    hintText: 'campo obligatorio',
                    // labelText: '$subKey',
                    suffixIcon: GestureDetector(
                      onTap: () async {
                         cargarJson();
                         jsonData.setScroll(true); 
                      },
                      onDoubleTap: () async {
                         cargarJson();
                         jsonData.setScroll(false); 
                      },
                      child: Tooltip(
                       message: isScroll ? 'Double-click to expand' : 'Click a row to select',
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:isScroll ? 
                          Icon(Icons.swap_horiz, size: 20, color: Colors.blueGrey,) : 
                          Icon(Icons.wrap_text, size: 20, color: Colors.blueGrey,),
                        ),
                      )),
                    prefixIcon: controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () => controller.clear(),
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey,
                            ))),
                validator: isRequired
                    ? (value) {
                        return validarCampoObligatorio(value);
                      }
                    : null,
                onTap: () async {
                 cargarJson();
                  jsonData.setScroll(true); 
                },
              ), 
            
              ),
          if (showDropdowns[subKey]!)
            ScrollWeb(
              child: MultiSelectChipDisplay<String>(
                items: jsonData.options.map((e) => MultiSelectItem(e, e)).toList(),
                scroll: isScroll,
                textStyle: TextStyle(
                  color: Colors.white, // Color del texto
                  fontSize: 13, // Tamaño del texto
                ),
                colorator: (value) {
                  return controller.text == value
                      ? Colors.green.shade500 // Color si está seleccionado
                      : Colors.grey; // Color si no está seleccionado
                },
                onTap: (value) {
                  controller.clear(); // Limpia las selecciones anteriores
                  controller.text = value; // Actualiza el controlador de texto
                  toggleDropdown(subKey); // Oculta el dropdown
                },
              ),
            ),
        ],
      ),
    );
  }


  // **************************************** Type Textform Autocomplete avanzado s******************************************************

  Widget autocompleteForm(
      {required String labelText,
      bool isRequired = false,
      required TextEditingController controller,
      required List<dynamic> lisData, // Lista de productos
      required String Function(dynamic) getField, // Función para obtener el campo dinámico
      }) {
    return Builder(
        // Función para obtener las unidades de medida únicas
        builder: (context) {
      List<String> obtenerUnidadesDeMedida(String query) {
        // Usamos un Set para eliminar duplicados
        final Set<String> unidades = {};
        for (var producto in lisData) {
          // Utiliza la función proporcionada para obtener el campo
          unidades.add(getField(producto));
        }
        return unidades
            .where((unidad) => unidad.toLowerCase().contains(query))
            .toList();
      }

      return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          final query = textEditingValue.text.toLowerCase();
          // Lista Filtra las unidades de medida  medida únicas según el texto ingresado
          final List<String> unidadesDeMedida = obtenerUnidadesDeMedida(query);
          return unidadesDeMedida;
        },
        onSelected: (String seleccion) {
          print('Seleccionaste: $seleccion');
          // Actualiza tu _controller con la selección
          controller.text =
              seleccion; // Esto actualizará el valor que ves en H2Text
        },
        fieldViewBuilder:
            (context, _isController, focusNode, onFieldSubmitted) {
            // Solo actualiza el controlador si está vacío
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_isController.text.isEmpty) {
                try {
                  _isController.text = controller.text; // Asigna el valor del controlador principal
                } catch (e) {
                  print(e);
                }
              }
            });
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              title: P3Text(
                text: '$labelText'.toUpperCase(),
                height: 2,
                fontWeight: FontWeight.bold,
              ),
              subtitle: TextFormField(
                controller: _isController,//_isController,
                focusNode: focusNode,
                style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                decoration: AssetDecorationTextField.decorationTextField(
                    hintText:
                        isRequired ? 'campo obligatorio' : 'campo opcional',
                    // labelText: '$subKey',
                    suffixIcon:  Icon(Icons.search, size: 16),
                    prefixIcon: _isController.text.isEmpty//_isController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _isController.clear();
                              controller.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey,
                            ))),
                onFieldSubmitted: (value) => onFieldSubmitted(),
                onChanged: (value) {
                  // Actualiza el _controller con el texto que está escribiendo el usuario
                  controller.text = value;
                },
                validator: isRequired
                    ? (value) {
                        return validarCampoObligatorio(value);
                      }
                    : null,
              ),
            ),
          );
        },
      );
    });
  }

  Widget autocompleteFormWithWarning(
      {required String labelText,
      required String valueComparate,//Si es editar se debe pasar el valor para comparar y determnar si es valor exitent o no 
      bool isRequired = false,
      required TextEditingController controller,
      required List<dynamic> lisData, // Lista de productos
      required String Function(dynamic) getField, // Función para obtener el campo dinámico
      }) {
    return Builder(builder: (context) {

      List<String> obtenerUnidadesDeMedida(String query) {
        final Set<String> unidades = {};
        for (var producto in lisData) {
          // Utiliza la función proporcionada para obtener el campo
          unidades.add(getField(producto));
        }
        return unidades
            .where((unidad) => unidad.toLowerCase().contains(query))
            .toList();
      }

      return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          final query = textEditingValue.text.toLowerCase();
          // Filtra las opciones según el texto ingresado
          final List<String> unidadesDeMedida = obtenerUnidadesDeMedida(query);
          return unidadesDeMedida;
        },
        onSelected: (String seleccion) {
          // Comprobar si el ID seleccionado ya existe
          if (lisData.any((producto) => getField(producto) == seleccion)  && seleccion != valueComparate) {
            TextToSpeechService().speak(
                'El valor ingresado ya existe. Ingrese un valor diferente.');
            // Limpiar el controller si se selecciona un ID existente
            // controller.text = seleccion;
            // controller.clear();
          } else {
            print('Seleccionaste: $seleccion');
            // Actualiza tu controller con la selección
            controller.text = seleccion; // Esto actualizará el valor que ves en H2Text
          }
        },
        fieldViewBuilder:
            (context, _isController, focusNode, onFieldSubmitted) {
           // Solo actualiza el controlador si está vacío
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_isController.text.isEmpty) {
                try {
                  _isController.text = controller.text; // Asigna el valor del controlador principal
                } catch (e) {
                  print(e);
                }
              }
            });

          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              title: P3Text(
                text: '$labelText'.toUpperCase(),
                height: 2,
                fontWeight: FontWeight.bold,
              ),
              subtitle: Column(
                children: [
                  TextFormField(
                    controller: _isController,//controller,//
                    focusNode: focusNode,
                    style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                    decoration: AssetDecorationTextField.decorationTextField(
                        hintText:
                            isRequired ? 'campo obligatorio' : 'campo opcional',
                       suffixIcon:  Icon(Icons.search, size: 16),
                        prefixIcon: _isController.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _isController.clear();
                                  controller.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.grey,
                                ))),
                    onFieldSubmitted: (value) => onFieldSubmitted(),
                    onChanged: (value) {
                      print('VALUES AUTOCOMPELTe: $value');
                      // Validar el valor al enviar el formulario
                      if (lisData.any((producto) => getField(producto) == value)  && value != valueComparate) {
                        TextToSpeechService().speak(
                            'El valor ingresado ya existe. Ingrese un valor diferente.');
                      } else {
                        TextToSpeechService().speak('Valor válido.');
                      }
                      // Actualiza el _controller con el texto que está escribiendo el usuario
                      controller.text = value;
                    },
                    validator: (value) {
                      // Verificar si el campo está vacío
                      if (isRequired && (value == null || value.isEmpty)) {
                        return 'Este campo es obligatorio.';
                      }
                      // Verificar si el valor ya existe en la lista
                      if (value != null &&
                          lisData.any((producto) => getField(producto) == value)  && value != valueComparate) {
                        TextToSpeechService().speak(
                            'El valor ingresado ya existe. Ingrese un valor diferente.');
                        // controller.clear();
                        // _isController.clear();
                        return 'Valor existente. Ingrese un valor diferente.';
                      }
                  
                      // Verificar si el valor cumple con las restricciones
                      if (!RegExp(r'(?=.*[A-Z])(?=.*\d).{5,}')
                          .hasMatch(value ?? '')) {
                        if (value != '') {
                          TextToSpeechService().speak(
                              'El valor debe contener mayúsculas, números y al menos 5 caracteres.');
                        }
                        return 'mayúsculas, números, mínimo 5 caracteres.';
                      }
                  
                      return null; // Si pasa todas las validaciones, no hay error
                    },
                  ),
                 
                      
                ],
              ),
            ),
          );
        },
      );
    });
  }
// **************************************** Otros componentes y funciones P{oketbase **********************************************

  Widget singleSelectDropdownPoketbase({
    required String key,
    required String subKey,
    required TextEditingController controller,
    required Function(String) toggleDropdown, // Callback para pasar la fecha
    required Map<String, bool> showDropdowns, // Mapa como parámetro
  }) {
    final jsonData = Provider.of<JsonLoadProvider>(context, listen: false);
    // String? selectedValue;
    return Container(
      margin: EdgeInsets.only(bottom: bottonmargin),
      child: Column(
        children: [
         
          if (showDropdowns[subKey]!)
            ScrollWeb(
              child: MultiSelectChipDisplay<String>(
                items: jsonData.options.map((e) => MultiSelectItem(e, e)).toList(),
                scroll: true,
                height: 40,
                textStyle: TextStyle(
                    color: Colors.white, // Color del texto
                    fontSize: 11, // Tamaño del texto
                    fontWeight: FontWeight.bold),
                colorator: (value) {
                 value =  subKey == 'active' ? value : '"$value"';
                  // Dividir el texto y asegurarte de que hay al menos dos partes
                  List<String> parts = controller.text.split('=');
                  if (parts.length > 1) {
                    return parts[1].trim() == value //'"$value"'
                        ? Colors.deepOrange // Color si está seleccionado
                        : Colors.black38; // Color si no está seleccionado
                  }
                  return Colors.grey; 
                      // Valor por defecto si no se pudo dividir correctamente
                },
                onTap: (value) {
                  controller.clear(); // Limpia las selecciones anteriores
                  controller.text =
                      '$value'; // Actualiza el controlador de texto
                  toggleDropdown(subKey); // Oculta el dropdown
                },
              ),
            ),
          //    Row(
          //   children: [
          //     controller.text.isEmpty
          //         ? SizedBox()
          //         : IconButton(
          //             onPressed: () async {
          //               controller.clear();
          //               await jsonData.loadJsonData(
          //                   key: '$key', subKey: '$subKey');
          //               toggleDropdown(subKey); // Oculta el dropdown
          //             },
          //             icon: Icon(
          //               Icons.close,
          //               size: 16,
          //               color: Colors.grey,
          //             )),
          //     Container(
          //       decoration: AssetDecorationBox().decorationBox(color: Colors.white),
          //       child: P3Text(
          //         text: '  ${controller.text}  ',
          //         height: 2,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  
  
  // **************************************** Avanzado atucomplete filter list ******************************************************

  Widget autocomleteSearchListQrDaTa(
      {required bool Function(dynamic producto, String query) getField,
      required String Function(dynamic producto) getName,
      required String Function(dynamic producto) getQr,
      required String Function(dynamic producto) getId,
      required List<dynamic> listaProducto}) {
    final qrData = Provider.of<QrLectorProvider>(context, listen: false);

    return Autocomplete<Object>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return Iterable<Object>.empty(); // Aquí no usamos 'const' por el tipo genérico
        }

        final query = textEditingValue.text.toLowerCase();

        // Filtra los productos según el texto ingresado en cualquier campo relevante
        return listaProducto
            .where((producto) => getField(producto, query))
            .cast<Object>();
      },
      displayStringForOption: (producto) => getName(producto), // Muestra solo el nombre

      fieldViewBuilder: (context, _isController, focusNode, onFieldSubmitted) {
        // _controller = controller; // Asigna directamente al controlador
        return TextFormField(
          controller: _isController,
          focusNode: focusNode,
          style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
          decoration: AssetDecorationTextField.decorationTextField(
              hintText: 'Buscar registro',
              labelText: 'Buscar registro',
              suffixIcon: Icon(Icons.search, size: 16),
              prefixIcon: _isController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _isController.clear();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      ))),
          onFieldSubmitted: (value) => onFieldSubmitted(),
          onChanged: (value) {
            // Validar el valor al enviar el formulario
            if (listaProducto
                .any((producto) => getField(producto, value) == value)) {
              TextToSpeechService().speak('El valor ingresado si existe.');
            } else {
              TextToSpeechService().speak('El valor ingresado no existe.');
            }
          },
        );
      },

      onSelected: (dynamic producto) {
        qrData.setQrCode('${producto.id}|${producto.qr}');
      },

     optionsViewBuilder: (context, onSelected, options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: Container(
            width: 300,
            child: ScrollWeb(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: options.map((producto) {
                  return Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(color: AppColors.menuHeaderTheme.withOpacity(.5)),
                    padding: EdgeInsets.only(bottom: 5, right: 10, left: 10),
                    margin: EdgeInsets.only(bottom: 1),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Icon(Icons.folder_open_outlined, color: Colors.blue),
                      title: H3Text(text:
                        getName(producto),
                        fontSize: 12, fontWeight: FontWeight.bold,
                        color: AppColors.menuTextDark
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: TextStyle(color: AppColors.menuTheme , fontSize: 11),
                          children: [
                            TextSpan(text: 'ID  :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: getId(producto)),
                            TextSpan(text: '\nQR :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: getQr(producto)),
                          ],
                        ),
                      ),
                      onTap: () => onSelected(producto),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
    },
    );
  }


  Widget autocomleteSearchListForm(
      {
      required bool Function(dynamic producto, String query) getField,
      required String Function(dynamic producto) getName,
      required String Function(dynamic producto) getQr,
      required String Function(dynamic producto) getId,
      required TextEditingController controller,
      required List<dynamic> listaProducto,
      required Map<String, dynamic> Function(dynamic producto) toJson,
      required dynamic Function(Map<String, dynamic> json) fromJson,
       required String title,
      }) {
        
      // Convierte el JSON almacenado en controller.text a una lista de productos dinámicos.
      List<dynamic> getListaMarcasFromController() {
        if (controller.text.isEmpty) return [];
        return (jsonDecode(controller.text) as List<dynamic>)
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // Actualiza el controller.text con la lista de productos en formato JSON.
      void actualizarControllerText(List<dynamic> listaMarcas) {
        controller.text = jsonEncode(listaMarcas.map((producto) => toJson(producto)).toList());
      }
    
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              title: P3Text(
                text: '$title'.toUpperCase(),
                height: 2,
                fontWeight: FontWeight.bold,
              ),
      subtitle: Autocomplete<Object>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return Iterable<Object>.empty(); // Aquí no usamos 'const' por el tipo genérico
          }
      
          final query = textEditingValue.text.toLowerCase();
          // Filtra los productos según el texto ingresado en cualquier campo relevante
          return listaProducto.where((producto) => getField(producto, query)).cast<Object>();
        },
        displayStringForOption: (producto) => getName(producto), // Muestra solo el nombre
      
        fieldViewBuilder: (context, _isController, focusNode, onFieldSubmitted) {
          // _controller = controller; // Asigna directamente al controlador
          return TextFormField(
            controller: _isController,
            focusNode: focusNode,
            style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
            decoration: AssetDecorationTextField.decorationTextField(
                hintText: 'Buscar item',
                labelText: 'Escribe aqui',
                suffixIcon: Icon(Icons.search, size: 16),
                prefixIcon: _isController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _isController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.grey,
                        ))),
            onFieldSubmitted: (value) => onFieldSubmitted(),
          );
        },
      
        onSelected: (dynamic producto) async {
        // Obtén la lista actual desde el controller.
        List<dynamic> currentItems = getListaMarcasFromController();
        // Agrega el producto seleccionado solo si no está ya en la lista.
          if (!currentItems.any((item) => getId(item) == getId(producto) || getQr(item) == getQr(producto))) {
            bool isAdd = await showDialog(
              context: context,
              builder: (context) {
                TextToSpeechService().speak('Deseas añadir este registro?. ${producto.nombre}');
                return AssetAlertDialogPlatform(
                  oK_textbuton: 'Agregar',
                  message: 'Deseas añadir este registro?', 
                  title: '${producto.nombre}');
              }
            ) ?? true;
            // Agregar el producto solo si el usuario acepta
            if(!isAdd)  {
              currentItems.add(producto);
              TextToSpeechService().speak('Nuevo valor ingresado. ${producto.nombre}');
            }
            else {
              TextToSpeechService().speak('El valor no fue añadido.');
            }
          } else {
            TextToSpeechService().speak('El valor ya existe. ${producto.nombre}');
          }
          // Actualiza el controller con la lista actualizada en formato JSON.
          actualizarControllerText(currentItems);
        
        },
        optionsViewBuilder: (context, onSelected, options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: Container(
            width: 300,
            child: ScrollWeb(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: options.map((producto) {
                  return Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(color: AppColors.menuHeaderTheme.withOpacity(.5)),
                    padding: EdgeInsets.only(bottom: 5, right: 10, left: 10),
                    margin: EdgeInsets.only(bottom: 1),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Icon(Icons.folder_open_outlined, color: Colors.blue),
                      title: H3Text(text:
                        getName(producto),
                        fontSize: 12, fontWeight: FontWeight.bold,
                        color: AppColors.menuTextDark
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: TextStyle(color: AppColors.menuTheme , fontSize: 11),
                          children: [
                            TextSpan(text: 'ID  :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: getId(producto)),
                            TextSpan(text: '\nQR :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: getQr(producto)),
                          ],
                        ),
                      ),
                      onTap: () => onSelected(producto),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
    },
      ),
    );
  }

  //todos Exclusivo pra lisat de entregas  
  Widget autocomleteSearchListEntregas({
  required String title,
  required List<dynamic> listaPadre, // Lista de opciones disponibles
  required List<dynamic> listaHijo, // Lista que estamos editando
  required String Function(dynamic producto) getName,
  required String Function(dynamic producto) getQr,
  required String Function(dynamic producto) getId,
  //Valores protegidos 
  required double Function(dynamic producto) getCantidadEnStock,
  required bool Function(dynamic producto) getActive,
  required String Function(dynamic producto) getObservacion,
  //filtrado 
  required bool Function(dynamic producto, String query) getField,
  //mapeo 
  required Map<String, dynamic> Function(dynamic producto) toJson,
  required dynamic Function(Map<String, dynamic> json) fromJson,
}) {
  return Autocomplete<Object>(
      // optionsBuilder: (TextEditingValue textEditingValue) {
      //   if (textEditingValue.text.isEmpty) {
      //     return Iterable<Object>.empty();
      //   }
      //   final query = textEditingValue.text.toLowerCase();
      //   // Filtrar elementos de la lista padre basados en el query
      //   return listaPadre.where((producto) => getField(producto, query)).cast<Object>();
      // },
      // optionsBuilder: (TextEditingValue textEditingValue) {
      //   final query = textEditingValue.text.trim();
      //   if (query.isEmpty || query.contains(RegExp(r'^\s*$'))) {
      //     // Si solo contiene espacios, mostrar todas las opciones
      //     return listaPadre.cast<Object>();
      //   } else {
      //     // Si tiene algún texto, filtrar las opciones
      //     return listaPadre.where((producto) => getField(producto, query)).cast<Object>();
      //   }
      // },
      optionsBuilder: (TextEditingValue textEditingValue) {
          final query = textEditingValue.text;

          // Si el texto está vacío, no mostrar ninguna opción
          if (query.isEmpty) {
            return Iterable<Object>.empty();
          }

          // Si el texto contiene solo espacios, mostrar todas las opciones
          if (query.contains(RegExp(r'^\s+$'))) {
            return listaPadre.cast<Object>();  // Mostrar todas las opciones si solo hay espacios
          }

          // Si el usuario escribe algo, filtrar las opciones según el query
          return listaPadre.where((producto) => getField(producto, query)).cast<Object>();
        },
      displayStringForOption: (producto) => getName(producto),
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
           decoration: AssetDecorationTextField.decorationTextFieldRectangle(
                labelText : 'añadir nuevo registro',
                hintText : 'Escribe aqui',
                suffixIcon: AppSvg(width: 20).createFilledSvg,
                prefixIcon: textEditingController.text.isEmpty
                    ? null
                    : IconButton(
                         onPressed: textEditingController.clear,
                         icon: Icon( Icons.close, size: 16))
                ),
          onFieldSubmitted: (value) => onFieldSubmitted(),
        );
      },
      onSelected: (dynamic producto) async {
        // Verificar si el producto ya está en la lista hijo
        bool noExiste = !listaHijo.any((item) => getId(item) == getId(producto) || getQr(item) == getQr(producto));
        if (noExiste) {
           // Crear copias locales de los valores para no afectar los datos originales
            double cantidadEnStockLocal = getCantidadEnStock(producto);
            String observacionLocal = getObservacion(producto);
            bool isActiveLocal = getActive(producto);
          // Mostrar confirmación antes de añadir
           bool shouldAdd = await showDialog<bool>(
                context: context,
                builder: (context) {
               TextToSpeechService().speak('¿Te gustaría añadir ${producto.nombre} como nuevo registro?');
                return AssetAlertDialogPlatform(
                  oK_textbuton: 'Añadir',
                  actionButon: CupertinoDialogAction(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                  message: 'Deseas añadir este registro?. Personaliza la cantidad y los datos según lo que necesites.', 
                  title: '${producto.nombre}', 
                  child: Material(
                    color: Colors.transparent,
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          children: [
                            TextFormField(
                              initialValue: cantidadEnStockLocal.toString(),
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
                              decoration:AssetDecorationTextField.decorationTextFieldUnderLine(
                                    hintText: 'Cantidad a entregar',
                                    fillColor : Colors.transparent
                                  ),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+(\.\d{0,2})?$'), // Solo permite números con hasta dos decimales.
                                ),
                              ],
                              onChanged: (value) {
                                // Modificar el valor localmente sin afectar al producto original
                                cantidadEnStockLocal = double.parse(value);
                              },
                            ),
                            TextFormField(
                              initialValue: observacionLocal,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
                              decoration:AssetDecorationTextField.decorationTextFieldUnderLine(
                                    hintText: 'Observación',
                                    fillColor : Colors.transparent
                                  ),
                              onChanged: (value) {
                                // Modificar el valor localmente sin afectar al producto original
                                 observacionLocal = value;
                              },
                            ),
                            SizedBox(height:10),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              activeColor: Colors.red,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.green.shade600,
                              title:  Chip(
                              backgroundColor: AppColors.menuHeaderTheme,
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              visualDensity: VisualDensity.compact,
                              // side: BorderSide.none,
                              label: P1Text(text:isActiveLocal
                                    ? 'COMPRAR 😡🛑' // Rojo para advertir
                                    : 'NO COMPRAR 😊', // Verde para indicar que está todo bien
                                  fontSize: 13,
                                  color:  Colors.black)
                                  ),
                                  value: isActiveLocal,
                                  onChanged: (value) {
                                    // Modificar el valor localmente sin afectar al producto original
                                      setState(() {
                                        isActiveLocal = value;
                                      });
                                  },
                              
                            )
                          ],
                        );
                      }
                    ),
                  ),
                  );
              }
            ) ?? true;

          if (!shouldAdd) {
            // Cuando se haya confirmado que el producto se debe añadir, se puede crear un nuevo producto
              // usando los valores modificados (y no los originales)
               producto = fromJson({
                ...toJson(producto), // Copiar todos los valores del nuevo producto
                  'cantidad_en_stock': cantidadEnStockLocal, // Mantener valores protegidos
                   'active': isActiveLocal,  // Nuevo valor para 'active'
                   'observacion': observacionLocal, // Nuevo valor para 'observacion'
                });

             listaHijo.add(producto);
             TextToSpeechService().speak('Nuevo valor ingresado. ${producto.nombre}');
          }
           else { TextToSpeechService().speak('El valor ${getName(producto)} no fue añadido.');}
        } else {
            // Mostrar confirmación antes de añadir
            bool shouldAdd = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                  TextToSpeechService().speak('${getName(producto)} ya está en la lista. ¿Te gustaría sobrescribir este registro?');

                  
                  return AssetAlertDialogPlatform(
                    actionButon: CupertinoDialogAction(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                    oK_textbuton: 'Sobreescribir',
                    message: 'Deseas Sobreescribir este registro?', 
                    title: '${producto.nombre}');
                }
              ) ?? true;
               if (!shouldAdd) {
                 // Buscar todos los productos con el mismo ID en la lista hijo
                  listaHijo.asMap().forEach((index, item) {
                    if (getId(item) == getId(producto)) {
                     // Mantener los valores protegidos y actualizar los demás campos manualmente
                      listaHijo[index] = fromJson({
                        ...toJson(producto), // Copiar todos los valores del nuevo producto
                        'cantidad_en_stock': getCantidadEnStock(item), // Mantener valores protegidos
                        'active': getActive(item),
                        'observacion': getObservacion(item),
                      });

                      TextToSpeechService().speak('El producto ${getName(producto)} en la posición $index ha sido actualizado manteniendo los valores protegidos.');
                    }
                  });
              }
              else { TextToSpeechService().speak('El valor ${getName(producto)} no fue añadido.');}
        }
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxWidth: 350),
              // child: ListView(
              //   padding: EdgeInsets.symmetric(vertical: 8),
              //   children: options.map((dynamic producto) {
              //     return ListTile(
              //       leading: Icon(Icons.folder_open_outlined, color: Colors.blue),
              //       title: Text(getName(producto), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              //       subtitle: Text('ID: ${getId(producto)}\nQR: ${getQr(producto)}'),
              //       onTap: () => onSelected(producto),
              //     );
              //   }).toList(),
              // ),
              child: ScrollWeb(
                child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120),
                itemCount: options.length,
                itemBuilder: (context, index) {
                // Convertimos el Iterable a una lista para poder acceder por índice
                  dynamic producto = options.toList()[index]; 
                  print(index);
                  return ListTile(
                    leading: Icon(Icons.folder_open_outlined, color: Colors.blue),
                    title: H3Text(text: getName(producto)),
                    subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'ID: ',
                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getId(producto),
                              style: TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                            TextSpan(
                              text: '\nQR: ',
                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getQr(producto),
                              style: TextStyle(color: Colors.green, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    onTap: () => onSelected(producto),
                    trailing:  Chip(
                       backgroundColor: Colors.white,
                       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                       visualDensity: VisualDensity.compact,
                       label: P3Text(text:'${getCantidadEnStock(producto)}', 
                       fontWeight: FontWeight.bold),
                    )
                  );
                },
                            ),
              ),
            ),
          ),
        );
      },
  );
}


  
  
 Widget autocomplete_IDRelationForm({
  required String labelText,
  required TextEditingController controller, // El controller se pasa como parámetro
  required bool Function(dynamic producto, String query) getField,
  required String Function(dynamic producto) getName,
  required String Function(dynamic producto) getQr,
  required String Function(dynamic producto) getId,
  required List<dynamic> listaProducto,
}) {
  return Autocomplete<Object>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text.isEmpty) {
        return const Iterable<Object>.empty();
      }

      final query = textEditingValue.text.toLowerCase();

      // Filtra los productos según el texto ingresado en cualquier campo relevante
        return listaProducto
            .where((producto) => getField(producto, query))
            .cast<Object>();
    },
    displayStringForOption: (producto) => getName(producto), // Muestra el nombre del producto

    fieldViewBuilder: (context, _isController, focusNode, onFieldSubmitted) {
      // Asigna el valor del controller pasado como parámetro
      // controller.text = _isController.text;

      return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              // title: P3Text(
              //       text: '${getName(producto)}'.toUpperCase(),
              //       height: 2,
              //     ),
              subtitle:  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      P3Text(
                      text: '$labelText'.toUpperCase(),
                      height: 2,
                      fontWeight: FontWeight.bold,
                                           ),
                    if(controller.text.isNotEmpty)
                    Chip(
                          backgroundColor: AppColors.menuHeaderTheme,
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          visualDensity: VisualDensity.compact,
                          side: BorderSide.none,
                          label: P3Text(text: '${controller.text}   ',  color: AppColors.menuTextDark,),
                          onDeleted: () {
                             _isController.clear();
                            controller.clear();
                          },
                        ),
                      
                       
                    ],
                  ),

                  TextFormField(
                  controller: _isController,
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                  decoration: AssetDecorationTextField.decorationTextField(
                  hintText: 'Buscar Item',
                  labelText: 'Escribe aqui',
                  suffixIcon: Icon(Icons.search, size: 16),
                  prefixIcon: _isController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _isController.clear();
                            controller.clear();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                              ),
                     onFieldSubmitted: (value) => onFieldSubmitted(),
                    //  onChanged: (value) {
                    //   // Validar si el valor existe en la lista de productos
                    //   final exists = listaProducto.any((producto) => getField(producto, value));
                    //   if (exists) {
                    //     TextToSpeechService().speak('El valor ingresado sí existe.');
                    //   } else {
                    //     TextToSpeechService().speak('El valor ingresado no existe.');
                    //   }
                    // },
                  ),

                ],
              ),
        ),
      );
    },

    onSelected: (dynamic producto) {
      // Actualiza el controlador con el ID del producto seleccionado
      controller.text = getId(producto);
    },

    optionsViewBuilder: (context, onSelected, options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: Container(
            width: 300,
            child: ScrollWeb(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: options.map((producto) {
                  return Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(color: AppColors.menuHeaderTheme.withOpacity(.5)),
                    padding: EdgeInsets.only(bottom: 5, right: 10, left: 10),
                    margin: EdgeInsets.only(bottom: 1),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Icon(Icons.folder_open_outlined, color: Colors.blue),
                      title: H3Text(text:
                        getName(producto),
                        fontSize: 12, fontWeight: FontWeight.bold,
                        color: AppColors.menuTextDark
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: TextStyle(color: AppColors.menuTheme , fontSize: 11),
                          children: [
                            TextSpan(text: 'ID  :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: getId(producto)),
                            TextSpan(text: '\nQR :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: getQr(producto)),
                          ],
                        ),
                      ),
                      onTap: () => onSelected(producto),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
    },
  );
}



  
  Widget autocompleteMulti_IDRelationForm({
  required String labelText,
  required TextEditingController controller, // El controller se pasa como parámetro
  required bool Function(dynamic producto, String query) getField,
  required String Function(dynamic producto) getName,
  required String Function(dynamic producto) getQr,
  required String Function(dynamic producto) getId,
  required List<dynamic> listaProducto,
}) {
  // Convierte el contenido del controller en una lista de IDs seleccionados
  // List<String> _getSelectedOptions() {
  //   return controller.text.isEmpty ? [] : controller.text.split(', ');
  // }
  List<String> _getSelectedOptions() {
  // Normaliza el texto eliminando espacios extra
  return controller.text
      .split(',')
      .map((e) => e.trim()) // Elimina espacios alrededor de cada valor
      .where((e) => e.isNotEmpty) // Filtra elementos vacíos
      .toList();
}


  // Actualiza el controlador con la lista de IDs seleccionados
  void _updateController(List<String> options) {
    controller.text = options.join(', ');
  }

  return StatefulBuilder(
    builder: (context, setState) {
      // Aseguramos que al iniciar se actualicen los chips si ya hay valores en el controller
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });

      return Autocomplete<Object>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<Object>.empty();
          }
      
          final query = textEditingValue.text.toLowerCase();
      
          // Filtra los productos según el texto ingresado en cualquier campo relevante
          return listaProducto
              .where((producto) => getField(producto, query))
              .cast<Object>();
        },
        displayStringForOption: (producto) => getName(producto), // Muestra el nombre del producto
      
        fieldViewBuilder: (context, _isController, focusNode, onFieldSubmitted) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              dense: true,
              minVerticalPadding: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  P3Text(
                    text: '${labelText.toUpperCase()}',
                    height: 2,
                    fontWeight: FontWeight.bold,
                  ),
                  P3Text(
                    text: '(Seleccion Multiple)',
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_getSelectedOptions().isNotEmpty)
                    Wrap(
                      spacing: 2.0,
                      children: _getSelectedOptions().map((id) {
                        return Chip(
                          backgroundColor: AppColors.menuHeaderTheme,
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          visualDensity: VisualDensity.compact,
                          side: BorderSide.none,
                          label: P3Text(
                            text: id,
                            color: AppColors.menuTextDark,
                          ),
                          onDeleted: () {
                            List<String> currentOptions = _getSelectedOptions();
                            currentOptions.remove(id);
                            _updateController(currentOptions);
                            setState(() {}); // Actualizamos los chips
                          },
                        );
                      }).toList(),
                    ),
                  TextFormField(
                    controller: _isController,
                    focusNode: focusNode,
                    style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                    decoration: AssetDecorationTextField.decorationTextField(
                      hintText: 'Buscar Item',
                      labelText: 'Escribe aqui',
                      suffixIcon: Icon(Icons.search, size: 16),
                      prefixIcon: _isController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _isController.clear();
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    onFieldSubmitted: (value) => onFieldSubmitted(),
                  ),
                ],
              ),
            ),
          );
        },
      
        onSelected: (dynamic producto) {
          // Actualiza el controlador con el ID del producto seleccionado
          List<String> selectedOptions = _getSelectedOptions();
          final id = getId(producto);
          if (!selectedOptions.contains(id)) {
            selectedOptions.add(id);
            _updateController(selectedOptions);
            setState(() {}); // Actualizamos los chips
          }
        },
      
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: Container(
                width: 300,
                child: ScrollWeb(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    children: options.map((producto) {
                      return Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(color: AppColors.menuHeaderTheme.withOpacity(.5)),
                        padding: EdgeInsets.only(bottom: 5, right: 10, left: 10),
                        margin: EdgeInsets.only(bottom: 1),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          leading: Icon(Icons.folder_open_outlined, color: Colors.blue),
                          title: H3Text(
                              text: getName(producto),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.menuTextDark),
                          subtitle: RichText(
                            text: TextSpan(
                              style: TextStyle(color: AppColors.menuTheme, fontSize: 11),
                              children: [
                                TextSpan(text: 'ID  :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: getId(producto)),
                                TextSpan(text: '\nQR :   ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: getQr(producto)),
                              ],
                            ),
                          ),
                          onTap: () => onSelected(producto),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

  ///UTILS 
  // **************************************** Type Textform Avanzados ******************************************************

  //Expande Titulo
  Widget expandedSelector() {
    return ExpansionTile(
      title: Text('Opciones avanzadas'),
      children: [
        ListTile(title: Text('Opción 1')),
        ListTile(title: Text('Opción 2')),
      ],
    );
  }

//Sleeccionar opciones con scroll vertical
  Widget cupertinopicker() {
    return CupertinoPicker(
      itemExtent: 132.0,
      onSelectedItemChanged: (int index) {
        print('Seleccionaste: $index');
      },
      children: List<Widget>.generate(10, (int index) {
        return Center(child: Text('Opción $index'));
      }),
    );
  }

// Es como un butoon bar de opciones, optimo para idiomas,
  Widget cupertinoSegmentedControl() {
    return CupertinoSegmentedControl<int>(
      children: {
        0: Text('Día'),
        1: Text('Semana'),
        2: Text('Mes'),
      },
      onValueChanged: (int value) {
        print('Vista seleccionada: $value');
      },
    );
  }

  List<bool> isSelected = [true, false, false]; // poner antes de l builder
//Igual al anterior
  Widget toggleButtons() {
    return ToggleButtons(
      children: [
        Icon(Icons.list),
        Icon(Icons.grid_view),
        Icon(Icons.map),
      ],
      isSelected: isSelected,
      onPressed: (int index) {
        isSelected[index] = !isSelected[index];
        print('Botón $index seleccionado: ${isSelected[index]}');
      },
    );
  }

// Selección Para ordenamiento, interesante para pasar lista de compras y poder ordenarlas tipo exce.
  List<String> items = ['Opción 1', 'Opción 2', 'Opción 3'];
  Widget reorderableListView() {
    return Container(
      height: 300,
      child: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) newIndex--;
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        },
        children: [
          for (final item in items)
            ListTile(key: ValueKey(item), title: Text(item)),
        ],
      ),
    );
  }

List<String> itemsbuilder = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4', /* más de 150 elementos */];

Widget reorderableListViewBuilder() {
  return Container(
    height: 300,
    child: ReorderableListView.builder(
      itemCount: itemsbuilder.length,
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex > oldIndex) newIndex--;
        final item = itemsbuilder.removeAt(oldIndex);
        itemsbuilder.insert(newIndex, item);
      },
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(itemsbuilder[index]), // Necesario para que los elementos se puedan mover
          title: Text(itemsbuilder[index]),
        );
      },
    ),
  );
}


// import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

// List<String> items = ['Opción 1', 'Opción 2', 'Opción 3'];

// Widget reorderableListView() {
//   return Container(
//     height: 300,
//     child: ReorderableList(
//       onReorder: (oldIndex, newIndex) {
//         if (newIndex > oldIndex) newIndex--;
//         final item = items.removeAt(oldIndex);
//         items.insert(newIndex, item);
//       },
//       children: [
//         for (final item in items)
//           ReorderableItem(
//             key: ValueKey(item),
//             child: ListTile(title: Text(item)),
//           ),
//       ],
//     ),
//   );
// }
}

