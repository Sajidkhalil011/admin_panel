import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:admin_panel/services/firebase_services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';

class BannerUploadWidget extends StatefulWidget {
  const BannerUploadWidget({Key? key}) : super(key: key);

  @override
  State<BannerUploadWidget> createState() => _BannerUploadWidgetState();
}

class _BannerUploadWidgetState extends State<BannerUploadWidget> {
  final FirebaseServices _services=FirebaseServices();
  final _fileNameTextController=TextEditingController();
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
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(width: 300,height: 30,child: TextField(
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
                        child: Text('Save Image',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          progressDialog.show();
                          _services.uploadBannerImageToDb(_url).then((downloadUrl){
                            if(downloadUrl!=null){
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                title: 'New Banner Image',
                                message: 'Saved Banner Image Successfully',
                                context: context,
                              );
                            }
                          });
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
                child: Text('Add New Banner',style: TextStyle(color: Colors.white),),
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
    final path='bannerImage/$dateTime';
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
