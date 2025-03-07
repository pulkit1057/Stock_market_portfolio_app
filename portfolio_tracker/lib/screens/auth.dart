import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_tracker/config.dart';
import 'package:portfolio_tracker/providers/user_holdings_provider.dart';
import 'dart:convert';
import 'package:portfolio_tracker/screens/tabs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.prefs,
  });
  final SharedPreferencesWithCache prefs;

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();
  bool isLogin = true;

  void onSubmit() async {
    if (!userEmail.text.contains('@') ||
        userPassword.text.trim().length < 4 ||
        (!isLogin && userName.text.trim().length < 6)) {
      return;
    }

    if (!isLogin) {
      try {
        final response = await http.post(
          Uri.parse(
            'http://$localhost:5000/registeration',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              'email': userEmail.text,
              'passkey': userPassword.text,
              'name': userName.text,
            },
          ),
        );
        final responseBody = jsonDecode(response.body);
        if (!responseBody['status']) {
          return;
        }
      } catch (e) {
        throw e;
      }
    }

    try {
      final response = await http.post(
        Uri.parse('http://$localhost:5000/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'email': userEmail.text,
            'passkey': userPassword.text,
          },
        ),
      );

      final responseBody = jsonDecode(response.body);
      final status = responseBody["status"];
      if (status) {
        var myToken = responseBody['token'];
        widget.prefs.setString('token', myToken);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TabsScreen(
              token: myToken,
            ),
          ),
        );
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              responseBody["message"],
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    userName.clear();
    userEmail.clear();
    userPassword.clear();
  }

  @override
  void initState() {
    super.initState();
    widget.prefs.getString('token');
  }

  @override
  void dispose() {
    super.dispose();
    userEmail.dispose();
    userPassword.dispose();
    userName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.only(
          top: 25,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(
              18,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.stacked_bar_chart),
            if (!isLogin)
              TextField(
                controller: userName,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: userEmail,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: userPassword,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black)),
              onPressed: onSubmit,
              child: Text(
                isLogin ? "Sign in" : "Sign up",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin ? "Register" : "Already have an account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
