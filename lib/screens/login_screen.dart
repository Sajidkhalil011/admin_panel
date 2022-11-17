import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/services/firebase_services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login-screen';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseServices _services=FirebaseServices();
  var _usernameTextController=TextEditingController();
  var _passwordTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0xFF84c225).withOpacity(.3),
        animationDuration: Duration(milliseconds: 250));

    _login({username,password})async{
      progressDialog.show();
      _services.getAdminCredentials(username).then((value) async {
        if(value.exists){
          if(value['username']==username){
            if(value['password']==password){
              //if both is correct, will login
              try{
                UserCredential userCredential=await FirebaseAuth.instance.signInAnonymously();
                if(userCredential!=null){
                  //if login success, will navigate to HomeScreen
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              }catch(e){
                //if login failed
                progressDialog.dismiss();
                _services.showMyDialog(
                  context: context,
                    title: 'Login',
                    message: '${e.toString()}'
                );
              }
              return;
            }
            //if password is incorrect
            progressDialog.dismiss();
            _services.showMyDialog(
              context: context,
                title: 'Incorrect Password',
                message: 'Password you have entered is invalid, try again');
            return;
          }
          //if username is incorrect
          progressDialog.dismiss();
          _services.showMyDialog(
              context: context,
              title: 'Invalid Username',
            message: 'Username you have entered is in correct, try again');
        }
        progressDialog.dismiss();
        _services.showMyDialog(
            context: context,
            title: 'Invalid Username',
            message: 'Username you have entered is in correct, try again');
      });
    }

    return Scaffold(
      body: FutureBuilder(
        //initialize FlutterFire:
        future: Firebase.initializeApp(),
        builder: (context,snapshot){
          //Check for errors
          //Once complete,show your application
          if(snapshot.connectionState==ConnectionState.done){
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF84c225),
                        Colors.white
                      ],
                      stops: [1.0,1.0],
                      begin: Alignment.topCenter,
                      end: Alignment(0.0,0.0)
                  )
              ),
              child: Center(
                child: Container(
                  width: 300,
                  height: 400,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color:Colors.green,width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child:Column(
                                children: [
                                  Image.asset('images/logo-1.png',height: 100,width: 100,),
                                  const Text('G-fresh Admin',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
                                  const SizedBox(height: 20,),
                                  TextFormField(
                                    controller: _usernameTextController,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter Username';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      prefixIcon: const Icon(Icons.person,color: Color(0xFF84c225),),
                                      focusColor: Theme.of(context).primaryColor,
                                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context).primaryColor,
                                              width: 2
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: _passwordTextController,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter Password';
                                      }
                                      if(value.length<6){
                                        return 'Minimum 6 characters';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Minimum 6 characters',
                                      prefixIcon: Icon(Icons.vpn_key_sharp,color: Color(0xFF84c225)),
                                      hintText: 'Password',
                                      focusColor: Theme.of(context).primaryColor,
                                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context).primaryColor,
                                              width: 2
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ) ,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()) {
                                        _login(
                                          username: _usernameTextController.text,
                                          password: _passwordTextController.text,
                                        );
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF84c225),
                                    ),
                                    child: Text('Login',style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          //Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }


}