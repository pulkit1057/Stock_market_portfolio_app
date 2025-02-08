import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/providers/user_holdings_provider.dart';
import 'package:portfolio_tracker/screens/auth.dart';
import 'package:portfolio_tracker/screens/tabs.dart';
import 'package:portfolio_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesWithCache prefs =
      await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: <String>{'token', 'theme'},
    ),
  );

  String? token = prefs.getString('token');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHoldingsProvider(),
        ),
      ],
      child: MyApp(
        token: token,
        prefs: prefs,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.token,
    required this.prefs,
  });
  final String? token;
  final SharedPreferencesWithCache prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: token == '' || token == null || JwtDecoder.isExpired(token!)
          ? AuthScreen(
              prefs: prefs,
            )
          : TabsScreen(
              token: token!,
            ),
    );
  }
}
