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
          /*SizedBox(height: 10 // To be decided later
              ),*/
          DrawerHeader(
            child: Container(
              // TO DO: Image(Have to be decided)
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/logo_dark.png"),
            ),
            decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          ),

          SizedBox(height: 45),
          
          Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 35),
          Text(
            'About',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 35),
          Text(
            'Log Out',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          // SizedBox(height: 35),
          // Text(
          //   'Log Out',
          //   style: TextStyle(
          //     fontFamily: 'Avenir',
          //     fontSize: 24,
          //     fontWeight: FontWeight.w700,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          SizedBox(height: 35),
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
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Center(
                  child: Text(
                    ' v1.0.1',  // TO DO: Version number to be decided 
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 20,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
