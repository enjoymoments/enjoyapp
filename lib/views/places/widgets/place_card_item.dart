import 'package:flutter/material.dart';

class PlaceCardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(30.0),
      //padding: const EdgeInsets.all(10.0),
      decoration: myBoxDecoration(), //       <--- BoxDecoration here
      child: Text(
        "text",
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3.0),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //         <--- border radius here
          ),
    );
  }
}
