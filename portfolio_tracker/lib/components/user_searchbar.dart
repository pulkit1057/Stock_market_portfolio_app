import 'package:flutter/material.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:portfolio_tracker/screens/stock.dart';

class UserSearchbar extends StatefulWidget {
  const UserSearchbar({super.key});

  @override
  State<UserSearchbar> createState() => _UserSearchbarState();
}

class _UserSearchbarState extends State<UserSearchbar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          leading: Icon(
            Icons.search,
          ),
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
        List<String> list = [];

        for (var i = 0; i < companyNames.length; i++) {
          if (companyNames[i].contains(controller.text)) {
            list.add(companyNames[i]);
            if (list.length == 5) {
              break;
            }
          }
        }
        if (list.isEmpty) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = companyNames[index];
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
        } else {
          return List<ListTile>.generate(
            list.length < 5 ? list.length : 5,
            (int index) {
              final String item = list[index];
              return ListTile(
                title: Text(item),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StockScreen(
                        title: list[index],
                      ),
                    ),
                  );
                  setState(() {
                    controller.closeView(item);
                    FocusScope.of(context).unfocus();
                  });
                },
              );
            },
          );
        }
      },
    );
  }
}
