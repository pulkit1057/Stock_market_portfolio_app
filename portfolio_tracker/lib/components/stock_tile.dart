import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  const StockTile({
    super.key,
    required this.title,
  });
  final Map<String, dynamic> title;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title['symbol'],
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('qty : +${title['quantity'].toString()}'),
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      '₹ + ${title['price'].toString()}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.edit,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
