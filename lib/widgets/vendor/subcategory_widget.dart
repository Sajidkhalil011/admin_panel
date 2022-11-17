import 'package:admin_panel/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;

  SubCategoryWidget(this.categoryName);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  FirebaseServices _services = FirebaseServices();
  var _subCatNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
            future: _services.category.doc(widget.categoryName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No Sub Categories found'),
                  );
                }

                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Main Category: '),
                              Text(
                                widget.categoryName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          Divider(
                            thickness: 3,
                          ),
                          //subcategory list
                        ],
                      ),
                    ),
                    Container(
                      //subcategory list
                      child: Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(data['subCat'][index]['name']),
                            );
                          },
                          itemCount: data['subCat'] == null
                              ? 0
                              : data['subCat'].length,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Add New Sub Category',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: TextField(
                                    controller: _subCatNameTextController,
                                    decoration: InputDecoration(
                                      hintText: 'Sub Category Name',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.only(left: 10),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (_subCatNameTextController.text.isEmpty) {
                                    return _services.showMyDialog(
                                      context: context,
                                      title: 'Add New SubCategory',
                                      message: 'Need to Give Sub Category Name',
                                    );
                                  }
                                  DocumentReference doc = _services.category
                                      .doc(widget.categoryName);
                                  doc.update({
                                    'subCat': FieldValue.arrayUnion([
                                      {'name': _subCatNameTextController.text}
                                    ]),
                                  });
                                  //if you want to see the update real time.
                                  setState(() {
                                    //it will rerun entire tree, so update will show
                                  });
                                  //after update clear edit text
                                  _subCatNameTextController.clear();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Colors.black54, // Background Color
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
