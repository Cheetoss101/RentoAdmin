import 'package:flutter/material.dart';
import 'package:rentoadmin/UIs/ItemPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemBlock extends StatelessWidget {
  String name, desc, id, imgURL, loc;
  int price;

  ItemBlock(this.name, this.desc, this.imgURL, this.loc, this.price, this.id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new ItemPage(this.id)),
          );
          //pushItem(item);
        },
        splashColor: Colors.orangeAccent,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: Color(0xFFE6E6E6)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  ItemImage(this.imgURL),
                  new Text("   "),
                  new Flexible(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      new Text(this.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            // fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 25.0,
                          )),
                      new Text("   "),
                      new Text(this.desc,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 20.0,
                          )),
                      new Text(" "),
                      new Container(
                        child: Row(
                          children: <Widget>[
                            new Icon(Icons.location_on),
                            new Text(this.loc,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 20.0,
                                )),
                            new Icon(Icons.monetization_on),
                            new Text(this.price.toString() + "SR/day",
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 20.0,
                                ))
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

class ItemImage extends StatelessWidget {
  @override
  String path;
  ItemImage(this.path);
  Widget build(BuildContext context) {
    var image = new CachedNetworkImage(
      imageUrl: path,
      // width: 80.0,
      // height: 80.0,
      fit: BoxFit.cover,
    );
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: new Stack(children: <Widget>[
        Container(
          height: 110.0,
          width: 100.0,
          child: image,
        ),
      ]),
    );
  }
}
