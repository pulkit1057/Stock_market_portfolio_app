import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(left: 12),
        child: Column(
          children: [
            Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold, 
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card,
              ),
              title: Text('Credit Card'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card_sharp,
              ),
              title: Text('Debit Card'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Bootstrap.google,
                size: 20,
              ),
              title: Text('UPI'),
              onTap: () async{
                await LaunchApp.openApp(
                  androidPackageName: 'com.google.android.youtube'
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
