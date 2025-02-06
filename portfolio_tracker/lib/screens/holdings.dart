import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:portfolio_tracker/components/stock_tile.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_tracker/config.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:portfolio_tracker/screens/payment.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({
    super.key,
    required this.email,
    required this.reload,
  });
  final String email;
  final void Function()? reload;

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  List<dynamic> userHoldings = [];
  void getHoldings() async {
    var response = await http.post(
      Uri.parse(
        'http://$localhost:5000/get_holdings',
      ),
      body: jsonEncode({
        "email": widget.email,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var decodedResponse = jsonDecode(response.body);
    setState(() {
      userHoldings = decodedResponse['data'];
    });
  }

  void onAddStockasync(name, action, quantity) async {
    var response = await http.post(
      Uri.parse('http://$localhost:5000/add_stock'),
      body: jsonEncode({
        "email": widget.email,
        "name": name,
        "action": action,
        "price": indianStocks[name]!['price'],
        "quantity": quantity
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      Navigator.of(context).pop();
      getHoldings();
      if (action == 'buy') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentScreen(),
          ),
        );
      }
      widget.reload!();
    });
  }

  @override
  void initState() {
    super.initState();
    getHoldings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("Stock Holdings"),
      ),
      body: userHoldings.isNotEmpty
          ? ListView.builder(
              itemCount: userHoldings.length,
              itemBuilder: (context, index) {
                return StockTile(
                  title: userHoldings[index],
                  onAddStock: onAddStockasync,
                );
              },
            )
          : Center(
              child: Text(
                "Currently you don't hold any holdings !!!",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
    );
  }
}
