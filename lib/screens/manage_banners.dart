import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/banner/banner_upload_widget.dart';
import 'package:admin_panel/widgets/banner/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class BannerScreen extends StatelessWidget {
static const String id='banner-screen';

  const BannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SideBarWidget _sideBar=SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title:  Text('G-fresh Dashboard',style: TextStyle(color: Colors.white),),
      ),
      sideBar: _sideBar.sideBarMenus(context,BannerScreen.id),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          alignment: Alignment.topLeft,
          padding:  EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add / Delete Home Screen Banner Images'),
              Divider(thickness: 5,),
              //Banners
              BannerWidget(),
              Divider(thickness: 5,),
              BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
