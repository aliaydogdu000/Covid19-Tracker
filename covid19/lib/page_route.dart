import 'package:flutter/material.dart';

import 'feature/constants/colors.dart';
import 'feature/views/global_view.dart';
import 'feature/views/searching_result.dart';

class PageRouting extends StatefulWidget {
  const PageRouting({Key? key}) : super(key: key);

  @override
  State<PageRouting> createState() => _PageRoutingState();
}

class _PageRoutingState extends State<PageRouting> {
  PageController? _pagecontroller;
  int _currentIndex = 0;

  @override
  void initState() {
    _pagecontroller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pagecontroller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: (currentPage) {
          setState(() {
            _currentIndex = currentPage;
          });
        },
        children: [
          MyHomePage(
            title: "GLOBAL",
          ),
          const MySearchPage()
        ],
      ),
      bottomNavigationBar: buildnavbar(),
    );
  }

  BottomNavigationBar buildnavbar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.public,
          ),
          label: 'Global',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.flag),
          label: 'Search Country',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (currentPage) {
        setState(() {
          _pagecontroller?.jumpToPage(currentPage);
        });
      },
      selectedItemColor: ColorScale().chColor5,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedIconTheme: IconThemeData(color: ColorScale().mainColor),
      unselectedLabelStyle: TextStyle(color: ColorScale().mainColor),
    );
  }
}
