import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  const StockTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            Text(
              'Stock 1',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.edit)),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
