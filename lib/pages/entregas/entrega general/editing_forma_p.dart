

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

import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';

import 'package:webandean/provider/itinerarios/provider_itinerarios.dart';
import 'package:webandean/provider/personal/provider_personal.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
import 'package:webandean/provider/entregas/provider_lista_equipo.dart';
import 'package:webandean/provider/entregas/provider_lista_producto.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPageProductosApp extends StatefulWidget {
  const EditPageProductosApp({
    super.key,
    this.e,
    required this.onSave, // Define el parámetro de función
  });
  final TEntregasModel? e; //final TProductosAppModel? e;
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
  final TextEditingController _listEquipoController = TextEditingController();
  final TextEditingController _listProductoController = TextEditingController();
  //ID RELATIONS 
  final TextEditingController _idReservaController = TextEditingController();
  final TextEditingController _idPersonalController = TextEditingController();
  final TextEditingController _idListaEquiposController = TextEditingController();
  final TextEditingController _idListaProductosController = TextEditingController();
  //General 
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _observacionController = TextEditingController();

  var title = 'Crear nuevo';

  @override
  void initState() {
    super.initState();
    if (widget.e != null) {
      final e = widget.e!;
      //FILES 
      // _imagenController.text = e.imagen!.join(',');
      // _pdfController.text = e.pdf!.join(',');
      _imagenController.text = e.imagen;
      _pdfController.text = e.pdf;
      //LISTAS 
     // Convierte la lista a String personalizado y lo asigna al TextController
      // TProductosAppModel.listaMarcasToString(e.listaMarcas);
     _listEquipoController.text = FormatValues.listaToString<TEquiposAppModel>(
                              e.listaEquipos, 
                              TEquiposAppModel.fromJson, 
                              (TEquiposAppModel marca) => marca.toJson()
                            );

    _listProductoController.text = FormatValues.listaToString<TProductosAppModel>(
                              e.listaProducto, 
                              TProductosAppModel.fromJson, 
                              (TProductosAppModel marca) => marca.toJson()
                            );
     //IDRELATION 
     _idReservaController.text = e.idReserva.join(',');     //Type: List<String>
      _idPersonalController.text = e.idPersonal.join(',');  //Type: List<String>
      _idListaEquiposController.text = e.idListaEquipos.toString();
      _idListaProductosController.text = e.idListaCompra.toString();
      //GENRICO 
      title = e.nombre; //TITULO FORMULARIO
      _idController.text = e.id.toString();
      _qrController.text = e.qr;
      _activeController.text = e.active.toString();
      _nombreController.text = e.nombre;
      _observacionController.text = e.observacion;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<TEntregasAppProvider>(context);
    bool isavingProvider = dataProvider.isSyncing;
    final listDataProvider = dataProvider.listProductos;
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
                      options: [ 'Inicio', 'Valores','Producto', 'Equipo', 'files'],
                      stepContents: [
                        _steeper_1(context, dataProvider, listDataProvider),
                        _steeper_2(context, dataProvider, listDataProvider),
                        _steeper_3(context, dataProvider, listDataProvider),
                        _steeper_4(context, dataProvider, listDataProvider),
                        _steeper_5(context, dataProvider, listDataProvider, widget.e),
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

  Column _steeper_1(BuildContext context, TEntregasAppProvider dataProvider, List<TEntregasModel> listaProducto) {
    return Column(
      children: [
        if (widget.e != null) ...[
          P3Text(text: _idController.text, selectable: true, maxLines: 1),
          P3Text(text: _qrController.text, selectable: true, maxLines: 1),
        ],
        //todos Active 
        FormWidgets(context).switchAdaptive(
                    controller: _activeController,
                    onSelected: (value) => setState(() => _activeController.text = value.toString())),
        //todos qr 
        FormWidgets(context).autocompleteFormWithWarning(
          labelText: 'Serie',
          controller: _qrController,
          valueComparate: widget.e?.qr ??'', //valor a comprar para deterninar si existe o no
          lisData: listaProducto,
          isRequired: true,
          getField: (field) {
            TEntregasModel producto = field;
            return producto.qr.toString();
          },
        ),
        //todos nombre 
        FormWidgets(context).autocompleteForm(
                  isRequired: true,
                  labelText: 'Nombre', // Compra',
                  controller: _nombreController,
                  lisData: listaProducto,
                  getField: (field) {
                    TEntregasModel producto = field;
                    return producto.nombre.toString();
                  }),
        //todos Observacion  
         FormWidgets(context).textFormText(
            controller: _observacionController,
            labelText: 'observación',
            isAllLines: true),

      ],
    );
  }

  Column _steeper_2(BuildContext context, TEntregasAppProvider dataProvider, List<TEntregasModel> listaProducto) {
    final subID_DataPersonal = Provider.of<TPersonalAppProvider>(context, listen: false);
    final subListPersonal = subID_DataPersonal.listProductos;

    final subID_DataReserva = Provider.of<TItinerariosAppProvider>(context, listen: false);
    final subListReserva = subID_DataReserva.listProductos;

    return Column(
      children: [
        FormWidgets(context).autocompleteMulti_IDRelationForm( //Multiples ID 
          labelText:  'ID Personal',
          controller: _idPersonalController, 
          getField: (producto, query) {
            return producto.nombre.toLowerCase().contains(query) ||
                   producto.qr.toLowerCase().contains(query) ||
                   producto.id.toLowerCase().contains(query);
          }, 
          getName: (producto) => producto.nombre,
          getQr: (producto) => producto.qr,
          getId: (producto) => producto.id,
          listaProducto: subListPersonal),//lista a buscar
       
        FormWidgets(context).autocompleteMulti_IDRelationForm(//Multiples ID 
          labelText:  'ID RESERVA',
          controller: _idReservaController, 
          getField: (producto, query) {
            return producto.nombre.toLowerCase().contains(query) ||
                   producto.qr.toLowerCase().contains(query) ||
                    producto.itinerario.toLowerCase().contains(query) ||
                   producto.id.toLowerCase().contains(query);
          }, 
          getName: (producto) => producto.itinerario,
          getQr: (producto) => producto.nombre,
          getId: (producto) => producto.id,
          listaProducto: subListReserva),//lista a buscar
       
      ],
    );
  }

  Column _steeper_3(BuildContext context, TEntregasAppProvider dataProvider, List<TEntregasModel> listaProducto) {
    final subID_DataProducto = Provider.of<TListaProductosAppProvider>(context, listen: false);
    final subListProducto = subID_DataProducto.listProductos;
   
  //  final subList_DataProducto = Provider.of<TProductosAppProvider>(context, listen: false);
  //   final listProductoSublist = subList_DataProducto.listProductos;
 
    return Column(
      children: [

        FormWidgets(context).autocomplete_IDRelationForm(
          labelText: 'ID Lista Producto',
          controller: _idListaProductosController, 
          getField: (producto, query) {
            return producto.nombre.toLowerCase().contains(query) ||
                   producto.qr.toLowerCase().contains(query) ||
                   producto.id.toLowerCase().contains(query);
          }, 
          getName: (producto) {
           
            //Asignamos la lista de Item al controler forma practica de comenzar. 
            _listProductoController.text = FormatValues.listaToString<TProductosAppModel>(
                              producto.listaProducto, 
                              TProductosAppModel.fromJson, 
                              (TProductosAppModel marca) => marca.toJson()
                            );
            return producto.nombre;
          },
          getQr: (producto) => producto.qr,
          getId: (producto) => producto.id,
          listaProducto: subListProducto),//lista a buscar

        // FormWidgets(context).autocomleteSearchListForm(
        //       title: 'Lista Productos',
        //       controller: _listProductoController,
        //       listaProducto: listProductoSublist,//lista de Objeto para este ejmplo se utilizo productos 
        //       getName: (producto) => producto.nombre,
        //       getQr: (producto) => producto.qr,
        //       getId: (producto) => producto.id,
        //       getField: (producto, query) {
        //         return producto.nombre.toLowerCase().contains(query) ||
        //                producto.qr.toLowerCase().contains(query) ||
        //                producto.id.toLowerCase().contains(query);
        //       }, 
        //        toJson: (producto) => producto.toJson(), // Convierte el producto a JSON
        //        fromJson: (json) => TProductosAppModel.fromJson(json), // Convierte JSON a OBJETO  ProductoModel
        //     ),

          Container(
            height: MediaQuery.of(context).size.height*.46,
            child: SubListWidget(
              controller: _listProductoController, 
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


  Column _steeper_4(BuildContext context, TEntregasAppProvider dataProvider, List<TEntregasModel> listaProducto) {
    final subID_DataProducto = Provider.of<TListaEquipoAppProvider>(context, listen: false);
    final subListProducto = subID_DataProducto.listProductos;
   
  //  final subList_DataProducto = Provider.of<TEquipoAppProvider>(context, listen: false);
  //   final listProductoSublist = subList_DataProducto.listProductos;

    return Column(
      children: [
        FormWidgets(context).autocomplete_IDRelationForm(
          labelText: 'ID Lista Equipos',
          controller: _idListaEquiposController, 
          getField: (producto, query) {
            return producto.nombre.toLowerCase().contains(query) ||
                   producto.qr.toLowerCase().contains(query) ||
                   producto.id.toLowerCase().contains(query);
          }, 
          getName: (producto) {
             //Asignamos la lista de Item al controler forma practica de comenzar. 
             _listEquipoController.text = FormatValues.listaToString<TEquiposAppModel>(
                              producto.listaEquipos, 
                              TEquiposAppModel.fromJson, 
                              (TEquiposAppModel marca) => marca.toJson()
                            );
            return producto.nombre;
          },
          getQr: (producto) => producto.qr,
          getId: (producto) => producto.id,
          listaProducto: subListProducto),//lista a buscar

        // FormWidgets(context).autocomleteSearchListForm(
        //       title: 'Equipos',
        //       controller: _listEquipoController,
        //       getName: (producto) => producto.nombre,
        //       getQr: (producto) => producto.qr,
        //       getId: (producto) => producto.id,
        //       getField: (producto, query) {
        //         return producto.nombre.toLowerCase().contains(query) ||
        //                producto.qr.toLowerCase().contains(query) ||
        //                producto.id.toLowerCase().contains(query);
        //       }, 
        //       toJson: (producto) => producto.toJson(), // Convierte el producto a JSON
        //       listaProducto: listProductoSublist,//lista de Objeto para este ejmplo se utilizo productos 
        //       fromJson: (json) => TEquiposAppModel.fromJson(json), // Convierte JSON a OBJETO  ProductoModel
            // ),

      Container(
        height: MediaQuery.of(context).size.height*.46,
         child: SubListWidget(
          controller: _listEquipoController, 
          toJson: (value) => value.toJson(),
          getId: (producto) => producto.id,
          getName: (producto) => producto.nombre,
          getQr: (producto) => producto.qr,
          routewidget: Container(),
          fromJson: TEquiposAppModel.fromJson,
         ),
       ),
       
     
        
      ],
    );
  }


  Widget _steeper_5(BuildContext context, TEntregasAppProvider dataProvider, List<TEntregasModel> listaProducto, TEntregasModel? value) {
   
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //IMAGENES  
        AppReorderImageForm(
          imagenE: value != null ? value.imagen : '',
          value:   value, //TProductosAppModel? value
          imagenController: _imagenController,
        ),  
        FilesImagesSelectedMovil(isListImage: false),
        // FilesImagesSelectedWeb(isListImage: false),
        //PDF 
        AppReorderPDFForm(
          pdfE: value != null ? value.pdf : '', 
          pdfController: _pdfController,
          value: value),
        // FilesPDFSelectedWeb(isListImage: false),
        FilesPDFSelectedMovil(isListPDf:false),
        
      ],
    );
  }
  

 

  void _cleanAll() {
    _idController.clear();
    _qrController.clear();
    _activeController.clear();
    _nombreController.clear();
    _observacionController.clear();

    _imagenController.clear();
    _pdfController.clear();
    
    _listEquipoController.clear();
    _listProductoController.clear();

    _idReservaController.clear();
    _idPersonalController.clear();
    _idListaEquiposController.clear(); 
    _idListaProductosController.clear();
  }

  Future<void> saveForm() async {
    final filesdata = Provider.of<FilesProvider>(context, listen: false);
    final imagen = filesdata.imagen;
    final pdf = filesdata.pdf;
    print(_idController.text);
    await context.read<TEntregasAppProvider>().saveProvider(
          //FILES 
          fileImagen: imagen,
          filePdf: pdf,
          //DOCUEMent
          imgString: ( _imagenController.text), //List<String>
          pdfString: (_pdfController.text), //List<String>
          //LISTA JSON DATA 
          listaEquipos: FormatValues.listaFromString<TEquiposAppModel>(_listEquipoController.text, TEquiposAppModel.fromJson),
          listaProducto: FormatValues.listaFromString<TProductosAppModel>(_listProductoController.text, TProductosAppModel.fromJson),
         //IDRELATIONS 
          idReserva: FormatValues.convertirToListString(_idReservaController.text),
          idPersonal: FormatValues.convertirToListString(_idPersonalController.text),
          idListaEquipos: _idListaEquiposController.text, //Puede ser nulo dependiento se hara edit o create
          idListaCompra: _idListaProductosController.text,
         //Generico
          context: context,
          id: _idController.text, //Puede ser nulo dependiento se hara edit o create
          qr: _qrController.text,
          nombre: _nombreController.text,
          observacion: _observacionController.text,
          // html: html,
          active: FormatValues.parseBool(_activeController.text),          
        );
    _cleanAll();
    if (mounted) {
      widget.onSave();
    }
  }
}
