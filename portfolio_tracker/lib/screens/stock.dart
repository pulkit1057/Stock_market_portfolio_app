import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:http/http.dart' as http; 

class StockScreen extends StatefulWidget {
  const StockScreen({
    super.key,
    required this.title,
    required this.email,
  });
  final String title;
  final String email;

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  TextEditingController quantity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              indianStocks[widget.title]!['price'].toString(),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(title: Text('Adding a stock'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.title} ${'\n'}₹ ${indianStocks[widget.title]!['price']}",
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Quantity',
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: quantity,
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            quantity.clear();
                          },
                          child: Text('Cancel')),
                      TextButton(
                        onPressed: () async {
                          var response = await http.post(
                            Uri.parse('http://192.168.1.7:5000/add_stock'),
                            body: jsonEncode({
                              "email": widget.email,
                              "name": widget.title,
                              "action": "buy",
                              "price":
                                  indianStocks[widget.title]!['price'],
                              "quantity": quantity.text
                            }),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
