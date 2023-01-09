import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_baz/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthViewModel _authViewModel;

  void checkLogin() async{
    await Future.delayed(Duration(seconds: 2));
    if(_authViewModel.user==null){
      Navigator.of(context).pushReplacementNamed("/login");
    }else{
      Navigator.of(context).pushReplacementNamed("/dashboard");
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
              Image.asset("images/splash.gif"),
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
