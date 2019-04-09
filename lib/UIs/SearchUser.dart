import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentoadmin/components/CustomShapeClipper.dart';
import 'package:flutter/material.dart';
import 'package:rentoadmin/api/FirestoreServices.dart';
import 'package:rentoadmin/components/ProfileCard.dart';
final Color discountBackgroundColor = Color(0xFFFFE08D);
final Color flightBorderColor = Color(0xFFE6E6E6);
final Color chipBackgroundColor = Color(0xFFF6F6F6);
String query;
Color firstColor = Colors.deepOrange;
Color secondColor = Colors.deepOrangeAccent;
const TextStyle dropDownLabelStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 16.0);
ThemeData appTheme =
    ThemeData(primaryColor: Colors.deepOrange, fontFamily: 'Oxygen');

class SearchPage extends StatefulWidget{
  _SearchPageState createState() => new _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  
 @override
  void initState() {
    // TODO: implement initState
    query = "";
    super.initState();
   
  }
  
  FlightListingBottomPartState bottom = new FlightListingBottomPartState();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Result",
          ),
          elevation: 0.0,
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              FlightListTopPart(this),
              FlightListingBottomPart(),
            ],
          ),
        ),
      );
  }
}

class FlightListingBottomPart extends StatefulWidget {
  @override
  FlightListingBottomPartState createState() {
    return new FlightListingBottomPartState();
  }
}

class FlightListingBottomPartState extends State<FlightListingBottomPart> {

  @override
  Widget build(BuildContext context) {
    print(query);
    return Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "",
              style: dropDownMenuItemStyle,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FutureBuilder(
            future: FirestoreServices.searchUser(query),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : _buildItems(context, snapshot.data.documents);
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildItems(BuildContext context, List<DocumentSnapshot> snapshots)
{
  return ListView.builder(
    shrinkWrap: true,
    itemCount: snapshots.length,
    physics: ClampingScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemBuilder: (context, i) {
      DocumentSnapshot doc = snapshots[i];
      return ProfileCard(doc.documentID);
    }
  );
}



class FlightListTopPart extends StatelessWidget {
 _SearchPageState refreach;
 FlightListTopPart(this.refreach);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient( begin: Alignment.topCenter, 
              end: Alignment.bottomCenter, 
              colors: [Colors.deepOrange[800], firstColor, secondColor]),
            ),
            height: 160.0,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        query = text;
                        //print(query);
                      },
                      style: dropDownMenuItemStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              this.refreach.setState((){}); 
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
          ],
        )
      ],
    );
  }
 
}