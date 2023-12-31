import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class SubScriptionHomeRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;

  const SubScriptionHomeRow(
      {super.key, required this.sObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 64,
        padding: const EdgeInsets.all( 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: TColor.border.withOpacity(0.15),
          ),

          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [

            const SizedBox(
              width: 8,
            ),
            Expanded(
              child:
              Text(
                sObj["resource"],
                style: TextStyle(
                    color: TColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "\₹${sObj["amount"]}",
              style: TextStyle(
                  color: TColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}