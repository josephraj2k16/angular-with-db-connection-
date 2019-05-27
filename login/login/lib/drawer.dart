import 'package:flutter/material.dart';
import'./main1.dart';
import './steppermain.dart';
class DrawerFirst extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new DrawerOnly(),
      appBar: new AppBar(title: new Text("First Page"),),
      body: new Text("I belongs to First Page"),
    );
  }
}

class DrawerSecond extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new DrawerOnly(),
      appBar: new AppBar(title: new Text("Second Page"),),
      body: new Text("I belongs to Second Page"),
    );
  }
}

class DrawerOnly extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(

//        new CircleAvatar(
//          minRadius: 28.0,
//          maxRadius: 28.0,
//          backgroundImage: new AssetImage('images/patientpic.jpg'),
//        )
                accountName: Text("Patient Name"),
                accountEmail: Text("patient@gmail.com"),
//                currentAccountPicture:
//                    new AssetImage("images/patientpic.jpg'"),
                  //Image.network('https://hammad-tariq.com/img/profile.png'),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,

                ),
            ),
//            new DrawerHeader(
//              child: new Text("DRAWER HEADER.."),
//              decoration: new BoxDecoration(
//                  color: Colors.lightGreen,
//
//              ),
//            ),
            new ListTile(
              title: new Text("DashBoard"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new MyApp()));
              },
            ),
            new ListTile(
              title: new Text("My TimeLine"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new StepperPage()));
              },
            ),
          ],
        )
    );
  }
}