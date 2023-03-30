import 'package:flutter/material.dart';

class StatsList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const StatsList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contextWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: contextWidth * 0.035, vertical: 0),
              leading: Icon(
                items[index]['icon'] as IconData?,
                size: contextWidth * 0.078,
              ),
              title: Text(
                items[index]['title']!,
                style: TextStyle(fontSize: contextWidth * 0.056, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '${items[index]['duration']} day${int.parse(items[index]['duration']!) > 1 ? 's' : ''}',
                style: TextStyle(fontSize: contextWidth * 0.054),
              ),
            ),
            Container(
              padding:
              EdgeInsets.only(right: contextWidth * 0.03),
              child: Divider(
                thickness: 1,
                color: Colors.grey[400],
                indent: contextWidth * 0.17,
              ),
            ),
          ],
        );
      },
    );
  }
}
