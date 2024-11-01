
import 'package:flutter/material.dart';
import 'package:webandean/pages/home/dashboard_page.dart';


class LayoutModel with ChangeNotifier {
  Widget _currentPage =  const Dashboardpage();


  set currentPage(Widget page){
    _currentPage = page;
    notifyListeners();
  }

  Widget get currentPage => _currentPage; 
  
}