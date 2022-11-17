import 'package:admin_panel/screens/delivery_boy_screen.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/screens/admin_users.dart';
import 'package:admin_panel/screens/category_screen.dart';
import 'package:admin_panel/screens/login_screen.dart';
import 'package:admin_panel/screens/manage_banners.dart';
import 'package:admin_panel/screens/notification_screen.dart';
import 'package:admin_panel/screens/order_screen.dart';
import 'package:admin_panel/screens/settings_screen.dart';
import 'package:admin_panel/screens/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideBarWidget{
  sideBarMenus(context,selectedRoute){
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        AdminMenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        AdminMenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: CupertinoIcons.photo,
        ),
        AdminMenuItem(
          title: 'Vendors',
          route: VendorScreen.id,
          icon: CupertinoIcons.group_solid,
        ),
        AdminMenuItem(
          title: 'Delivery Boy',
          route: DeliveryBoyScreen.id,
          icon: Icons.delivery_dining_outlined,
        ),
        AdminMenuItem(
          title: 'Categories',
          route: CategoryScreen.id,
          icon: Icons.category,
        ),
        AdminMenuItem(
          title: 'Orders',
          route: OrderScreen.id,
          icon: CupertinoIcons.cart_fill,
        ),
        AdminMenuItem(
          title: 'Send Notification',
          route: NotificationScreen.id,
          icon: Icons.notifications,
        ),
        AdminMenuItem(
          title: 'Admin Users',
          route: AdminUsers.id,
          icon: Icons.person_rounded,
        ),
        AdminMenuItem(
          title: 'Settings',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
        AdminMenuItem(
          title: 'Exit',
          route: LoginScreen.id,
          icon: Icons.exit_to_app
          ,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        color: const Color(0xff444444),
        child: const Center(
          child: Text(
            'MENU',
            style: TextStyle(letterSpacing: 2,
              color: Colors.white,fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child:  Center(
          child: Image.asset('images/logo-1.png',height: 60,),
        ),
      ),
    );
  }
}