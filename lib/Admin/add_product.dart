import 'package:flutter/material.dart';
import 'package:fresh_mart_app/widget/support_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: AppWidget.semiboldTextFeildStyle(),
        ),
      ),
      body: Container(
        child: Column(
          children: [Text("Upload the Product Image")],
        ),
      ),
    );
  }
}
