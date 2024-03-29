import 'package:flutter/material.dart';

class LooadingContainer extends StatelessWidget {
  const LooadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(height: 8.0,)
      ],
    );
  }

  Widget buildContainer(){
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
    );
  }
}