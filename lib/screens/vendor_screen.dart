import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/vendor/vendor_datatable_widget.dart';
//import 'package:admin_panel/widgets/vendor_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class VendorScreen extends StatefulWidget {
  static  const String id ='vendor-screen';
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final SideBarWidget _sideBar=SideBarWidget();

  @override
  Widget build(BuildContext context) {

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title:  Text('G-fresh Dashboard',style: TextStyle(color: Colors.white),),
      ),
      sideBar: _sideBar.sideBarMenus(context,VendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          padding:  EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:   [
              Text(
                'Manage Vendors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Manage all vendors activities'),
              Divider(thickness: 4,),
              VendorDataTable(),
              Divider(thickness: 4,),
            ],
          ),
        ),
      ),
    );
  }
}
