import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';

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
                  widget.title['symbol'],
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
                          widget.title['symbol'] + '\n',
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
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel')),
                      TextButton(onPressed: () {}, child: Text('Submit')),
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
                          widget.title['symbol'] + '\n',
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
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel')),
                      TextButton(onPressed: () {}, child: Text('Submit')),
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
