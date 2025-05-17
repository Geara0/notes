import 'package:flutter/material.dart';
import 'package:notes/global_variables/global_variables.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.all(UiGlobal.padding),
        itemBuilder: (context, i) {
          return Container(color: Colors.red, height: 100);
        },
        separatorBuilder: (_, i) {
          return SizedBox(height: UiGlobal.mediumDivider);
        },
        itemCount: 100,
      ),
    );
  }
}
