import 'package:flutter/material.dart';

class ChatItemWidget extends StatelessWidget {
  var index;

  ChatItemWidget(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (index % 2 == 0) {
      //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0)),
              margin: const EdgeInsets.only(right: 10.0),
              child: const Text(
                'This is a sent message',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]);
    } else {
      // This is a received message
      return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(8.0)),
              margin: const EdgeInsets.only(left: 10.0),
              child: const Text(
                'This is a received message',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }
  }
}
