import 'package:collapsible_navigation_bar/collapsible_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Container(
        height: MediaQuery.of(context).size.height,
        child: Text("Page 1"),
        color: Colors.amberAccent,
      ),
      Text("Page 2"),
      Text("Page 3"),
      Text("Page 4"),
      Text("Page 5"),
      Text("Page 6"),
      Text("Page 7"),
      Text("Page 8"),
      Text("Page 9"),
      Text("Page 10"),
      Text("Page 11"),
      Text("Page 12"),
      Text("Page 13"),
      Text("Page 14"),
      Text("Page 15"),
    ];

    Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: CollapsibleNavigationBar(
              backgroundColor: Colors.black,
              upperIcons: [
                Icons.home,
                Icons.card_giftcard,
                Icons.camera,
                Icons.pie_chart,
              ],
              upperTitles: [
                "Title 1",
                "Title 2",
                "Title 3",
                "Title 4",
              ],
              lowerIcons: [
                Icons.pie_chart,
                Icons.home,
                Icons.card_giftcard,
                Icons.camera,
                Icons.pie_chart,
                Icons.person,
                Icons.person,
                Icons.home,
                Icons.card_giftcard,
                Icons.camera,
                Icons.pie_chart,
              ],
              lowerTitles: [
                "Title 5",
                "Title 6",
                "Title 7",
                "Title 8",
                "Title 9",
                "Title 10",
                "Title 11",
                "Title 12",
                "Title 13",
                "Title 14",
                "Title 15",
              ],
              activeElementColor: Colors.red,
              passiveactiveElementColor: Colors.grey,
              dropDownIconWhenClose: Icons.arrow_upward,
              dropDownIconWhenOpen: Icons.arrow_downward,
              dropDownTitle: "More",
              shadowColor: Colors.black12,
              pages: pages,
              onChange: (val) {
                setState(() {
                  currentPage = val;
                });
              },
              defaultSelectedIndex: 0,
              lineHeight: s.height * 0.07, // it's recommended lineHeight
            ),
          ),
        ],
      ),
    );
  }
}
