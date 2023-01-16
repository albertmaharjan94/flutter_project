import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Welcome",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/add-product");
                },
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(10),
                    child: Text("Add",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
              ))
        ],
      ),
    );
  }
}
