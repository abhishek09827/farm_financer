import 'package:flutter/material.dart';

import '../util/constants.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../Core/constant.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {required this.controllerName,
      required this.hintText,
      required this.titleText,
      this.isEmail});

  final TextEditingController controllerName;
  final String hintText;
  final String titleText;
  bool? isEmail = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColor.appTextColorHeading,
            // fontFamily: Cons.appTextStyle,
          ),
        ),
        // 10.verticalSpace,
        SizedBox(
          height: 10,
        ),
        TextFormField(
            autofocus: false,
            onChanged: (value) {},
            textAlign: TextAlign.start,
            controller: controllerName,
            keyboardType: isEmail == true
                ? TextInputType.emailAddress
                : TextInputType.text,
            cursorColor: AppColor.black,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  // fontFamily: Cons.appTextStyle,
                  color: AppColor.black.withOpacity(0.4),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
              fillColor: AppColor.black,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColor.appTextFeildBorderColor,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColor.whiteGray,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColor.whiteGray,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColor.whiteGray,
                  width: 1.0,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              isDense: true,
            ),
            style: TextStyle(
                // fontFamily: Cons.appTextStyle,
                color: AppColor.black,
                fontWeight: FontWeight.w700,
                fontSize: 14)),
      ],
    );
  }
}
