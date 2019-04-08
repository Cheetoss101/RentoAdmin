import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                border: Border(
                  top: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                  right: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                  bottom: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                  left: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                ),
                   borderRadius: new BorderRadius.all(Radius.circular(40.0))
                 ),
              child: Column(
                children: <Widget>[
                  FlatButton(
                      child: Icon(
                    Icons.supervised_user_circle,
                    size: 150,
                    color: Colors.deepOrange[800],
                  ),
                    onPressed: ()
                    {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  Text("User"),
                Text("Manegment"),
                SizedBox(height: 5,)
                ],
              ),
            ),
            SizedBox(height: 70,),
            Container(
              decoration: new BoxDecoration(
                border: Border(
                  top: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                  right: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                  bottom: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                  left: BorderSide(width: 5.0, color: Colors.deepOrange[800]),
                ),
                   borderRadius: new BorderRadius.all(Radius.circular(40.0))
                 ),
              child: Column(
                children: <Widget>[
                  FlatButton(
                      child: Icon(
                    Icons.data_usage,
                    size: 150,
                    color: Colors.deepOrange[800],
                  )),
                  Text("Item"),
                Text("Manegment"),
                SizedBox(height: 5,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
