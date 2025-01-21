import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio_tracker/components/stock_tile.dart';
import 'package:http/http.dart' as http;

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  List<dynamic> userHoldings = [];
  void get_holdings() async {
    var response = await http.post(
      Uri.parse(
        'http://192.168.1.7:5000/get_holdings',
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

  @override
  void initState() {
    super.initState();
    get_holdings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Holdings"),
      ),
      body: ListView.builder(
        itemCount: userHoldings.length,
        itemBuilder: (context, index) {
          return StockTile(title: userHoldings[index]);
        },
      ),
    );
  }
}
