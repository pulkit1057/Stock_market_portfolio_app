import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:portfolio_tracker/screens/holdings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Map<String, double> dataMap = {
    "stocks": 26,
    "mutual funds": 55,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolios'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: SearchAnchor(
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  leading: Icon(Icons.search),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  hintText: 'Search',
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(),
                  ),
                  elevation: WidgetStatePropertyAll(0.5),
                );
              },
              suggestionsBuilder: (context, controller) {
                return List<ListTile>.generate(
                  5,
                  (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                          FocusScope.of(context).unfocus();
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HoldingsScreen(),
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
        ],
      ),
    );
  }
}
