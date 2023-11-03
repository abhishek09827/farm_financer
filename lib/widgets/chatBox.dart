import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class ChatBox extends StatelessWidget {
  final bool isResponse;
  final String title;

  ChatBox({Key? key,required this.isResponse, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: isResponse ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [

        Card(
            // style: ButtonStyle(
            //     elevation: MaterialStateProperty.all(25),
            //     shadowColor: MaterialStateProperty.all(color2),
            //
            //     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            //     fixedSize: MaterialStateProperty.all(Size(media.width, 50)),
            //     backgroundColor: MaterialStateProperty.all(color)
            // ),
            // onPressed: onPressed,
            child: Text(title).text.color(Colors.white).size(18).make(),
          color: isResponse ? Colors.white10: Colors.white54,

        ),
      ],
    );
  }
}
