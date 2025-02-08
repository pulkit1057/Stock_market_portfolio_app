import 'package:flutter/material.dart';
import 'package:portfolio_tracker/providers/user_holdings_provider.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.read<UserHoldingsProvider>().setup();
      }),
    );
  }
}