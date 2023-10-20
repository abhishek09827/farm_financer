import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final Color color2;
  final String title;

  PrimaryButton({Key? key, required this.color, required this.onPressed, required this.title, required this.color2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(25),
            shadowColor: MaterialStateProperty.all(color2),

            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            fixedSize: MaterialStateProperty.all(Size(media.width, 50)),
            backgroundColor: MaterialStateProperty.all(color)
        ),
        onPressed: onPressed,
        child: Text(title).text.color(Colors.white).size(18).make()
    );
  }
}
