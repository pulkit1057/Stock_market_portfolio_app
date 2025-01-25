import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/screens/auth.dart';
import 'package:portfolio_tracker/screens/dashboard.dart';
import 'package:portfolio_tracker/theme/dark_mode.dart';
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
  final token;
  final SharedPreferencesWithCache prefs;

  @override
  Widget build(BuildContext context){
    // var isDark = prefs.getBool('theme');

    
    return MaterialApp(
      theme:  Provider.of<ThemeProvider>(context).themeData,
      home: token == '' || token == null || JwtDecoder.isExpired(token)
          ? AuthScreen(
              prefs: prefs,
            )
          : DashboardScreen(
              token: token,
            ),
    );
  }
}
