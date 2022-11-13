// import 'package:firebase_auth_login_youtube/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/login.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(
        // // appBar: AppBar(
        // //   title: Text('Firebase Login'),
        // // ),
        // body: Stack(
        //   alignment: Alignment.center,
        //   children: <Widget>[
        //     Container(color:Colors.red),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: <Widget>[
        //         Container(width: 200,height: 200,color: Colors.blue,),
        //         Stack(children: <Widget>[
        //           Container(width: 200,height: 200,color: Colors.amber,),
        //           Container(width: 100,height: 50,color: Colors.black,)
        //           ],),
        //         Container(width: 200,height: 200,color: Colors.white,),
        //       ],
        //     )
        //   ],
        // ),
        // // body: Center(child: Image(image: NetworkImage("https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg"),color: Colors.red,))
      ),
    );
  }
}
