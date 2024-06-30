import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart_app/pages/product_detail.dart';
import 'package:fresh_mart_app/services/database.dart';

import '../widget/support_widget.dart';

// ignore: must_be_immutable
class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({required this.category});

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream? CategoryStream;
  getontheload() async {
    CategoryStream = await DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allPrducts() {
    return StreamBuilder(
      stream: CategoryStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          ds["Image"],
                          height: 150.0,
                          width: 150.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          ds["Name"],
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              '\$ ' + ds["Price"],
                              style: TextStyle(
                                  color: Color(0xFFfd6f3e),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                            image: ds["Image"],
                                            name: ds["Name"],
                                            detail: ds["Detail"],
                                            price: ds["Price"])));
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFfd6f3e),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: allPrducts())],
        ),
      ),
    );
  }
}
