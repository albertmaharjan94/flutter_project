import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  void logout() async{
    _ui.loadState(true);
    try{
      await _auth.logout().then((value){
        Navigator.of(context).pushReplacementNamed('/login');
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        child: Text("Logout"),
        onPressed: (){
          logout();
        },
      ),
      body: Center(child: Container(
        child: Text("Dash"),
      )),
    );
  }
}
