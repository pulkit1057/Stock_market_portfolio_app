import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:portfolio_tracker/components/news_component.dart';
import 'package:portfolio_tracker/config.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:portfolio_tracker/screens/auth.dart';
import 'package:portfolio_tracker/screens/holdings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/screens/transactions.dart';
import 'package:portfolio_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        'http://$localhost:5000/get_holdings',
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
      dataMap = {};
      if (userHoldings.isEmpty) {
        dataMap = {'stocks': 32};
      }
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
            SizedBox(
              height: 12,
            ),
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
              child: Text(
                'Theme',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Spacer(),
            Text('Log out'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   margin: EdgeInsets.symmetric(
              //     horizontal: 5,
              //   ),
              //   child: UserSearchbar(
              //     email: email,
              //     reload: getHoldings,
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HoldingsScreen(
                            email: email,
                            reload: getHoldings,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('List of Holdings'),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionsScreen(
                            email: email,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('Transaction history'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              userHoldings.isNotEmpty
                  ? PieChart(
                      dataMap: dataMap,
                      chartValuesOptions: ChartValuesOptions(decimalPlaces: 2),
                    )
                  : Center(
                      // heightFactor: 20,
                      child: Text(
                        "Currently you don't hold any holdings !!!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
              SizedBox(
                height: 80,
              ),
              Text(
                'Trending News',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CarouselSlider(
                items: [0, 1, 2, 3, 4].map((e) {
                  return Builder(
                    builder: (context) {
                      return NewsComponent(
                        index: e,
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(
                    seconds: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
