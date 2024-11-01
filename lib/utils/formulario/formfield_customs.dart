import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/json_loading/provider_json.dart';
import 'package:webandean/provider/cache/qr_lector/qr_lector_provider.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files/assets-svg.dart';
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
            decoration: decorationTextField(
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
          decoration: decorationTextField(
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
          decoration: decorationTextField(
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
          decoration: decorationTextField(
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
          decoration: decorationTextField(
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

  // **************************************** Type Textform Autocomplete avanzado s******************************************************

  Widget autocompleteForm(
      {required String labelText,
      bool isRequired = false,
      required TextEditingController controller,
      required List<dynamic> lisData, // Lista de productos
      required String Function(dynamic)
          getField // Función para obtener el campo dinámico
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
                controller: _isController,
                focusNode: focusNode,
                style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                decoration: decorationTextField(
                    hintText:
                        isRequired ? 'campo obligatorio' : 'campo opcional',
                    // labelText: '$subKey',
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
      bool isRequired = false,
      required TextEditingController controller,
      required List<dynamic> lisData, // Lista de productos
      required String Function(dynamic)
          getField // Función para obtener el campo dinámico
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
          if (lisData.any((producto) => getField(producto) == seleccion)) {
            TextToSpeechService().speak(
                'El valor ingresado ya existe. Ingrese un valor diferente.');
            // Limpiar el controller si se selecciona un ID existente
            controller.text = seleccion;
            controller.clear();
          } else {
            print('Seleccionaste: $seleccion');
            // Actualiza tu controller con la selección
            controller.text =
                seleccion; // Esto actualizará el valor que ves en H2Text
          }
        },
        fieldViewBuilder:
            (context, _isController, focusNode, onFieldSubmitted) {
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
                controller: _isController,
                focusNode: focusNode,
                style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
                decoration: decorationTextField(
                    hintText:
                        isRequired ? 'campo obligatorio' : 'campo opcional',
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
                            ))),
                onFieldSubmitted: (value) => onFieldSubmitted(),
                onChanged: (value) {
                  print('VALUES AUTOCOMPELTe: $value');
                  // Validar el valor al enviar el formulario
                  if (lisData.any((producto) => getField(producto) == value)) {
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
                      lisData.any((producto) => getField(producto) == value)) {
                    TextToSpeechService().speak(
                        'El valor ingresado ya existe. Ingrese un valor diferente.');
                    controller.clear();
                    _isController.clear();
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
            ),
          );
        },
      );
    });
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

    // Convierte el contenido del controlador en una lista de opciones seleccionadas
    List<String> _getSelectedOptions() {
      return controller.text.isEmpty ? [] : controller.text.split(', ');
    }

    // Actualiza el controlador con las opciones seleccionadas
    void _updateController(List<String> options) {
      controller.text = options.join(', ');
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
                decoration: decorationTextField(
                    hintText:
                        isRequired ? 'campo obligatorio' : 'campo opcional',
                    // labelText: '$labelText',
                    suffixIcon: Icon(Icons.arrow_drop_down),
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
                  await jsonData.loadJsonData(key: '$key', subKey: '$subKey');
                  toggleDropdown(
                      subKey); // Muestra el dropdown al cargar las opciones
                }, // Cierra todos los dropdowns al hacer clic en el texto
              )),
          if (showDropdowns[subKey]!)
            ScrollWeb(
              child: MultiSelectChipDisplay<String>(
                scroll: true,
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
                decoration: decorationTextField(
                    hintText: 'campo obligatorio',
                    // labelText: '$subKey',
                    suffixIcon: Icon(Icons.arrow_drop_down),
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
                  return validarCampoObligatorio(value);
                },
                onTap: () async {
                  await jsonData.loadJsonData(key: '$key', subKey: '$subKey');
                  toggleDropdown(subKey);
                },
              )),
          if (showDropdowns[subKey]!)
            ScrollWeb(
              child: MultiSelectChipDisplay<String>(
                items:
                    jsonData.options.map((e) => MultiSelectItem(e, e)).toList(),
                scroll: true,
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

  // **************************************** Avanzado atucomplete filter list ******************************************************

  Widget autocomleteSearchList(
      {required bool Function(dynamic producto, String query) getField,
      required String Function(dynamic producto) getName,
      required String Function(dynamic producto) getQr,
      required String Function(dynamic producto) getId,
      required List<dynamic> listaProducto}) {
    final qrData = Provider.of<QrLectorProvider>(context, listen: false);

    return Autocomplete<Object>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return Iterable<
              Object>.empty(); // Aquí no usamos 'const' por el tipo genérico
        }

        final query = textEditingValue.text.toLowerCase();

        // Filtra los productos según el texto ingresado en cualquier campo relevante
        return listaProducto
            .where((producto) => getField(producto, query))
            .cast<Object>();
      },
      displayStringForOption: (producto) =>
          getName(producto), // Muestra solo el nombre

      fieldViewBuilder: (context, _isController, focusNode, onFieldSubmitted) {
        // _controller = controller; // Asigna directamente al controlador
        return TextFormField(
          controller: _isController,
          focusNode: focusNode,
          style: TextStyle(fontSize: 13, fontFamily: 'Quicksand'),
          decoration: decorationTextField(
              hintText: 'Buscar producto',
              labelText: 'Buscar producto',
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
        return Container(
          width: 300,
          child: ScrollWeb(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8),
              children: options.map((producto) {
                return Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: ListTile(
                    leading: Icon(Icons.folder_open_outlined),
                    title: Text('${getName(producto)}'),
                    subtitle:
                        Text('id: ${getId(producto)} - QR: ${getQr(producto)}'),
                    onTap: () => onSelected(producto),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
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
                  // Dividir el texto y asegurarte de que hay al menos dos partes
                  List<String> parts = controller.text.split('=');
                  if (parts.length > 1) {
                    return parts[1].trim() == value
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
             Row(
            children: [
              controller.text.isEmpty
                  ? SizedBox()
                  : IconButton(
                      onPressed: () async {
                        controller.clear();
                        await jsonData.loadJsonData(
                            key: '$key', subKey: '$subKey');
                        toggleDropdown(subKey); // Oculta el dropdown
                      },
                      icon: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      )),
              Container(
                decoration: AssetDecorationBox().decorationBox(color: Colors.white),
                child: P3Text(
                  text: '  ${controller.text}  ',
                  height: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
