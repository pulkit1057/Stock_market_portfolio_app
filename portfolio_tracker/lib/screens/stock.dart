import 'package:flutter/material.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          indianStocks[widget.title]!['price'].toString(),
        ),
      ),
    );
  }
}
