import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  final FirebaseAuth _auth= FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user=event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:_user!=null?SizedBox():_googleSignInWidget() ,
    );
  }

  Widget _googleSignInWidget(){
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,text: "Sign in with google",
          onPressed:
            handleGoogleLogin
        ),
      ),
    );
  }


  void handleGoogleLogin(){
  try{
    GoogleAuthProvider _googleAuthProvider =GoogleAuthProvider();
    _auth.signInWithProvider(_googleAuthProvider);
  }catch(e){

  }
  }
}
