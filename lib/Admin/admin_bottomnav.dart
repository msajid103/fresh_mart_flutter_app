import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '/Admin/add_product.dart';
import '/Admin/sales_record.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  late List<Widget> pages;
  late SalesRecordPage salesRecordPage;
  late AddProduct addProduct;

  int currentTabIndex = 0;

  @override
  void initState() {
    salesRecordPage = SalesRecordPage();
    addProduct = AddProduct();

    pages = [salesRecordPage, addProduct];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Color(0xfff2f2f2),
          color: Colors.purple,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.report,
              color: Colors.white,
            ),
            Icon(
              Icons.production_quantity_limits,
              color: Colors.white,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
