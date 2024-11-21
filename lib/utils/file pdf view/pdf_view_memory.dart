import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

class PdfViewMemory extends StatefulWidget {
  const PdfViewMemory({
    Key? key,
    required this.pdfBytes,
  }) : super(key: key);

  final Uint8List pdfBytes;

  @override
  _PdfViewMemoryState createState() => _PdfViewMemoryState();
}

class _PdfViewMemoryState extends State<PdfViewMemory> {
  final PdfViewerController _pdfController = PdfViewerController();
  final TextEditingController _pageController = TextEditingController();
  int _currentPage = 1;
  int _totalPages = 0;
  double _zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController.text = _currentPage.toString();
  }

  void _goToPage(int page) {
    if (page > 0 && page <= _totalPages) {
      _pdfController.jumpToPage(page);
      setState(() {
        _currentPage = page;
        _pageController.text = _currentPage.toString();
      });
    }
  }

  void _setZoom(double zoom) {
    // Ensure zoom level is within bounds (0.5 to 3.0)
    if (zoom >= 0.5 && zoom <= 3.0) {
      _pdfController.zoomLevel = zoom;
      setState(() {
        _zoomLevel = zoom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4C4B4B), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF343232),
        title: Row(
          children: [
            Flexible(
              flex: 1,
              child: H3Text(text: '${widget.pdfBytes.length}', color: Colors.grey.shade400),
            ),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildPageNavigation(),
                  Container(width: .5, height:15, color: Colors.grey.shade50),
                  _buildZoomControls(),
                 Container(width: .5, height:15, color: Colors.grey.shade50),
                ],
              ),
            ),
           
          ],
        ),
       
      ),
      body: SfPdfViewer.memory(
        widget.pdfBytes,
        controller: _pdfController,
        pageSpacing: 20,
      
        onDocumentLoaded: (details) {
          setState(() {
            _totalPages = details.document.pages.count;
          });
        },
        onPageChanged: (details) {
          setState(() {
            _currentPage = details.newPageNumber;
            _pageController.text = _currentPage.toString();
          });
        },
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        initialZoomLevel: _zoomLevel,
        maxZoomLevel: 3.0,
         pageLayoutMode: PdfPageLayoutMode.single, // Modo de diseño de página a una sola página
         scrollDirection: PdfScrollDirection.vertical,
      ),
    );
  }

  Widget _buildPageNavigation() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
       GestureDetector(
          child: Icon(Icons.arrow_drop_up , color: Colors.grey.shade400),
          onTap: () {
            if (_currentPage > 1) {
              _goToPage(_currentPage - 1);
            }
          },
        ),
        Container(
          width: 30,
          height: 25,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5, color: Colors.white),
            decoration: AssetDecorationTextField.decorationFormPDfView(),
            controller: _pageController,
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final int? page = int.tryParse(value);
              if (page != null) {
                _goToPage(page);
              }
            },
          ),
        ),
        Text(
          ' / $_totalPages',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.0, color: Colors.grey.shade400),
        ),
         GestureDetector(
          child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade400),
          onTap: () {
            if (_currentPage < _totalPages) {
              _goToPage(_currentPage + 1);
            }
          },
        ),
        
      ],
    );
  }

  Widget _buildZoomControls() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
       mainAxisSize: MainAxisSize.min,
      children: [
       // Botón de zoom "menos"
      GestureDetector(
        child: Icon(Icons.remove, color: _zoomLevel <= 1.0 ? Colors.grey.shade200 : Colors.grey.shade400, size: 16),
        onTap: _zoomLevel <= 1.0
            ? null // Desactiva el botón si el zoom es 100%
            : () {
                _setZoom(_zoomLevel - 0.1); // Decrease zoom
              },
      ),
        Text(
          '${(_zoomLevel * 100).toInt()}%',
         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.0, color: Colors.grey.shade400),
        ),
        GestureDetector(
          child: Icon(Icons.add, color: Colors.grey.shade400, size: 16),
          onTap: () {
            _setZoom(_zoomLevel + 0.1); // Increase zoom
          },
        ),
      ],
    );
  }
}
