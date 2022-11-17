import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/category/category_list_widget.dart';
import 'package:admin_panel/widgets/category/category_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class CategoryScreen extends StatelessWidget {
  static const String id='category-screen';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar=SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text('G-fresh Dashboard',style: TextStyle(color: Colors.white),),
      ),
      sideBar: _sideBar.sideBarMenus(context,CategoryScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add New Categories and Sub Categories'),
              Divider(thickness: 4,),
              CategoryCreateWidget(),
              Divider(thickness: 4,),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
