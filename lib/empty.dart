import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: .center,
          children: [
            SizedBox(height: 65),

            Center(child: Image.asset("I/i4.png", width: 352, height: 238)),
            SizedBox(height: 15),
            Text(
              "What do you want to do today?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Tap + to add your tasks",
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
          ],
        );
  }
}