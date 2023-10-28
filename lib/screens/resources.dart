import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Search"),
          TextField(),
          Row(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: 100,
                child: Column(
                  children: [
                    Icon(Icons.add),
                    Text("Community"),
                  ],
                ),
                alignment: Alignment.center,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: 100,
                child: Column(
                  children: [
                    Icon(Icons.add),
                    Text("Community"),
                  ],
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
          // resourceWidget(),

          ListTile(
            title: Text("Top Resources"),
            subtitle: Text("Top Trending Post"),
            trailing: Icon(Icons.trending_up),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return resourceWidget();
                }),
          ),
          ListTile(
            title: Text("Fearured Resources"),
            subtitle: Text("Recommended For You"),
            trailing: Icon(Icons.supervisor_account),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return resourceWidget();
                }),
          ),
        ],
      ),
    );
  }

  Container resourceWidget() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1)),
      width: 200,
      height: 250,
      child: Column(
        children: [
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: NetworkImage(
                "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
              ),
              fit: BoxFit.cover,
              width: 200,
              height: 140,
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text("TRACTOR"),
                SizedBox(height: 3),
                Text("TRACTORTRACTOR,TRACTOR,TRACTOR,TRACTOR,,"),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.message_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.call),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
