import 'package:flutter/material.dart';
import 'package:portfolio_tracker/data/listed_companies.dart';
import 'package:portfolio_tracker/screens/stock.dart';

class UserSearchbar extends StatefulWidget {
  const UserSearchbar({super.key,required this.email});
  final String email;

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
          if (companyNames[i].toLowerCase().contains(controller.text.toLowerCase())) {
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
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => StockScreen(
                        title: list[index],
                        email: widget.email,
                      ),
                    ),
                  )
                      .then(
                    (value) {
                      controller.closeView('');
                      FocusScope.of(context).unfocus();
                    },
                  );
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
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => StockScreen(
                        title: list[index],
                        email: widget.email,
                      ),
                    ),
                  )
                      .then(
                    (value) {
                      controller.closeView('');
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
