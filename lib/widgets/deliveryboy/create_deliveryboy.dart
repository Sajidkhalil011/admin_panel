import 'package:admin_panel/services/firebase_services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';

import '../../services/sidebar.dart';


class CreateNewBoyWidget extends StatefulWidget {
  const CreateNewBoyWidget({Key? key}) : super(key: key);

  @override
  State<CreateNewBoyWidget> createState() => _CreateNewBoyWidgetState();
}

class _CreateNewBoyWidgetState extends State<CreateNewBoyWidget> {
  final FirebaseServices _services = FirebaseServices();
  bool _visible = false;
  var emailText = TextEditingController();
  var passwordText = TextEditingController();

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
      child: Row(
        children: [
          Visibility(
            visible: _visible ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                child: TextButton(
                  child: Text(
                    'Create new Delivery Boy',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                    Colors.black54, // Background Color
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          //TODO: Email validator
                          controller: emailText,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email ID',
                              border: OutlineInputBorder(),
                              contentPadding:
                              EdgeInsets.only(left: 20)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: passwordText,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                              contentPadding:
                              EdgeInsets.only(left: 20)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (emailText.text.isEmpty) {
                            return _services.showMyDialog(
                                context: context,
                                title: 'Email ID',
                                message: 'Email Id not entered');
                          }
                          if (passwordText.text.isEmpty) {
                            return _services.showMyDialog(
                                context: context,
                                title: 'Password',
                                message: 'Password not entered');
                          }
                          if (passwordText.text.length < 6) {
                            //minimum 6 character
                            return _services.showMyDialog(
                                context: context,
                                title: 'Password',
                                message: 'Minimum 6 Character');
                          }
                          progressDialog.show();
                          _services.saveDeliverBoys(emailText.text, passwordText.text).whenComplete((){
                            emailText.clear();
                            passwordText.clear();
                            progressDialog.dismiss();
                            _services.showMyDialog(
                              context: context,
                              title: 'save Delivery Boy',
                              message: 'Saved Successfully',
                            );
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                          Colors.black54, // Background Color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
