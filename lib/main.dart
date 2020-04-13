import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/db.dart';
import 'package:habit/pages/habits/habits.dart';
import 'package:habit/pages/home/home.dart';
import 'package:habit/pages/login/login.dart';
import 'package:habit/pages/settings/settings.dart';
import 'package:habit/pages/statistics/statistics.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const _title = 'Powerful Habits';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged)
      ],
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: MyHomePage(title: _title),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomSelectedIndex = 0;
  FirebaseUser _user;

  setUser(FirebaseUser user) {
    _user = user;
  }

  bool isLoggedIn() {
    return _user != null;
  }

  buildBottomNavigation() {
    if (isLoggedIn()) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      );
    }

    return null;
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.home), title: new Text('Home')),
      BottomNavigationBarItem(
        icon: new Icon(Icons.assignment_turned_in),
        title: new Text('Habits'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.trending_up), title: Text('Statistics')),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings), title: Text('Settings'))
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    if (isLoggedIn()) {
      return PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: <Widget>[
          Home(user: _user),
          HabitsPage(user: _user, databaseService: DatabaseService()),
          Statistics(),
          Settings(user: _user),
        ],
      );
    }

    return Login();
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    setUser(Provider.of<FirebaseUser>(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }
}
