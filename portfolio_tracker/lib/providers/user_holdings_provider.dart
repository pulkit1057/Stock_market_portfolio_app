import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:portfolio_tracker/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserHoldingsProvider extends ChangeNotifier {
  late List<dynamic> _userHoldings = [];
  late String email;
  bool isFirsttime = true;

  // UserHoldingsProvider() {
  //   setup();
  //   print('Bye');
  // }

  void setup() async {
    SharedPreferencesWithCache prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: <String>{'token'},
      ),
    );

    final String? token = prefs.getString('token');

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token!);
    email = jwtDecodedToken['email'];

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

    _userHoldings = decodedResponse['data'];
    notifyListeners();
  }

  List<dynamic> get userHoldings => _userHoldings;

  set userHoldings(List<dynamic> userHoldings)
  {
    _userHoldings = userHoldings;
    notifyListeners();
  }

  void notfirstTime(){
    isFirsttime = false;
    notifyListeners();
  }
}
