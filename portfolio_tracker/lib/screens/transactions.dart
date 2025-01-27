import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<dynamic> transactions = [];

  void getTransactions() async {
    var response = await http.post(
      Uri.parse('http://192.168.1.7:5000/transactions_history'),
      body: jsonEncode(
        {"email": widget.email},
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var decodedResponse = jsonDecode(response.body);
    setState(() {
      transactions = decodedResponse['data'];
    });
  }

  @override
  void initState() {
    getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Center(
        child: transactions.isEmpty
            ? Text('No transactions made on this account yet')
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Table(
                    border: TableBorder.all(
                        color: Theme.of(context).colorScheme.inversePrimary),
                    children: [
                      TableRow(children: [
                        Text('Company'),
                        Text('Date'),
                        Text('Action'),
                        Text('Price'),
                        Text('Quantity'),
                        Text('Total'),
                      ]),
                      for (var i = 0; i < transactions.length; i++)
                        TableRow(children: [
                          Text(transactions[i]['name']),
                          Text(transactions[i]['date'].toString()),
                          Text(transactions[i]['action']),
                          Text(transactions[i]['price'].toString()),
                          Text(transactions[i]['quantity'].toString()),
                          Text((transactions[i]['quantity']*transactions[i]['price']).toString(),style: TextStyle(color: transactions[i]['action'] == 'buy' ? Colors.red:Colors.green),),
                        ])
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
