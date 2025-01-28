import 'package:flutter/material.dart';

class NewsComponent extends StatelessWidget {
  const NewsComponent({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(
        //   width: 2,
        //   color: Theme.of(context).colorScheme.inversePrimary,
        // ),
        // color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/img$index.jpg',
            fit: BoxFit.fitHeight,
            height: 250,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Nifty ⬆️ 81 points (+0.33%) Dow Future: 41268 (+0.04%) FTSE: 8340 (-0.05%) CAC: 7588 (+0.31%) DAX: 18765 (+0.37%) BANKNIFTY (28th Aug Monthly expiry): Support - 51000 /50750 Resistance - 51450/51700',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
