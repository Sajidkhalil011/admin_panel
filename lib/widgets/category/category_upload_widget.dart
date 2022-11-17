import 'dart:html';
import 'package:admin_panel/services/firebase_services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';

class CategoryCreateWidget extends StatefulWidget {
  const CategoryCreateWidget({Key? key}) : super(key: key);

  @override
  State<CategoryCreateWidget> createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreateWidget> {

  final FirebaseServices _services=FirebaseServices();
  final _fileNameTextController=TextEditingController();
  final _categoryNameTextController=TextEditingController();
  bool _imageSelected=true;
  bool _visible=false;
  String? _url;

  @override
  Widget build(BuildContext context) {

    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0xFF84c225).withOpacity(.3),
        animationDuration: Duration(milliseconds: 250));

    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,height: 30,
                      child: TextField(
                        controller: _categoryNameTextController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,width: 1
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'No Category Name Given',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20)
                        ),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(width: 200,height: 30,
                          child: TextField(
                        controller: _fileNameTextController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,width: 1
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'No image selected',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20)
                        ),
                      )),
                    ),
                    TextButton(
                      child: Text('Upload Image',style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        uploadStorage();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black54, // Background Color
                      ),
                    ),
                    SizedBox(width: 10,),
                    AbsorbPointer(
                      absorbing: _imageSelected,
                      child: TextButton(
                        child: Text('Save New Category',style: TextStyle(color: Colors.white),),
                        onPressed: ()async{
                          if(_categoryNameTextController.text.isEmpty){
                            return _services.showMyDialog(
                              context: context,
                              title: 'Add New Category',
                              message: 'New Category Name not given'
                            );
                          }
                          progressDialog.show();
                          _services.uploadCategoryImageToDb(_url, _categoryNameTextController.text).then((downloadUrl){
                            if(downloadUrl!=null){
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                title: 'New Category Image',
                                message: 'Saved New Category Successfully',
                                context: context,
                              );
                            }
                          });
                          _categoryNameTextController.clear();
                          _fileNameTextController.clear();
                        },
                        style:TextButton.styleFrom(
                          backgroundColor:_imageSelected ? Colors.black12:Colors.black54, // Background Color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visible?false:true,
              child: TextButton(
                child: Text('Add New Category',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  setState(() {
                    _visible=true;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black54, // Background Color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void uploadImage({required Function(File file) onSelected }){
    InputElement uploadInput=(FileUploadInputElement()..accept = 'image/*') as InputElement;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file=uploadInput.files!.first;
      final reader=FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
    //selected image
  }
  void uploadStorage(){
    //upload selected image to firebase storage
    final dateTime=DateTime.now();
    final path='CategoryImage/$dateTime';
    uploadImage(onSelected: (file){
      // ignore: unnecessary_null_comparison
      if(file!=null){
        setState(() {
          _fileNameTextController.text=file.name;
          _imageSelected=false;
          _url=path;
        });
        fb.storage().refFromURL('gs://g-fresh-6c203.appspot.com').child(path).put(file);
      }
    });
  }
}
