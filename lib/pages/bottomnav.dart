import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart_app/pages/add_to_cart.dart';
// import '/pages/Order.dart';
import '/pages/home.dart';
import '/pages/profile.dart';
import '/pages/Order.dart';

class BottomNav extends StatefulWidget {
  final String email;
  const BottomNav({Key? key, required this.email}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home HomePage;
  late CartPage cartPage;
  late Order OrderPage;
  late Profile profile;

  int currentTabIndex = 0;

  @override
  void initState() {
    HomePage = Home(email: widget.email);
    cartPage = CartPage(
      userEmail: widget.email,
    );
    OrderPage = Order(
      userEmail: widget.email,
    );
    profile = Profile(email: widget.email);
    pages = [HomePage, cartPage, OrderPage, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Color(0xfff2f2f2),
          color: Colors.purple,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outlined,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
