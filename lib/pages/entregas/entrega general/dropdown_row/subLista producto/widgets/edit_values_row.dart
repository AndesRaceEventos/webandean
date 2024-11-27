
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

//SOLO FUNCIONA PARA 3 CAMPOS active, observacion, cantidadEnStock


class ValueBoolCompraEdit extends StatefulWidget {
  const ValueBoolCompraEdit({
    super.key,
    required this.valueTable, // Es el valor inicial del campo (booleano)
    required this.productoRow, // El elemento de Sublista de productos
    required this.subListDPadre, // Registro que contiene la sublista
    required this.color
  });

  final Object? valueTable; // Booleano: true o false
  // final TProductosAppModel productoRow;
  // final TEntregasModel data;
  final dynamic productoRow;
   final List<dynamic> subListDPadre;//Sublista de padre 
  final Color color;

  @override
  State<ValueBoolCompraEdit> createState() => _ValueBoolCompraEditState();
}
class _ValueBoolCompraEditState extends State<ValueBoolCompraEdit> {
  @override
  Widget build(BuildContext context) {
    // Obtén el valor actual del modelo cada vez que se construya
    final currentValue = widget.productoRow.active;

    return GestureDetector(
      onTap: () {
        final newValue = !currentValue;
        actualizarCompra(newValue);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: currentValue ? Colors.red.shade50 : widget.color,
        child: Center(
          child: P2Text(
            text: currentValue ? 'COMPRAR' : 'NO COMPRAR',
            fontSize: 11,
            textAlign: TextAlign.center,
            height: 2,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  void actualizarCompra(bool value) {
    // Actualiza directamente el modelo
    setState(() {
      widget.productoRow.active = value;

      // Usa un identificador único para actualizar el producto en la lista
      final index = widget.subListDPadre.indexWhere(
        (p) => p == widget.productoRow, // Cambia `id` por tu identificador único
      );

      if (index != null && index != -1) {
        widget.subListDPadre[index] = widget.productoRow;
      }
      print('Producto actualizado: ${widget.productoRow.active}');
    });
  }
}


class ValueObservacionEdit extends StatefulWidget {
  const ValueObservacionEdit({
    super.key,
    required this.valueTable, // Es el valor del campo o tipo de dato
    required this.productoRow, // El elemento de Sublista de productos  
    required this.subListDPadre, // Es el registro que contiene la sublista 
  });
  
  final Object? valueTable;
  final dynamic productoRow;
   final List<dynamic> subListDPadre;//Sublista de padre 

  @override
  State<ValueObservacionEdit> createState() => _ValueObservacionEditState();
}

class _ValueObservacionEditState extends State<ValueObservacionEdit> {
  bool isEditable = false; // Nuevo valor para controlar si el campo es editable
  bool isModifiTemporal = false; // Muestra temporalmente que se ha modificado 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Hacer que solo sea editable si valueTable es observacion
          if (widget.valueTable == widget.productoRow.observacion) {
            isEditable = true;  // Cambiar a true solo si el campo es 'observacion'
            isModifiTemporal = true;
          }
        });
      },
      child: Container(
        child: isEditable
            ? TextFormField(
                initialValue: widget.productoRow.observacion ?? '', // Valor inicial dinámico
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, height: 2.2),
                decoration: AssetDecorationTextField.decorationFormPDfView(
                  fillColor: Colors.yellow.withOpacity(0.5),
                ),
                onFieldSubmitted: (value) {
                  actualizarStock(value);
                  setState(() {
                    isEditable = false; // Finalizar edición
                  });
                },
              )
            : Padding(
                padding: EdgeInsets.only(top: 0),
                child: P2Text(
                  text: widget.valueTable == widget.productoRow.observacion
                      ? widget.productoRow.observacion.toString()
                      : widget.valueTable.toString(),
                  fontSize: isModifiTemporal ? 12 : 11,
                  textAlign: TextAlign.center,
                  height: 2.5,
                   maxLines: 1,
                  fontWeight: isModifiTemporal ? FontWeight.bold : FontWeight.w500,
                  color: isModifiTemporal ? Colors.blue.shade900 : Colors.black,
                ),
              ),
      ),
    );
  }

  void actualizarStock(String value) {
    // Asignar la observación al producto
    widget.productoRow.observacion = value;

    setState(() {
      // Buscar el índice del producto que está siendo editado en la lista
      final index = widget.subListDPadre.indexWhere(
        (p) => p == widget.productoRow, // Comparar por referencia (mismo objeto)
      );
      // Si el producto encontrado es el mismo
      if (index != null && index != -1) {
        // Actualizar solo el producto en ese índice
        widget.subListDPadre[index] = widget.productoRow;
      }
      print('Índice actualizado: $index');
      print('Observación actualizada: ${widget.productoRow.observacion}');
    });
  }
}



class ValueNumberEdit extends StatefulWidget {
  const ValueNumberEdit({
    super.key,
    required this.valueTable, // Es el valor del campo o tipo de dato
    required this.productoRow, // El elemento de Sublista de productos  
    required this.subListDPadre, // Es el registro que contiene la sublista 
  });
  
  final Object? valueTable;
  final dynamic productoRow;
   final List<dynamic> subListDPadre;//Sublista de padre 

  @override
  State<ValueNumberEdit> createState() => _ValueNumberEditState();
}

class _ValueNumberEditState extends State<ValueNumberEdit> {
  bool isEditable = false; // Controla si el campo es editable
  bool isModifiTemporal = false; // Muestra temporalmente que se ha modificado 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditable = true; // Cambiar a editable
          isModifiTemporal = true;
        });
      },
      child: Container(
        child: isEditable
            ? TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 2.2, ),
                decoration: AssetDecorationTextField.decorationFormPDfView(
                  fillColor: Colors.yellow.withOpacity(.5),
                ),
                initialValue: widget.productoRow.cantidadEnStock?.toString() ?? '0',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+(\.\d{0,2})?$'), // Solo permite números con hasta dos decimales.
                  ),
                ],
                onChanged: (value) {
                  actualizarStock(value);
                },
                onFieldSubmitted: (value) {
                  actualizarStock(value);
                  setState(() {
                    isEditable = false; // Finalizar edición
                  });
                },
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: P2Text(
                  text: widget.productoRow.cantidadEnStock?.toString() ?? '0',
                  fontSize: isModifiTemporal ? 12 : 11,
                  textAlign: TextAlign.center,
                  height: 2.5,
                   maxLines: 1,
                  fontWeight: isModifiTemporal ? FontWeight.bold : FontWeight.w500,
                  color: isModifiTemporal ? Colors.blue.shade900 : Colors.black,
                ),
              ),
      ),
    );
  }

  void actualizarStock(String value) {
    // Verificar si el campo está vacío y asignar 0
    double newValue = value.isEmpty ? 0.0 : double.tryParse(value) ?? 0.0;
    widget.productoRow.cantidadEnStock = newValue;

    setState(() {
      // Buscar el índice del producto que está siendo editado en la lista
      final index = widget.subListDPadre.indexWhere(
        (p) => p == widget.productoRow, // Comparar por referencia (mismo objeto)
      );
      // Si el producto encontrado es el mismo
      if (index != null && index != -1) {
        // Actualizar solo el producto en ese índice
        widget.subListDPadre[index] = widget.productoRow;
      }
      print('Índice actualizado: $index');
      print('Nuevo stock: ${widget.productoRow.cantidadEnStock}');
    });
  }
}




