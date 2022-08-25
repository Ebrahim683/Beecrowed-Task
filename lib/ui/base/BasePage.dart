import 'package:beecrowd_task/ui/auth/LoginPage.dart';
import 'package:beecrowd_task/ui/base/alltask/AllTask.dart';
import 'package:beecrowd_task/ui/base/home/HomePage.dart';
import 'package:beecrowd_task/ui/base/profile/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  var selectedIndex = 0;
  var _pages = [HomePage(), AllTaskPage(), ProfilePage()];

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final List<NavigationRailDestination> destination = const [
    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
    NavigationRailDestination(
        icon: Icon(Icons.list_alt), label: Text('All Tasks')),
    NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
  ];

  appBarTitle(index) {
    if (index == 0) {
      return 'Home';
    } else if (index == 1) {
      return 'All Tasks';
    } else if (index == 2) {
      return 'Profile';
    }
  }

  logOut() async {
    try {
      await firebaseAuth.signOut();
      Get.off(LoginPage());
    } catch (e) {
      print('logout: $e');
      Get.snackbar('Error!!', '$e',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle(selectedIndex)),
        backgroundColor: Colors.red[400],
        automaticallyImplyLeading: false,
        actions: [
          //logout button
          GestureDetector(
            onTap: () {
              logOut();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            //navigation rail
            NavigationRail(
              backgroundColor: Colors.grey[900],
              indicatorColor: Colors.red[400],
              useIndicator: true,
              selectedIconTheme: const IconThemeData(
                color: Colors.yellow,
              ),
              unselectedIconTheme: const IconThemeData(
                color: Colors.grey,
              ),
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(color: Colors.yellow),
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.grey,
              ),
              destinations: destination,
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
            //pages
            Expanded(
              child: Container(
                child: _pages[selectedIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
