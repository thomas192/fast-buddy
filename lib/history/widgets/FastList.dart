import 'package:flutter/material.dart';
import 'package:fast_buddy/data/Database.dart';
import 'package:intl/intl.dart';
import 'package:fast_buddy/models/Fast.dart';

class FastList extends StatefulWidget {
  const FastList({Key? key}) : super(key: key);

  @override
  _FastListState createState() => _FastListState();
}

class _FastListState extends State<FastList> {
  List<Fast> ?fasts;

  @override
  void initState() {
    super.initState();
    FastingDatabase.getFasts().then((data) {
      setState(() {
        fasts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final contextWidth = MediaQuery.of(context).size.width;
    if (fasts == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: fasts?.length,
        itemBuilder: (BuildContext context, int i) {
          final fast = fasts?.reversed.toList()[i];
          final duration = fast?.end?.difference(fast.start).inHours ?? 0;
          final formattedDate = DateFormat.yMMMMd().format(fast?.start ?? DateTime.now());
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: contextWidth * 0.035, vertical: 0),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.all(contextWidth * 0.025),
              child: Text(
                '$duration h',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: contextWidth * 0.042,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              formattedDate,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: contextWidth * 0.05,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                int id = fast!.id;
                final res = await FastingDatabase.deleteFast(id);
                if (res) {
                  setState(() {
                    fasts?.removeWhere((fast) => fast.id == id);
                  });
                }
              },
            ),
          );
        },
      );
    }
  }


}
