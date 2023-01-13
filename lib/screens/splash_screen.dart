import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_baz/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../services/local_notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthViewModel _authViewModel;

  void checkLogin() async{
    await Future.delayed(Duration(seconds: 2));
    // check for user detail first
    try{
      await _authViewModel.checkLogin();
      if(_authViewModel.user==null){
        Navigator.of(context).pushReplacementNamed("/login");
      }else{
        NotificationService.display(
          title: "Welcome back",
          body: "Hello ${_authViewModel.loggedInUser?.name},\n We have been waiting for you.",
        );
        Navigator.of(context).pushReplacementNamed("/dashboard");
      }
    }catch(e){
      Navigator.of(context).pushReplacementNamed("/login");
    }

  }
  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    checkLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/splash.gif"),
              SizedBox(height: 100,),
              Text("Bazz", style: TextStyle(
                fontSize: 22
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
