import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});
  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Post"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 300,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined),
                    Text("Browse Files")
                  ]),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(12)),
            ),
            TextFormField(
                autofocus: false,
                controller: captionController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.phone,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.only(top: 14).r,
                  //   child: Text(
                  //     StringCons.rupee,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontFamily: Cons.appTextStyle,
                  //         color: Colors.appTextColorHeading,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 14.h),
                  //   ),
                  // ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  isDense: true,
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
            ElevatedButton(onPressed: () {}, child: Text("Post"))
          ],
        ),
      ),
    );
  }
}
