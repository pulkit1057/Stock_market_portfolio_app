import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:portfolio_tracker/components/user_searchbar.dart';
import 'package:portfolio_tracker/config.dart';
import 'package:portfolio_tracker/screens/auth.dart';
import 'package:portfolio_tracker/screens/holdings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/screens/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.token,
  });
  final String token;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String email;
  final Map<String, double> dataMap = {
    "stocks": 26,
    "mutual funds": 55,
  };

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    void visitStockScreen(title) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockScreen(title: title),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolios'),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferencesWithCache.create(
                  cacheOptions: SharedPreferencesWithCacheOptions(
                      allowList: <String>{'token'}));
              prefs.setString('token', '');
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AuthScreen(
                  prefs: prefs,
                ),
              ));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: UserSearchbar()
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HoldingsScreen(email: email),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              margin: EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(5)),
              child: Text('List of Holdings'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          PieChart(
            dataMap: dataMap,
            chartValuesOptions: ChartValuesOptions(decimalPlaces: 1),
          ),
          ElevatedButton(
            onPressed: () async {
              final response = await http.get(
                Uri.parse(
                  url,
                ),
              );
              var body = jsonDecode(response.body);
              print(body);
              var map = body['Time Series (5min)'];
              // print(map.values);
              for (var i in map.values) {
                // print(i.key);
                print(i['1. open']);
              }

              for (var i in map.keys) {
                print(i);
              }
            },
            child: Text('button'),
          ),
          Text(email)
        ],
      ),
    );
  }
}
