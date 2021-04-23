import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30 // To be decided later
              ),
          DrawerHeader(
            child: Container(
              // TO DO: Image(Have to be decided)
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/logo_dark.png"),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'To be Decided',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 45),
          Text(
            'To be Decided',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 45),
          Text(
            'To be Decided',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 45),
          Text(
            'To be Decided',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 45),
          Material(
            borderRadius: BorderRadius.circular(500),
            child: InkWell(
              borderRadius: BorderRadius.circular(500),
              splashColor: Colors.black45,
              onTap: () {
                Navigator.of(context).pop(); // To DO: close the drawer
              },
              child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors
                      .black, // TO DO: check the color and icon for closing drawer
                  child: Icon(Icons.arrow_back, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
