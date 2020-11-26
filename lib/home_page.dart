import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.navigation,
              color: Colors.black,
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: Colors.black54,
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.black54,
            ),
            title: Text(""),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              left: 40,
            ),
            child: Text(
              "Find your \nnext vacation",
              style: TextStyle(
                  letterSpacing: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  fontSize: 25),
            ),
          ),
          Expanded(
            child: PageViewWidget(),
          )
        ],
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  List<VacationBean> _list = VacationBean.generate();
  PageController pageController;
  double viewportFraction = 0.8;
  double pageOffset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        double scale = max(viewportFraction,
            (1 - (pageOffset - index).abs()) + viewportFraction);
        double angle = (pageOffset - index).abs();
        if (angle > 0.5) {
          angle = 1 - angle;
        }

        return Container(
          padding: EdgeInsets.only(
            right: 10,
            left: 20,
            top: 100 - scale * 25,
            bottom: 50,
          ),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: Material(
              elevation: 2.0,
              child: Image.network(
                _list[index].url,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                alignment: Alignment((pageOffset - index).abs() * 0.5, 0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class VacationBean {
  String url;
  String name;

  VacationBean(this.url, this.name);

  static List<VacationBean> generate() {
    return [
      VacationBean(
          "https://images.pexels.com/photos/4557398/pexels-photo-4557398.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
          "Japan"),
      VacationBean(
          "https://images.pexels.com/photos/4814744/pexels-photo-4814744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          "Franch"),
      VacationBean(
          "https://images.pexels.com/photos/2804282/pexels-photo-2804282.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          "Paris"),
      VacationBean(
          "https://images.pexels.com/photos/5610399/pexels-photo-5610399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          "London"),
      VacationBean(
          "https://images.pexels.com/photos/4876309/pexels-photo-4876309.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          "China"),
    ];
  }
}
