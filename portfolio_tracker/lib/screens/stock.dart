import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_tracker/config.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_tracker/models/chart.dart';
import 'package:portfolio_tracker/screens/payment.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

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
  late TooltipBehavior _toolTipBehavior;
  List<Chart> graphPoints = [];

  void getData() async {
    var response = await http.get(Uri.parse(
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=${indianStocks[widget.title]!['symbol']}.BSE$url'));

    var decodedResponse = jsonDecode(response.body);

    for (var i in decodedResponse['Time Series (Daily)'].keys) {
      graphPoints.add(Chart(i.toString(),
          double.parse(decodedResponse['Time Series (Daily)'][i]['1. open'])));
      if (graphPoints.length > 9) {
        break;
      }
    }
    setState(() {
      graphPoints = graphPoints.reversed.toList();
    });
  }

  double random() {
    return indianStocks[widget.title]!['price'] -
        Random().nextInt(50).toDouble();
  }

  @override
  void initState() {
    _toolTipBehavior = TooltipBehavior(enable: true);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: graphPoints.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹ ${graphPoints[graphPoints.length - 1].price}',
                  ),
                  SizedBox(
                    height: 8,
                  ),
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
                                  Uri.parse('http://$localhost:5000/add_stock'),
                                  body: jsonEncode({
                                    "email": widget.email,
                                    "name": widget.title,
                                    "action": "buy",
                                    "price":
                                        indianStocks[widget.title]!['price'],
                                    "quantity": quantity.text
                                  }),
                                  headers: {
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                );
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PaymentScreen(),
                                ));
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(4),
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.inversePrimary)),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _toolTipBehavior,
                    margin: EdgeInsets.all(20),
                    series: [
                      LineSeries<Chart, String>(
                        dataSource: graphPoints,
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
