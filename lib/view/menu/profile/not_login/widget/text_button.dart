import 'package:cakang/utils/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBtnAccount extends StatelessWidget {
  TextBtnAccount({
    super.key,
    required this.text,
    required this.textButton,
    required this.moveScreen,
  });

  String text;
  String textButton;
  Widget moveScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.overline,
          ),
          GestureDetector(
            onTap: (() {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => moveScreen),
                ((route) => false),
              );
            }),
            child: Text(
              textButton,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AllColor.buttonColor),
            ),
          ),
        ],
      ),
    );
  }
}
