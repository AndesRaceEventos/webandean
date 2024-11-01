import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry rowPadding;
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;
  final Color? headerColor;
  final Color? rowBorderColor;
  // Nueva propiedad para manejar el clic en la fila
  final void Function(int index)? onRowTap; // Acepta índice como parámetro

  CustomTable({
    required this.headers,
    required this.rows,
    this.headerPadding = const EdgeInsets.all(10),
    this.rowPadding = const EdgeInsets.all(10),
    this.headerTextStyle,
    this.rowTextStyle,
    this.headerColor = Colors.grey,
    this.rowBorderColor = Colors.grey,
    this.onRowTap, // Inicialización de la nueva propiedad
  });

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  late List<List<String>> originalRows;
  late List<List<String>> sortedRows;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    originalRows = widget.rows;
    sortedRows = List.from(originalRows);
  }

  void _sort(int columnIndex) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortAscending = true;
        _sortColumnIndex = columnIndex;
      }

      sortedRows.sort((a, b) {
        final aValue = a[columnIndex];
        final bValue = b[columnIndex];
        final comparison = aValue.compareTo(bValue);
        return _sortAscending ? comparison : -comparison;
      });
    });
  }

  void _resetSorting() {
    print('Resert sort');
    setState(() {
      sortedRows = List.from(originalRows);
      _sortColumnIndex = null;
      _sortAscending = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: widget.headerColor,
          padding: widget.headerPadding,
          child: Row(
            children: List.generate(widget.headers.length, (index) {
              final header = widget.headers[index];
              final isSortedColumn = _sortColumnIndex == index;
              final sortIcon = isSortedColumn
                  ? (_sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
                  : null;

              return Expanded(
                child: InkWell(
                  onTap: () => _sort(index), // Botón para ordenar
                  onDoubleTap:
                      _resetSorting, // Botón para restaurar el orden original
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      H3Text(
                        text: header,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      if (sortIcon != null)
                        Icon(
                          sortIcon,
                          size: 16,
                          color: Colors.black54,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        // Lista de filas con ListView.builder
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 100),
            itemCount: sortedRows.length,
            itemBuilder: (context, index) {
               print(index);
              return GestureDetector(
                onTap: () {
                  if (widget.onRowTap != null) {
                    widget.onRowTap!(index); // Pasar índice al callback
                  }
                },
                child: AssetsDelayedDisplayYbasic(
                  duration: 200,
                  fadingDuration: 400,
                  child: Container(
                    padding: widget.rowPadding,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: widget.rowBorderColor ?? Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: sortedRows[index].map((cell) {
                        return Expanded(
                          child: Text(
                            cell,
                            style: widget.rowTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
