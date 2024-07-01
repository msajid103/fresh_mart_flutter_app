import 'package:flutter/material.dart';

class SalesRecordPage extends StatefulWidget {
  @override
  _SalesRecordPageState createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
  String dropdownValue = 'Category';
  final Map<String, Map<String, String>> salesData = {
    'Category': {
      'Electronics': '1500',
      'Clothing': '1200',
      'Home & Kitchen': '800',
    },
    'Region': {
      'North': '2000',
      'South': '1500',
      'East': '1000',
      'West': '1200',
    },
    'Quarter': {
      'Q1': '5000',
      'Q2': '4500',
      'Q3': '4000',
      'Q4': '4800',
    },
    'Week': {
      'Week 1': '800',
      'Week 2': '750',
      'Week 3': '900',
      'Week 4': '950',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Records'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.deepPurple.shade200, Colors.indigo.shade300],
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: ['Category', 'Region', 'Quarter', 'Week']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    underline: Container(), // Removes the underline
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    dropdownColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: salesData[dropdownValue]!.length,
                itemBuilder: (context, index) {
                  String key = salesData[dropdownValue]!.keys.toList()[index];
                  String value = salesData[dropdownValue]![key]!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                key,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
