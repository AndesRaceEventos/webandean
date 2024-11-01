
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files/assets_imge.dart';
import 'package:webandean/utils/formulario/custom_steeper.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPageProductosApp extends StatefulWidget {
  const EditPageProductosApp({
    super.key,
    this.e,
    required this.onSave, // Define el parámetro de función
  });
  final TProductosAppModel? e; //final TProductosAppModel? e;
  final Function onSave; // Aquí defines el parámetro de función
  @override
  State<EditPageProductosApp> createState() => _EditPageProductosAppState();
}

class _EditPageProductosAppState extends State<EditPageProductosApp> {
  

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();

  final TextEditingController _categoriaComprasController = TextEditingController();
  final TextEditingController _categoriaInventarioController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _proveedorController = TextEditingController();
  final TextEditingController _rotacionController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  //List<TProductosAppModel>? listaMarcas;
  final TextEditingController _intUndMedidaController = TextEditingController();
  final TextEditingController _outUndMedidaController = TextEditingController();
  final TextEditingController _intPrecioCompraController = TextEditingController();
  final TextEditingController _outPrecioDistribucionController = TextEditingController();
  final TextEditingController _idMenuController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _fechaVencientoController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _demandaController = TextEditingController();
  final TextEditingController _condicionAlmacenamientoController = TextEditingController();
  final TextEditingController _formatoController = TextEditingController();
  final TextEditingController _tipoPrecioController = TextEditingController();
  final TextEditingController _durabilidadController = TextEditingController();
  final TextEditingController _proveeduriaController = TextEditingController();
  final TextEditingController _presentacionVisualnController = TextEditingController();
  final TextEditingController _embaseAmbientalController = TextEditingController();
  final TextEditingController _responsabilidadAmbientalController = TextEditingController();
  //  List<String>? imagen;
  final TextEditingController _cantidadEnStockController = TextEditingController();
  final TextEditingController _cantidadCriticaController = TextEditingController();
  final TextEditingController _cantidadOptimaController = TextEditingController();
  final TextEditingController _cantidadMaximaController = TextEditingController();
  final TextEditingController _cantidadMalogradosController = TextEditingController();
  final TextEditingController _observacionController = TextEditingController();
  final TextEditingController _monedaController = TextEditingController();

  var title = 'Crear nuevo';
  // late Map<String, bool> _showDropdowns;
  @override
  void initState() {
    super.initState();
    //  _showDropdowns = Provider.of<TProductosAppProvider>(context, listen: false).showDropdowns;

    if (widget.e != null) {
      final e =  widget.e!;
      title = e.nombre;//TITULO FORMULARIO 
      _idController.text = e.id.toString();
      _qrController.text = e.qr;
      _activeController.text = e.active.toString();
      _categoriaComprasController.text = e.categoriaCompras;
      _categoriaInventarioController.text = e.categoriaInventario;
      _ubicacionController.text = e.ubicacion;
      _proveedorController.text = e.proveedor.toString();
      _rotacionController.text = e.rotacion.toString();
      _nombreController.text = e.nombre;
      _intUndMedidaController.text = e.intUndMedida;
      _outUndMedidaController.text = e.outUndMedida;
      _intPrecioCompraController.text = e.intPrecioCompra.toString();
      _outPrecioDistribucionController.text = e.outPrecioDistribucion.toString();
      _idMenuController.text = e.idMenu.toString();
      _tipoController.text = e.tipo.toString();
      _fechaVencientoController.text = e.fechaVencimiento.toString();
      _estadoController.text = widget.e!.estado.toString();
      _demandaController.text = e.demanda.toString();
      _condicionAlmacenamientoController.text = e.condicionAlmacenamiento.toString();
      _formatoController.text = e.formato.toString();
      _tipoPrecioController.text = e.tipoPrecio.toString();
      _durabilidadController.text = e.durabilidad.toString();
      _proveeduriaController.text = e.proveeduria.toString();
      _presentacionVisualnController.text = e.presentacionVisual.toString();
      _embaseAmbientalController.text = e.embaseAmbiental.toString();
      _responsabilidadAmbientalController.text = e.responsabilidadAmbiental.toString();
      _cantidadEnStockController.text = e.cantidadEnStock.toString();
      _cantidadCriticaController.text = e.cantidadCritica.toString();
      _cantidadOptimaController.text = e.cantidadOptima.toString();
      _cantidadMaximaController.text = e.cantidadMaxima.toString();
      _cantidadMalogradosController.text = e.cantidadMalogrados.toString();
      _observacionController.text = e.observacion;
      _monedaController.text = e.moneda;

    }
  }



  // Mapa para manejar la visibilidad de los dropdowns
  // Map<String, bool> _showDropdowns = {
  //   'categoria_compras': false,
  //   'categoria_inventario': false,
  //   'ubicacion': false,
  //   'moneda': false,
  //   'PROVEEDOR': false,

  //   'tipo':false,
  //   'rotacion': false, 
  //   'estado': false,
  //   'demanda': false,
  //   'condicion_almacenamiento': false,
  //   'formato': false,
  //   'tipo_precio': false,
  //   'durabilidad': false,
  //   'proveeduria': false,
  //   'presentacion_visual': false,
  //   'embase_ambiental': false,
  //   'responsabilidad_ambiental': false,
  // };

  // void _toggleDropdown(String key) {

  //   _closeAllDropdowns();
  //   setState(() {
  //     // Cerrar todos los dropdowns primero
  //     _showDropdowns.forEach((k, v) {
  //       _showDropdowns[k] = false;
  //     });
  //     // Luego abrir el dropdown seleccionado
  //     _showDropdowns[key] = true;
  //     // _showDropdowns[key] = _showDropdowns[key]!;
  //   });
  // }

  // void _closeAllDropdowns() {
  //   setState(() {
  //     _showDropdowns.updateAll((key, value) => false);
  //   });
  // }
  


 
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<TProductosAppProvider>(context);
    bool isavingProvider = dataProvider.isSyncing;
    final listaProducto = dataProvider.listProductos;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        dataProvider.closeAllDropdowns(); // Muestra el dropdown
      },
      child: Container(
        child: ScrollWeb(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,// Importante para que el autocomplete funcione 
            child: Column(
              mainAxisSize: MainAxisSize.min, // Asegúrate de que la Column use el tamaño mínimo
              children: [
                FormWidgets(context).switchAdaptive( controller: _activeController, onSelected: (value) => setState(() => _activeController.text = value.toString())),
                H2Text( text: title.toUpperCase(),height: 2),
                if(widget.e != null)
                ...[
                  P3Text(text: _idController.text, selectable: true, maxLines: 1),
                  P3Text(text: _qrController.text,  selectable: true, maxLines: 1),
                ],

               Expanded(
                  child: CustomStepper(
                  totalSteps: 4,
                  options: ['Inicio', 'Valores','Etiquetas', 'Extras'],
                  stepContents: [
                    Column(
                      children: [
                        
                            FormWidgets(context).autocompleteFormWithWarning(
                            labelText: 'Serie',
                            controller: _qrController,
                            lisData: listaProducto,
                            isRequired: true,
                            getField: (field) {
                              TProductosAppModel producto = field;
                              return producto.qr.toString();
                            }
                          ),

                          FormWidgets(context).textFormText(
                              controller: _nombreController,
                              labelText: 'nombre',
                              isRequired: true),

                           FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'categoria_compras',
                                isRequired: true,
                                controller: _categoriaComprasController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                            FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'categoria_inventario',
                                isRequired: true,
                                controller: _categoriaInventarioController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                            FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'ubicacion',
                                isRequired: true,
                                controller: _ubicacionController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                            FormWidgets(context).multiSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'PROVEEDOR',
                                controller: _proveedorController,
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                              ),
                           Text('marca como Lista de String')
                          
                              
                           
                      ],
                    ),
                    Column(
                      children: [
                         FormWidgets(context).singleSelectDropdown(
                              key: 'almacen_productos',
                              subKey: 'moneda',
                              isRequired: true,
                              controller: _monedaController, 
                              showDropdowns: dataProvider.showDropdowns,
                              toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                              ),
                       
                        Align(alignment: Alignment.topLeft,child: P3Text(text: 'Compra: '.toUpperCase())),
                        Row(
                          children: [
                               Expanded(
                                flex: 2,
                                 child: FormWidgets(context).autocompleteForm(
                                    labelText: ' Und Medida',// Compra', 
                                    controller: _intUndMedidaController, 
                                    lisData: listaProducto, 
                                    getField: (field) {
                                  TProductosAppModel  producto = field;
                                  return producto.intUndMedida.toString();
                                                               }),
                               ),
                               SizedBox(width: 5),
                              Expanded(
                                flex: 1,
                                child: FormWidgets(context).textFormDecimal(
                                      controller: _intPrecioCompraController, 
                                      labelText: 'Precio',// Compra ',
                                      suffixIcon: P3Text(text:'${_monedaController.text}'),
                                      ),
                              ),  
                          ],
                        ),
                         Align(alignment: Alignment.topLeft,child: P3Text(text: 'Distribución: '.toUpperCase())),
                         Row(
                          children: [
                           Expanded(
                            flex: 2,
                             child:   FormWidgets(context).autocompleteForm(
                                labelText: ' Und Medida',//'Distribucion', 
                                controller: _outUndMedidaController, 
                                lisData: listaProducto, 
                                getField: (field) {
                                  TProductosAppModel  producto = field;
                                  return producto.outUndMedida.toString();
                                }), 
                           ),
                          SizedBox(width: 5),
                          Expanded(
                            flex: 1,
                            child:  FormWidgets(context).textFormDecimal(
                              controller: _outPrecioDistribucionController, 
                              labelText:  'Precio',// Distribucion ',
                              suffixIcon: P3Text(text:'${_monedaController.text}'),
                              ),
                          ),  
                          ],
                        ),
                    
                        FormWidgets(context).textFormfecha(
                          controller: _fechaVencientoController, 
                          labelText: 'fecha_vencimiento', 
                          onDateSelected: (date) => setState(() {
                            _fechaVencientoController.text = date.toString();
                          })),
                        FormWidgets(context).textFormDecimal(
                              controller: _cantidadEnStockController, 
                              labelText:  'Stock',
                              suffixIcon: Icon(Icons.numbers_outlined),
                              ),
                         FormWidgets(context).textFormDecimal(
                              controller: _cantidadMalogradosController, 
                              labelText:  'Mermas',
                              suffixIcon: Icon(Icons.numbers_outlined),
                              ),
                         H3Text(text: 'CANTIDADES'.toUpperCase(), height: 2),
                        Row(
                          children: [
                           Expanded(
                            flex: 1,
                             child:    FormWidgets(context).textFormDecimal(
                              controller: _cantidadCriticaController, 
                              labelText:  '# critica',
                              ),
                           ),
                          SizedBox(width: 2),
                          Expanded(
                            flex: 1,
                             child:    FormWidgets(context).textFormDecimal(
                              controller: _cantidadOptimaController, 
                              labelText:  '# optima',
                              ),
                           ),
                          SizedBox(width: 2),
                          Expanded(
                            flex: 1,
                            child:  FormWidgets(context).textFormDecimal(
                              controller: _cantidadMaximaController, 
                              labelText:  '# maxima',
                              ),
                          ),  
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'tipo',
                                controller: _tipoController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                         FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'rotacion',
                                controller: _rotacionController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                        FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'estado',
                                controller: _estadoController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                         FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'demanda',
                                controller: _demandaController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                          FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'condicion_almacenamiento',
                                controller: _condicionAlmacenamientoController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                           FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'formato',
                                controller: _formatoController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                          FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'tipo_precio',
                                controller: _tipoPrecioController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                          FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'durabilidad',
                                controller: _durabilidadController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                           FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'proveeduria',
                                controller: _proveeduriaController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                          FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'presentacion_visual',
                                controller: _presentacionVisualnController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                          FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'embase_ambiental',
                                controller: _embaseAmbientalController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                           FormWidgets(context).singleSelectDropdown(
                                key: 'almacen_productos',
                                subKey: 'responsabilidad_ambiental',
                                controller: _responsabilidadAmbientalController, 
                                showDropdowns: dataProvider.showDropdowns,
                                toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
                                ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(AppImages.placeholder300),
                     FormWidgets(context).textFormText(
                              controller: _observacionController,
                              labelText: 'observación',
                              isAllLines: true),
                        FormWidgets(context).textFormText(
                        controller: _idMenuController, labelText: 'IDMenu'),
                      H2Text(text: 'Lista de marcas',height: 2),
                        ...List.generate(10, (index){
                          return ListTile(
                            leading: Icon(Icons.checklist_rounded),
                            title: Text('Item ${index + 1}'),
                            trailing: Icon(Icons.remove_circle_outline_outlined, size: 15,color: Colors.red,),
                          );
                        })
                      ],
                    ),
                    
                  ], 
                  )
                ),
                  TextButton(
                  onPressed: isavingProvider
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.e != null) {
                              editarDatos();
                              _formKey.currentState!.save();
                            } else {
                              enviarDatos();
                              _formKey.currentState!.save();
                            }
                          } else {
                            // Mostrar un SnackBar indicando el primer campo con error
                            FormWidgets(context)
                                .completeForm( title: title);
                          }
                        },
                  child: Container(
                      decoration: AssetDecorationBox().decorationBox(),
                      height: 40,
                      child: Center(
                          child: isavingProvider
                              ? AssetsCircularProgreesIndicator()
                              : const H3Text(
                                  text: 'Guardar',
                                  color: Colors.white,
                                ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  


  void _cleanAll() {
  _idController.clear();
  _qrController.clear();
  _activeController.clear();
  _categoriaComprasController.clear();
  _categoriaInventarioController.clear();
  _ubicacionController.clear();
  _proveedorController.clear();
  _rotacionController.clear();
  _nombreController.clear();
  _intUndMedidaController.clear();
  _outUndMedidaController.clear();
  _intPrecioCompraController.clear();
  _outPrecioDistribucionController.clear();
  _idMenuController.clear();
  _tipoController.clear();
  _fechaVencientoController.clear();
  _estadoController.clear();
  _demandaController.clear();
  _condicionAlmacenamientoController.clear();
  _formatoController.clear();
  _tipoPrecioController.clear();
  _durabilidadController.clear();
  _proveeduriaController.clear();
  _presentacionVisualnController.clear();
  _embaseAmbientalController.clear();
  _responsabilidadAmbientalController.clear();
  _cantidadEnStockController.clear();
  _cantidadCriticaController.clear();
  _cantidadOptimaController.clear();
  _cantidadMaximaController.clear();
  _cantidadMalogradosController.clear();
  _observacionController.clear();
  _monedaController.clear();
}

  Future<void> editarDatos() async {
    // _categoriaController.text = selectCategoria ?? '';
    // _ubicacionController.text = selectUbicacion ?? '';
    // _monedaController.text = selectmoneda ?? '';
    // await context.read<TProductosAppProvider>().updateProductosProvider(
    //       context: context,
    //       id: widget.e!.id,
    //       nombre: _nombreController.text,
    //       idCategoria: _categoriaController.text,
    //       idUbicacion: _ubicacionController.text,
    //       // imagen: imagen,
    //       marcaProducto: _marcaController.text,
    //       idProveedor: _proveedorController.text,
    //       unidMedida: _unDeMedController.text,
    //       descripcion: _descripcionController.text,
    //       fechaVencimiento: DateTime.parse(_fechaVenciController.text),
    //       estado: parseBool(_estadoController.text),
    //       entrada: convertirTextoADouble(
    //               _entradaController.text),
    //       //  (widget.e!.entrada ?? 0) +
    //       //     convertirTextoADouble(
    //       //         _entradaController.text), // Acumulación de entrada
    //       salida:convertirTextoADouble(_salidaController.text),
    //       //  (widget.e!.salida ?? 0) +
    //       //     convertirTextoADouble(_salidaController.text),
    //       moneda: _monedaController.text,
    //       precioUnd: convertirTextoADouble(_precioController.text),
    //     );
    _cleanAll();
    AssetAlertDialogPlatform.show(
        context: context,
        message: '✅ Registro editado correctamente.',
        title: 'Editar Registro');
    TextToSpeechService().speak('Registro editado correctamente.');
    // Llamar a la función pasada como parámetro
    if (mounted) {
      widget.onSave();
    }
  }

  Future<void> enviarDatos() async {
    // await context.read<TProductosAppProvider>().postProductosProvider(
    //       context: context,
    //       //  id: id,
    //       nombreProducto: _nombreController.text,
    //       idCategoria: _categoriaController.text,
    //       idUbicacion: _ubicacionController.text,
    //       // imagen: imagen,
    //       marcaProducto: _marcaController.text,
    //       idProveedor: _proveedorController.text,
    //       unidMedida: _unDeMedController.text,
    //       descripcion: _descripcionController.text,
    //       fechaVencimiento: parseDateTime(_fechaVenciController.text),
    //       estado: parseBool(_estadoController.text),
    //       entrada: convertirTextoADouble(_entradaController.text),
    //       stock: convertirTextoADouble(_entradaController.text),
    //       moneda: _monedaController.text,
    //       precioUnd: convertirTextoADouble(_precioController.text),
    //     );
    _cleanAll();
    AssetAlertDialogPlatform.show(
        context: context,
        message: '✅ Se ha añadido un nuevo registro.',
        title: 'Nuevo Registro');
    TextToSpeechService().speak('Se ha añadido un nuevo registro.');
    // Llamar a la función pasada como parámetro
    if (mounted) {
      widget.onSave();
    }
  }


}
