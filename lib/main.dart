import 'package:admin_panel/screens/delivery_boy_screen.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/screens/admin_users.dart';
import 'package:admin_panel/screens/category_screen.dart';
import 'package:admin_panel/screens/login_screen.dart';
import 'package:admin_panel/screens/manage_banners.dart';
import 'package:admin_panel/screens/notification_screen.dart';
import 'package:admin_panel/screens/order_screen.dart';
import 'package:admin_panel/screens/settings_screen.dart';
import 'package:admin_panel/screens/splash_screen.dart';
import 'package:admin_panel/screens/vendor_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: "AIzaSyBlHpB7DyWaGfAFbdEots5nFRDKKkoTwn8",
      authDomain: "g-fresh-6c203.firebaseapp.com",
      projectId: "g-fresh-6c203",
      storageBucket: "g-fresh-6c203.appspot.com",
      messagingSenderId: "13437929733",
      appId: "1:13437929733:web:3794805c405cb392520f6c",
      measurementId: "G-9KJRKEPZ20"
    )
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'G-Fresh Admin Dashboard',
          theme: ThemeData(
            primaryColor: const Color(0xFF84c225),
          ),
          home:  const SplashScreen(),
        routes: {
            HomeScreen.id:(context)=>const HomeScreen(),
            SplashScreen.id:(context)=>const SplashScreen(),
            LoginScreen.id:(context)=>const LoginScreen(),
            BannerScreen.id:(context)=>const BannerScreen(),
            CategoryScreen.id:(context)=>const CategoryScreen(),
            OrderScreen.id:(context)=>const OrderScreen(),
            NotificationScreen.id:(context)=>const NotificationScreen(),
            AdminUsers.id:(context)=>const AdminUsers(),
            SettingScreen.id:(context)=>const SettingScreen(),
            VendorScreen.id:(context)=>const VendorScreen(),
            DeliveryBoyScreen.id:(context)=>const DeliveryBoyScreen(),
        },
        ),
    );
  }
}


