import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rentoadmin/api/FirestoreServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentoadmin/components/GoogleMap.dart';
import 'package:rentoadmin/components/ImageSlider.dart';
import 'dart:math';
import 'package:rentoadmin/components/ProfileCard.dart';
import 'package:rentoadmin/api/services.dart';

class ItemPage extends StatefulWidget {
  final String itemID;
  ItemPage(this.itemID);
  State<StatefulWidget> createState() {
    return RentItemState(itemID);
  }
}

class RentItemState extends State<ItemPage> {
  final String itemID;
  RentItemState(this.itemID);
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  DateTime _fdate = new DateTime.now();
  TimeOfDay _ftime = new TimeOfDay.now();

  String _sellerID;
  String _itemID;
  String _name = "Rent Item";
  String _location = "None";
  String _decription = "None";
  String _category = "None";
  double _rate = 0.0;
  int _price = 0;
  String _path = "";
  int _code = 1000 + Random().nextInt(9999 - 1000);

  @override
  Widget build(BuildContext context) {
    //build function returns a "Widget"
    var description = new Card(
        child: Row(children: <Widget>[
      Expanded(
          child: FutureBuilder(
        future: FirestoreServices.getItemDetails(itemID),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildDetails(context, snapshot.data);
        },
      ))
    ]));

    final sizedBox = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: MediaQuery.of(context).size.height - 166,
        child: description,
      ),
    );
    final center = new Center(
      child: sizedBox,
    );
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          title: new Text(
        "$_name",
      )),
      body: Column(
        children: <Widget>[
          center,
          new Builder(builder: (BuildContext context) {
            bottomNavigationBar:
            return BottomNavigationBar(
              onTap: (int) {},
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                      icon: Icon(Icons.highlight_off),
                      onPressed: () {
                        _showDialogBan();
                      }),
                  title: Text('Ban'),
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(Icons.insert_emoticon),
                    onPressed: () {
                      _showDialogUnban();
                    },
                  ),
                  title: Text('UnBan'),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context, DocumentSnapshot data) {
    this._name = data['name'];
    this._location = data['location'];
    this._decription = data['description'];
    this._path = data['photo'];
    this._price = data['price'];
    this._category = data['category'];
    this._sellerID = data['sellerID'];
    int count = data['RateCount'];
    int totalRate = data['Rate'];
    //make sure no divisin by zero happens
    this._rate = count == 0 ? 0 : totalRate / count;
    //rate calculation end

    print(_path);
    print(_name);

    return ListView(
      children: <Widget>[
        ImageSlider(widget.itemID, 200.0),
        SizedBox(height: 15),
        new Center(
          widthFactor: MediaQuery.of(context).size.width / 2,
          child: new ListTile(
            title: new Text(
              "$_name",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new ProfileCard(_sellerID),
        new Divider(
          color: Colors.redAccent,
          indent: 16.0,
        ),
        SizedBox(height: 15),
        new ListTile(
          title: new Text(
            "Description",
            style: new TextStyle(fontWeight: FontWeight.w400),
          ),
          subtitle: new Text("$_decription"),
        ),
        SizedBox(height: 15),
        new Divider(
          color: Colors.redAccent,
          indent: 16.0,
        ),
        SizedBox(height: 15),
        new ListTile(
          leading: new Icon(Icons.category),
          title: new Text("$_category"),
        ),
        new ListTile(
          title: new Text("$_price SR/day",
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 20.0,
              )),
          leading: new Icon(Icons.monetization_on),
        ),
        new ListTile(
          title: new Text("$_location ",
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 20.0,
              )),
          leading: new Icon(Icons.location_on),
        ),
        SizedBox(height: 15),
        new Divider(
          color: Colors.redAccent,
          indent: 16.0,
        ),
        SizedBox(height: 15),
        Container(
          height: 300,
          child: GoogleMaps(itemID),
        ),
        SizedBox(height: 15),
        new Divider(
          color: Colors.redAccent,
          indent: 16.0,
        ),
        SizedBox(height: 15),
        new ListTile(
          title: Text("Starting Date:"),
          subtitle: new IconButton(
              icon: new Icon(Icons.date_range),
              onPressed: () {
                //_selectDate(context);
              }),
          trailing: Text('${_date.year}${-_date.month}${-_date.day}'),
        ),
        new ListTile(
          title: Text("Ending  Date:"),
          subtitle: new IconButton(
              icon: new Icon(Icons.date_range),
              onPressed: () {
                //_selectDate1(context);
              }),
          trailing: Text('${_fdate.year}${-_fdate.month}${-_fdate.day}'),
        ),
        new ListTile(
          title: Text("Starting Date:"),
          subtitle: new IconButton(
              icon: new Icon(Icons.timer),
              onPressed: () {
                //_selectTime(context);
              }),
          trailing: Text('${_time.hour} :${_time.minute}'),
        ),
        new ListTile(
          title: Text("Ending Date:"),
          subtitle: new IconButton(
              icon: new Icon(Icons.timer),
              onPressed: () {
                //_selectTime1(context);
              }),
          trailing: Text('${_ftime.hour} :${_ftime.minute}'),
        ),
        new Divider(
          color: Colors.redAccent,
          indent: 16.0,
        ),
        new ListTile(
          title: new Text(
            "$_rate/5",
            style: new TextStyle(fontWeight: FontWeight.w400),
          ),
          leading: new Icon(Icons.star),
        ),
      ],
    );
  }

  _showDialogBan() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Text("Are you sure to ban the user"),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('confirm'),
              onPressed: () {
                FirebaseService.updateBanItem(this.itemID);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  _showDialogUnban() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Text("Are you sure to unban the user"),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('confirm'),
              onPressed: () {
                FirebaseService.updateUnbanItem(this.itemID);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}

class itemImage extends StatelessWidget {
  String path;
  itemImage(this.path);
  @override
  Widget build(BuildContext context) {
    print("IMAGE PATH $path");
    // TODO: implement build
    var image = new CachedNetworkImage(
      imageUrl: path,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
    );
    return Container(child: image);
  }
}

/// FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
