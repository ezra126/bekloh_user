import 'package:flutter/material.dart';
import 'ease_in_widget.dart';

class BottomSheetButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final IconData iconData;

  const BottomSheetButton({Key key, this.text, this.iconData, @required this.onTap})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
 //   print(text);
    return RaisedButton(
      onPressed: onTap,
      child: Material(
        child: Container(
          padding: text != null
              ? EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0)
              : EdgeInsets.symmetric(vertical: 19.0, horizontal: 22.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 12.0,
                    spreadRadius: 0.1)
              ]),
          child: text != null
              ? Text(
            "$text",
            style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.white,
            ),
          )
              : Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}