import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:http/http.dart' as http;

class StockTile extends StatefulWidget {
  const StockTile({
    super.key,
    required this.title,
    required this.onAddStock,
  });
  final Map<String, dynamic> title;
  final void Function(String, String, dynamic)? onAddStock;

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
        color: Theme.of(context).colorScheme.onPrimary,
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
                  widget.title['company_name'],
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
                      '₹ ${indianStocks[widget.title['company_name']]!['price'].toString()}',
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
                          "${widget.title['company_name']} ${'\n'}₹ ${indianStocks[widget.title['company_name']]!['price']}",
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
                        onPressed: () {
                          widget.onAddStock!(widget.title['company_name'],
                              "buy", quantity.text);
                          quantity.clear();
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
                          "${widget.title['company_name']} ${'\n'}₹ ${indianStocks[widget.title['company_name']]!['price']}",
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
                        onPressed: () {
                          widget.onAddStock!(widget.title['company_name'],
                              "sell", quantity.text);
                          quantity.clear();
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
