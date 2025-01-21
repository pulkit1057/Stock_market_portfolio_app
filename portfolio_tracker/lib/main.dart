import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/screens/auth.dart';
import 'package:portfolio_tracker/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesWithCache prefs =
      await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: <String>{'token'},
    ),
  );

  String? token = prefs.getString('token');
  runApp(MaterialApp(
    home: MyApp(
      token: token,
      prefs:prefs,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.token,
    required this.prefs,
  });
  final token;
  final prefs;

  @override
  Widget build(BuildContext context) {
    if (token == '' || token == null || JwtDecoder.isExpired(token)) {
      return AuthScreen(prefs:prefs,);
    }
    else{
      return DashboardScreen(token: token,);
    }
  }
}
