import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/colors/assets_get_ramdomcolor.dart';
import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/asset_gridviewcutom.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({
    required this.groupedData,
    Key? key,
    required this.distancias,
    required this.childrenBuilder,
  }) : super(key: key);

  final Map<String, List<dynamic>>
      groupedData; //en vez de dynamic es un model TProductosAppModel
  final String distancias;
  final Widget Function(dynamic value, BoxConstraints constraints)
      childrenBuilder;

  @override
  Widget build(BuildContext context) {
    Map<String, int> dataForChart =
        groupedData.map((key, value) => MapEntry(key, value.length));
    final menuProvider = Provider.of<MenuProvider>(context);
    String nombreGroupedata = menuProvider.selectedTitleGroup;
    String nombrePanel = menuProvider.selectedTitle;
    bool expandeView = menuProvider.expandeView;

    //Option selected

    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: GraficoGlobal(
                    data: dataForChart,
                    tituloEjeX: '$nombreGroupedata',
                    tituloEjeY: 'Cantidad de $nombrePanel'.toUpperCase(),
                    distancias: '$distancias',
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 200),
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton( icon: expandeView ? AppSvg().fullexitscreenSvg : AppSvg().fullscreenSvg,
                        onPressed: () => menuProvider.setExpandeView(!expandeView),
                      ),
                      cardCutom(
                        context: context, 
                        number:1 ,
                        child: AppIconButon(child: AppSvg().horizontalChartSvg, 
                        onPressed: () {
                        menuProvider.setOption(1);//Asignala poscion al tomar posicon ym ostrar grafica en posion 1 
                        menuProvider.labelRotationIndex = -20;//valor de labol position por defecto 
                      }, onDoubleTap: menuProvider.option != 1 ?  null : () => menuProvider.randomizelabelRotation([0,-20]),),),//pasar lal ista de valores que va tomar label position
                      cardCutom(context: context, number:2 ,child: AppIconButon(child: AppSvg().columnasCharSvg, onPressed: () {
                        menuProvider.setOption(2);
                        menuProvider.labelRotationIndex = -20;
                      }, onDoubleTap:menuProvider.option != 2 ?  null : () => menuProvider.randomizelabelRotation([-20,-80]),),),
                      cardCutom(context: context, number:3 ,child: AppIconButon(child: AppSvg().doughnutChartSvg, onPressed: () {
                        menuProvider.setOption(3);
                        menuProvider.labelRotationIndex = 1;
                      }, onDoubleTap:menuProvider.option != 3 ?  null : () => menuProvider.randomizelabelRotation([1,4]),),),
                      cardCutom(context: context, number:4 ,child: AppIconButon(child: AppSvg().pyramidChartSvg ,onPressed: () {
                        menuProvider.setOption(4);
                        menuProvider.labelRotationIndex = 3;
                      }, onDoubleTap: menuProvider.option != 4 ?  null :() => menuProvider.randomizelabelRotation([2,3]),),),
                      cardCutom(context: context, number:5 ,child: AppIconButon(child: AppSvg().lineascharSvg, onPressed: () {
                        menuProvider.setOption(5);
                        menuProvider.labelRotationIndex = -20;
                      }, onDoubleTap: menuProvider.option != 5 ?  null :() => menuProvider.randomizelabelRotation([-20,-80]),),),
                      cardCutom(context: context, number:6 ,child: AppIconButon(child: AppSvg().areaChartSvg,onPressed: () {
                        menuProvider.setOption(6);
                      }, onDoubleTap: menuProvider.option != 6 ?  null :() => menuProvider.randomizelabelRotation([-20,-80]),),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        expandeView
            ? SizedBox()
            : Flexible(
                flex: 2,
                child: AssetGRidViewCustom(
                  // Para usar el archivo debe estar definido como [imagen]
                  listdata: groupedData[distancias] ?? [],
                  childrenBuilder: (value, constraints) {
                    return childrenBuilder(value, constraints);
                  },
                ),
              ),
      ],
    );
  }

  Container cardCutom({required  int number,required Widget child,required  BuildContext context}) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    int option = menuProvider.option;
    return Container(decoration: AssetDecorationBox().decorationBox(color: option == number ? Colors.grey : Colors.transparent),padding: option == number ? EdgeInsets.only(right: 10) :null , child: child);
  }
}

class StackedBarData {
  final String grupo;
  final double cantidad;

  StackedBarData({required this.grupo, required this.cantidad});
}

class GraficoGlobal extends StatelessWidget {
  final Map<String, int> data;
  final String tituloEjeX;
  final String tituloEjeY;
  final String distancias;

  const GraficoGlobal({
    Key? key,
    required this.data,
    required this.tituloEjeX,
    required this.tituloEjeY,
    required this.distancias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    bool expandeView = menuProvider.expandeView;

    int option = menuProvider.option;

    List<StackedBarData> chartData = data.entries
        .map((entry) => StackedBarData(
              grupo: entry.key,
              cantidad: entry.value.toDouble(),
            ))
        .toList();

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.all(20),
          width: size.width * 0.8, //chartData.length * 300,
          height: expandeView ? size.height * 0.80 : null,
          child: switch (option) {
            1 => _PlanoCatesiano(chartData, context),
            2 => _columnasChart(chartData, context),
            3 => _circularChart(chartData, context),
            4 => _pyramidChart(chartData, context),//_pastelChart(chartData),
            5 => lienasChart(chartData, context),
            6 => areaLineasChart(chartData, context),
            _ => const Center(child: Text('Opción no válida')),
          },
        ),
      ),
    );
  }
  
CategoryAxis _categoryXaxis(BuildContext context) {
   final menuProvider = Provider.of<MenuProvider>(context, listen:  false);
    return CategoryAxis(
        title: AxisTitle(text: tituloEjeX),
        tickPosition: TickPosition.outside,
        labelRotation: menuProvider.labelRotationIndex);
  }

  SfCartesianChart _PlanoCatesiano(List<StackedBarData> chartData, BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: _categoryXaxis(context),
      primaryYAxis: NumericAxis(title: AxisTitle(text: tituloEjeY)),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: [
        StackedBarSeries<StackedBarData, String>(
          dataSource: chartData,
          xValueMapper: (StackedBarData data, _) => data.grupo,
          yValueMapper: (StackedBarData data, _) => data.cantidad,
          name: '$tituloEjeX',
          pointColorMapper: (StackedBarData data, int index) {
            // Cambiar el color si coincide con el valor de 'distancias'
            return data.grupo == distancias
                ? Colors.cyan
                : Colors.cyan.shade100;
          },
          markerSettings: MarkerSettings(isVisible: true),
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  

  SfCartesianChart _columnasChart(List<StackedBarData> chartData, BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: _categoryXaxis(context),
      primaryYAxis: NumericAxis(title: AxisTitle(text: tituloEjeY)),
       tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: <ColumnSeries<StackedBarData, String>>[
        ColumnSeries<StackedBarData, String>(
          name: '$tituloEjeX',
          dataSource: chartData,
          xValueMapper: (StackedBarData data, _) => data.grupo,
          yValueMapper: (StackedBarData data, _) => data.cantidad,
          pointColorMapper: (StackedBarData data, int index) {
            // Cambiar el color si coincide con el valor de 'distancias'
            return data.grupo == distancias
                ? Colors.cyan
                : Colors.cyan.shade100;
          },
          markerSettings: MarkerSettings(isVisible: true),
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  

  SfCartesianChart lienasChart(List<StackedBarData> chartData, BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: _categoryXaxis(context),
      primaryYAxis: NumericAxis(title: AxisTitle(text: tituloEjeY)),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: <LineSeries<StackedBarData, String>>[
        LineSeries<StackedBarData, String>(
          dataSource: chartData,
          xValueMapper: (StackedBarData data, _) => data.grupo,
          yValueMapper: (StackedBarData data, _) => data.cantidad,
          name: '$tituloEjeX',
          dataLabelSettings: DataLabelSettings(isVisible: true),
           pointColorMapper: (StackedBarData data, int index) {
            // Cambiar el color si coincide con el valor de 'distancias'
            return data.grupo == distancias
                ? Colors.deepOrange
                : Colors.orange.shade200;
          },
          markerSettings: MarkerSettings(isVisible: true),
        )
      ],
    );
  }

  SfCartesianChart areaLineasChart(List<StackedBarData> chartData, BuildContext context) {
    return SfCartesianChart(
       primaryXAxis: _categoryXaxis(context),
      primaryYAxis: NumericAxis(title: AxisTitle(text: tituloEjeY)),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: <AreaSeries<StackedBarData, String>>[
        AreaSeries<StackedBarData, String>(
          dataSource: chartData,
          xValueMapper: (StackedBarData data, _) => data.grupo,
          yValueMapper: (StackedBarData data, _) => data.cantidad,
          name: '$tituloEjeX',
          dataLabelSettings: DataLabelSettings(isVisible: true),
           pointColorMapper: (StackedBarData data, int index) {
            // Cambiar el color si coincide con el valor de 'distancias'
            return data.grupo == distancias
               ? Colors.deepOrange.withOpacity(.7)
                : Colors.orange.withOpacity(.3);
          },
          markerSettings: MarkerSettings(isVisible: true),
        )
      ],
    );
  }



   Legend legendCircularGraf(BuildContext context) {
     final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    int position = menuProvider.labelRotationIndex;
    LegendPosition legendPosition;
  switch (position) {
    case 1:
      legendPosition = LegendPosition.right;
      break;
    case 2:
      legendPosition = LegendPosition.bottom;
      break;
    case 3:
      legendPosition = LegendPosition.left;
      break;
    case 4:
      legendPosition = LegendPosition.top;
      break;
    default:
      legendPosition = LegendPosition.right; // Posición por defecto
  }
    return Legend(
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap,
      position: legendPosition,
      backgroundColor: Colors.white54,
    );
  }

  SfCircularChart _circularChart(List<StackedBarData> chartData, BuildContext context) {
   
    return SfCircularChart(
      legend: legendCircularGraf(context),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <DoughnutSeries<StackedBarData, String>>[
        DoughnutSeries<StackedBarData, String>(
          dataSource: chartData,
          xValueMapper: (StackedBarData data, _) => data.grupo,
          yValueMapper: (StackedBarData data, _) => data.cantidad,
          name: '$tituloEjeX',
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              borderColor: Colors.black38),
          explode: true,
          explodeAll: false,
          explodeIndex:
              chartData.indexWhere((data) => data.grupo == distancias),
          pointColorMapper: (StackedBarData data, _) {
            return data.grupo == distancias
                ? Colors.cyan.shade700
                : getRandomColor().withOpacity(0.5);
          },
          radius: '80%',
          innerRadius: '60%',
        ),
      ],
    );
  }

 

  SfPyramidChart _pyramidChart(List<StackedBarData> chartData, BuildContext context) {
  return SfPyramidChart(
   legend: legendCircularGraf(context),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: PyramidSeries<StackedBarData, String>(
      dataSource: chartData,
      xValueMapper: (StackedBarData data, _) => data.grupo,
      yValueMapper: (StackedBarData data, _) => data.cantidad,
     name: '$tituloEjeX',
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              borderColor: Colors.black38),
          explode: true,
          // explodeAll: false,
          explodeIndex:
              chartData.indexWhere((data) => data.grupo == distancias),
          pointColorMapper: (StackedBarData data, _) {
            return data.grupo == distancias
                ? Colors.cyan.shade700
                : getRandomColor().withOpacity(0.4);
          },
    ),
  );
}


}
