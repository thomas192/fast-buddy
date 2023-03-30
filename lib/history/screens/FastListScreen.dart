import 'package:flutter/material.dart';
import 'package:fast_buddy/history/widgets/FastList.dart';

class FastListScreen extends StatelessWidget {
  const FastListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(
          color: Colors.black,
          size: contextHeight * 0.046,
        ),
      ),
      body: FastList(),
    );
  }
}
