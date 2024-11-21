
import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final List<int> itemsPerPageOptions;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int?>? onItemsPerPageChanged;

  const PaginationControls({
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    required this.itemsPerPageOptions,
    this.onPageChanged,
    this.onItemsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalItems / itemsPerPage).ceil();

    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButton<int>(
            padding: EdgeInsets.all(0),
            isDense: true,
            iconEnabledColor: Colors.black,
            value: itemsPerPage,
            items: itemsPerPageOptions
                .map((e) => DropdownMenuItem<int>(
                      value: e,
                      child: Text("$e"),
                    ))
                .toList(),
            onChanged: (value) {
              if (onItemsPerPageChanged != null) {
                onItemsPerPageChanged!(value);
              }
            },
            isExpanded: false,
          ),
          
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 16),
            onPressed: currentPage > 1
                ? () => onPageChanged?.call(currentPage - 1)
                : null,
          ),
          Text("$currentPage - $itemsPerPage de $totalItems"),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: currentPage < totalPages
                ? () => onPageChanged?.call(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }
}

