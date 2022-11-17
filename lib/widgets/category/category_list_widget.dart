import 'package:admin_panel/services/firebase_services.dart';
import 'package:admin_panel/widgets/category/category_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseServices _services=FirebaseServices();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _services.category.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(child: Text('Something went wrong'),);
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document){
                return CategoryCard(document);
              }).toList(),
          );
        },
      ),
    );
  }
}
