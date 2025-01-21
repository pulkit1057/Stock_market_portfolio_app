import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:portfolio_tracker/screens/dashboard.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

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
    if (!userEmail.text.contains('@') &&
        userPassword.text.trim().length < 6 &&
        (isLogin || userName.text.trim().length < 6)) {
      return;
    }

    if (!isLogin) {
      try {
        final response = await http.post(
          Uri.parse(
            'http://192.168.1.7:5000/registeration',
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
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardScreen(token: ),));
        }
        userName.clear();
      } catch (e) {
        throw e;
      }
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.7:5000/login'),
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashboardScreen(token: responseBody['token']),
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

    userEmail.clear();
    userPassword.clear();
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
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.white
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: Text(isLogin ? "Register" : "Already have an account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
