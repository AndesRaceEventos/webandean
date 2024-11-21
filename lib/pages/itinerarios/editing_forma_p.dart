
import 'package:webandean/utils/subList%20Objet/editing_form_sublist.dart';
import 'package:webandean/utils/Files%20%20Selected/imagen/movil_selected_image.dart';
import 'package:webandean/utils/Files%20%20Selected/imagen/web_selected_image.dart';
import 'package:webandean/utils/Files%20%20Selected/pdf/movil_selected_pdf.dart';
import 'package:webandean/utils/Files%20%20Selected/pdf/reorder_PDFfile_form.dart';
import 'package:webandean/utils/Files%20%20Selected/pdf/web_selected_pdf.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';
import 'package:webandean/utils/formulario/custom_steeper.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/Files%20%20Selected/imagen/reorder_imagefile_form.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/provider/cache/files/files_procesisng.dart';


import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/model/producto/model_producto.dart';

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
    // FILES  List<String>? imagen;
  final TextEditingController _imagenController = TextEditingController();
  final TextEditingController _pdfController = TextEditingController();
  //MARCAS CONTROLLELR lista de un modelo //List<TProductosAppModel>? listaMarcas;
  final TextEditingController _marcasController = TextEditingController();
  //ID RELATIONS 
  final TextEditingController _idMenuController = TextEditingController();
  //General 
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();

  final TextEditingController _categoriaComprasController = TextEditingController();
  final TextEditingController _categoriaInventarioController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _proveedorController = TextEditingController();
  final TextEditingController _rotacionController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _intUndMedidaController = TextEditingController();
  final TextEditingController _outUndMedidaController = TextEditingController();
  final TextEditingController _intPrecioCompraController = TextEditingController();
  final TextEditingController _outPrecioDistribucionController = TextEditingController();
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
  final TextEditingController _cantidadEnStockController = TextEditingController();
  final TextEditingController _cantidadCriticaController = TextEditingController();
  final TextEditingController _cantidadOptimaController = TextEditingController();
  final TextEditingController _cantidadMaximaController = TextEditingController();
  final TextEditingController _cantidadMalogradosController = TextEditingController();
  final TextEditingController _observacionController = TextEditingController();
  final TextEditingController _monedaController = TextEditingController();

  var title = 'Crear nuevo';

  @override
  void initState() {
    super.initState();
    if (widget.e != null) {
      final e = widget.e!;
      //FILES 
      _imagenController.text = e.imagen!.join(',');
      _pdfController.text = e.pdf!.join(',');
      //LISTAS 
     // Convierte la lista a String personalizado y lo asigna al TextController
     _marcasController.text = FormatValues.listaToString<TProductosAppModel>(
                              e.listaMarcas, 
                              TProductosAppModel.fromJson, 
                              (TProductosAppModel marca) => marca.toJson()
                            );
      // TProductosAppModel.listaMarcasToString(e.listaMarcas);
      //GENRICO 
      title = e.nombre; //TITULO FORMULARIO
      _idController.text = e.id.toString();
      _qrController.text = e.qr;
      _activeController.text = e.active.toString();
      _categoriaComprasController.text = e.categoriaCompras;
      _categoriaInventarioController.text = e.categoriaInventario;
      _ubicacionController.text = e.ubicacion;
      _proveedorController.text = e.proveedor.join(', '); // Une los proveedores en una cadena: List<String> a String yevitar el formato [[PLAZA VEA, SAN PEDRO SILVIA]]
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
            autovalidateMode: AutovalidateMode.onUnfocus, // Importante para que el autocomplete funcione
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: CustomStepper(
                      totalSteps: 5,
                      options: [ 'Inicio', 'Valores','Etiquetas', 'Extras', 'files'],
                      stepContents: [
                        _steeper_1(context, listaProducto, dataProvider),
                        _steeper_2(context, dataProvider, listaProducto),
                        _steeper_3(context, dataProvider, listaProducto),
                        _steeper_4(context, dataProvider, listaProducto),
                        _steeper_5(context, dataProvider, listaProducto, widget.e),
                      ],
                    )),
                    AppSaveButonForm(
                      isLoading: isavingProvider,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          saveForm();
                          _formKey.currentState!.save();
                        } else {
                          // Mostrar un SnackBar indicando el primer campo con error
                          FormWidgets(context).completeForm(title: title);
                        }
                      },
                    ),
                  ],
                ),
                H2Text(text: title.toUpperCase(), height: 2, color: Colors.green.shade700),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _steeper_1( BuildContext context, List<TProductosAppModel> listaProducto, TProductosAppProvider dataProvider) {
    return Column(
      children: [
        if (widget.e != null) ...[
          P3Text(text: _idController.text, selectable: true, maxLines: 1),
          P3Text(text: _qrController.text, selectable: true, maxLines: 1),
        ],
        FormWidgets(context).switchAdaptive(
                    controller: _activeController,
                    onSelected: (value) => setState(() => _activeController.text = value.toString())),
        FormWidgets(context).autocompleteFormWithWarning(
          labelText: 'Serie',
          controller: _qrController,
          valueComparate: widget.e?.qr ??'', //valor a comprar para deterninar si existe o no
          lisData: listaProducto,
          isRequired: true,
          getField: (field) {
            TProductosAppModel producto = field;
            return producto.qr.toString();
          },
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
      ],
    );
  }

  Column _steeper_2(BuildContext context, TProductosAppProvider dataProvider, List<TProductosAppModel> listaProducto) {
    return Column(
      children: [
        FormWidgets(context).singleSelectDropdown(
          key: 'almacen_productos',
          subKey: 'moneda',
          isRequired: true,
          controller: _monedaController,
          showDropdowns: dataProvider.showDropdowns,
          toggleDropdown: (subKey) => dataProvider.toggleDropdown(subKey),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: P3Text(text: 'Compra: '.toUpperCase())),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: FormWidgets(context).autocompleteForm(
                  labelText: ' Und Medida', // Compra',
                  controller: _intUndMedidaController,
                  lisData: listaProducto,
                  getField: (field) {
                    TProductosAppModel producto = field;
                    return producto.intUndMedida.toString();
                  }),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: FormWidgets(context).textFormDecimal(
                controller: _intPrecioCompraController,
                labelText: 'Precio (${_monedaController.text})', // Compra ',
                // suffixIcon: P3Text(text:'${_monedaController.text}'),
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.topLeft,
            child: P3Text(text: 'Distribución: '.toUpperCase())),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: FormWidgets(context).autocompleteForm(
                  labelText: ' Und Medida', //'Distribucion',
                  controller: _outUndMedidaController,
                  lisData: listaProducto,
                  getField: (field) {
                    TProductosAppModel producto = field;
                    return producto.outUndMedida.toString();
                  }),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: FormWidgets(context).textFormDecimal(
                controller: _outPrecioDistribucionController,
                labelText:
                    'Precio (${_monedaController.text})', // Distribucion ',
                // suffixIcon: P3Text(text:'${_monedaController.text}'),
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
          labelText: 'Stock',
          suffixIcon: Icon(Icons.numbers_outlined),
        ),
        FormWidgets(context).textFormDecimal(
          controller: _cantidadMalogradosController,
          labelText: 'Mermas',
          suffixIcon: Icon(Icons.numbers_outlined),
        ),
        H3Text(text: 'CANTIDADES'.toUpperCase(), height: 2),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: FormWidgets(context).textFormDecimal(
                controller: _cantidadCriticaController,
                labelText: '# critica',
              ),
            ),
            SizedBox(width: 2),
            Expanded(
              flex: 1,
              child: FormWidgets(context).textFormDecimal(
                controller: _cantidadOptimaController,
                labelText: '# optima',
              ),
            ),
            SizedBox(width: 2),
            Expanded(
              flex: 1,
              child: FormWidgets(context).textFormDecimal(
                controller: _cantidadMaximaController,
                labelText: '# maxima',
              ),
            ),
          ],
        ),
        FormWidgets(context).textFormText(
            controller: _observacionController,
            labelText: 'observación',
            isAllLines: true),
      ],
    );
  }

  Column _steeper_3(BuildContext context, TProductosAppProvider dataProvider, List<TProductosAppModel> listaProducto) {
    return Column(
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
    );
  }

  Column _steeper_4(BuildContext context, TProductosAppProvider dataProvider, List<TProductosAppModel> listaProducto) {
    return Column(
      children: [
        FormWidgets(context).autocomplete_IDRelationForm(
          labelText: 'IDMenu',
          controller: _idMenuController, 
          getField: (producto, query) {
            return producto.nombre.toLowerCase().contains(query) ||
                   producto.qr.toLowerCase().contains(query) ||
                   producto.id.toLowerCase().contains(query);
          }, 
          getName: (producto) => producto.nombre,
          getQr: (producto) => producto.qr,
          getId: (producto) => producto.id,
          listaProducto: listaProducto),//lista a buscar

        FormWidgets(context).autocomleteSearchListForm(
              title: 'Marcas Productos',
              controller: _marcasController,
              listaProducto: listaProducto,//lista de Objeto para este ejmplo se utilizo productos 
              getName: (producto) => producto.nombre,
              getQr: (producto) => producto.qr,
              getId: (producto) => producto.id,
              getField: (producto, query) {
                return producto.nombre.toLowerCase().contains(query) ||
                       producto.qr.toLowerCase().contains(query) ||
                       producto.id.toLowerCase().contains(query);
              }, 
               toJson: (producto) => producto.toJson(), // Convierte el producto a JSON
               fromJson: (json) => TProductosAppModel.fromJson(json), // Convierte JSON a OBJETO  ProductoModel
            ),
      //  H2Text(text: 'Lista de marcas ${_marcasController.text.length}', height: 2),

      //  SubListWidget(controller: _marcasController),
      Container(
        height: MediaQuery.of(context).size.height*.46,
         child: SubListWidget(
          controller: _marcasController, 
          fromJson: TProductosAppModel.fromJson,
          toJson: (value) => value.toJson(),
          getId: (producto) => producto.id,
          getName: (producto) => producto.nombre,
          getQr: (producto) => producto.qr,
          routewidget: Container(),
         ),
       ),
       
     
        
      ],
    );
  }


  Widget _steeper_5(BuildContext context, TProductosAppProvider dataProvider, List<TProductosAppModel> listaProducto, TProductosAppModel? value) {
   
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //IMAGENES  
        AppReorderImageForm(
          imagenE:value != null ? value.imagen : '',
          value: value, //TProductosAppModel? value
          imagenController: _imagenController,
        ),  
        FilesImagesSelectedMovil(isListImage: true),
        // FilesImagesSelectedWeb(isListImage: true),
        //PDF 
        AppReorderPDFForm(
          pdfE: value != null ? value.pdf : '', 
          pdfController: _pdfController,
          value: value),
        // FilesPDFSelectedWeb(isListImage: true),
        FilesPDFSelectedMovil(isListPDf:true),
        
      ],
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

  Future<void> saveForm() async {
    final filesdata = Provider.of<FilesProvider>(context, listen: false);
    final imagenes = filesdata.imagenes;
    final pdfs = filesdata.pdfs;
    print(_idController.text);
    await context.read<TProductosAppProvider>().saveProvider(
          //FILES 
          fileImagen: imagenes,
          filePdf: pdfs,
          //DOCUEMent
          imgString: FormatValues.convertirToListString( _imagenController.text), //List<String>
          pdfString: FormatValues.convertirToListString(_pdfController.text), //List<String>
          //LISTA JSON DATA 
          listaMarcas: FormatValues.listaFromString<TProductosAppModel>(_marcasController.text, TProductosAppModel.fromJson),
         //IDRELATIONS 
          idMenu: _idMenuController.text, //Puede ser nulo dependiento se hara edit o create
         //Generico
          context: context,
          id: _idController.text, //Puede ser nulo dependiento se hara edit o create
          qr: _qrController.text,
          categoriaCompras: _categoriaComprasController.text,
          categoriaInventario: _categoriaInventarioController.text,
          ubicacion: _ubicacionController.text,
          proveedor: FormatValues.convertirToListString(_proveedorController.text), //List<String>
          rotacion: _rotacionController.text,
          nombre: _nombreController.text,
          intUndMedida: _intUndMedidaController.text,
          outUndMedida: _outUndMedidaController.text,
          intPrecioCompra: FormatValues.convertirTextoADouble(_intPrecioCompraController.text),
          outPrecioDistribucion: FormatValues.convertirTextoADouble(_outPrecioDistribucionController.text),
          tipo: _tipoController.text,
          fechaVencimiento: FormatValues.parseDateTime(_fechaVencientoController.text),
          estado: _estadoController.text,
          demanda: _demandaController.text,
          condicionAlmacenamiento: _condicionAlmacenamientoController.text,
          formato: _formatoController.text,
          tipoPrecio: _tipoPrecioController.text,
          durabilidad: _durabilidadController.text,
          proveeduria: _proveeduriaController.text,
          presentacionVisual: _presentacionVisualnController.text,
          embaseAmbiental: _embaseAmbientalController.text,
          responsabilidadAmbiental: _responsabilidadAmbientalController.text,
          cantidadEnStock: FormatValues.convertirTextoADouble(_cantidadEnStockController.text),
          cantidadCritica: FormatValues.convertirTextoADouble(_cantidadCriticaController.text),
          cantidadOptima: FormatValues.convertirTextoADouble(_cantidadOptimaController.text),
          cantidadMaxima: FormatValues.convertirTextoADouble(_cantidadMaximaController.text),
          cantidadMalogrados: FormatValues.convertirTextoADouble(_cantidadMalogradosController.text),
          observacion: _observacionController.text,
          // html: html,
          moneda: _monedaController.text,
          active: FormatValues.parseBool(_activeController.text),

         
          
        );
    _cleanAll();
    if (mounted) {
      widget.onSave();
    }
  }
}
