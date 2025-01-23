import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:http/http.dart' as http;

class StockTile extends StatefulWidget {
  const StockTile({
    super.key,
    required this.title,
  });
  final Map<String, dynamic> title;

  @override
  State<StockTile> createState() => _StockTileState();
}

class _StockTileState extends State<StockTile> {
  TextEditingController quantity = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    quantity.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title['name'],
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('qty : ${widget.title['quantity'].toString()}'),
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      '₹ ${widget.title['price'].toString()}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Adding a stock'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.title['name']} ${'\n'}₹ ${indianStocks[widget.title['name']]!['price']}",
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
                              "email": widget.title['email'],
                              "name": widget.title['name'],
                              "action": "buy",
                              "price":
                                  indianStocks[widget.title['name']]!['price'],
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
              child: Icon(
                Icons.shop_rounded,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Selling a stock'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.title['name']} ${'\n'}₹ ${indianStocks[widget.title['name']]!['price']}",
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
                              "email": widget.title['email'],
                              "name": widget.title['name'],
                              "action": "sell",
                              "price":
                                  indianStocks[widget.title['name']]!['price'],
                              "quantity": quantity.text
                            }),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          setState(() {
                            print(jsonDecode(response.body));
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(
                Icons.sell,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
