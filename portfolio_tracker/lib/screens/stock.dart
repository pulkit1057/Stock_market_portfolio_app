import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_tracker/models/chart.dart';
import 'package:portfolio_tracker/screens/payment.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({
    super.key,
    required this.title,
    required this.email,
    required this.reload,
  });
  final String title;
  final String email;
  final void Function()? reload;

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  TextEditingController quantity = TextEditingController();
  late TooltipBehavior _toolTipBehavior;

  @override
  void initState() {
    _toolTipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹ ' + indianStocks[widget.title]!['price'].toString(),
            ),
            SizedBox(height: 8,),
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
                              "price": indianStocks[widget.title]!['price'],
                              "quantity": quantity.text
                            }),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ));
                          widget.reload!();
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                );
              },
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(4),
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.inversePrimary)
              ),
              child: Text(
                'Buy',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: _toolTipBehavior,
              margin: EdgeInsets.all(20),
              series: [
                LineSeries<Chart, String>(
                  dataSource: <Chart>[
                    Chart("1-jan-25", 3),
                    Chart("2-jan-25", 5),
                    Chart("3-jan-25", 6),
                    Chart("4-jan-25", 5),
                    Chart("5-jan-25", 4),
                    Chart("6-jan-25", 8),
                  ],
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  xValueMapper: (Chart point, _) => point.date,
                  yValueMapper: (Chart point, index) => point.price,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
