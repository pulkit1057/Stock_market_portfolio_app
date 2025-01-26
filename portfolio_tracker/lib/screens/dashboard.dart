import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:portfolio_tracker/components/user_searchbar.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:portfolio_tracker/screens/auth.dart';
import 'package:portfolio_tracker/screens/holdings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';
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
  List<dynamic> userHoldings = [];
  Map<String, double> dataMap = {"stocks": 5};

  void getHoldings() async {
    var response = await http.post(
      Uri.parse(
        'http://192.168.1.7:5000/get_holdings',
      ),
      body: jsonEncode({
        "email": email,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var decodedResponse = jsonDecode(response.body);
    setState(() {
      userHoldings = decodedResponse['data'];
      dataMap.remove('stocks');
      for (int i = 0; i < userHoldings.length; i++) {
        dataMap[userHoldings[i]['company_name']] = double.parse((userHoldings[i]
                    ['quantity'] *
                indianStocks[userHoldings[i]['company_name']]!['price'])
            .toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    getHoldings();
  }

  @override
  Widget build(BuildContext context) {
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
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User logged out successfully'),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(Icons.stacked_bar_chart),
            ),
            Text('Theme'),
            TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferencesWithCache.create(
                    cacheOptions: SharedPreferencesWithCacheOptions(
                      allowList: <String>{
                        'token',
                        'theme',
                      },
                    ),
                  );

                  bool? isDark = prefs.getBool('theme');
                  if (isDark == null) {
                    prefs.setBool('theme', true);
                  } else {
                    prefs.setBool('theme', !isDark);
                  }
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                child: Text('theme')),
            Spacer(),
            Text('Log out'),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: UserSearchbar(
                email: email,
              )),
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
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
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
        ],
      ),
    );
  }
}
