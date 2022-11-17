import 'package:admin_panel/services/firebase_services.dart';
import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/deliveryboy/create_deliveryboy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../widgets/deliveryboy/approved_boys.dart';
import '../widgets/deliveryboy/news_boys.dart';

class DeliveryBoyScreen extends StatelessWidget {
  static const String id='deliveryboy-screen';
  const DeliveryBoyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SideBarWidget _sideBar = SideBarWidget();
    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: const Text(
            'G-fresh Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
        sideBar: _sideBar.sideBarMenus(context, DeliveryBoyScreen.id),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery Boys',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Create new Delivery Boys & Manage all Delivery Boys'),
                Divider(
                  thickness: 5,
                ),
                CreateNewBoyWidget(),
                Divider(
                  thickness: 5,
                ),
                //list of delivery boys
                TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(text: 'NEW',),
                    Tab(text: 'APPROVED',),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        NewBoys(),
                        ApprovedBoys(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
