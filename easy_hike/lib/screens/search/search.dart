import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/screens/search/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';
import 'search/../description.dart';
import 'search/../filter_bottom_sheet.dart';

class MainSearch extends StatefulWidget {
  @override
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: locator<AuthModel>(),
      child: Scaffold(
        drawer: Drawer(
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
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Icon(
            Icons.sort_rounded,
            color: Colors.black,
          ),
          title: Text('Back'),
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 15.0,
                child: Icon(Icons.account_circle),
              ),
            ),
            ScopedModelDescendant<AuthModel>(
              builder: (context, widget, model) => IconButton(
                color: Colors.black,
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  model.signOut();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Search for jobs',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25.0),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      style: const TextStyle(height: 0.5, fontSize: 14),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.highlight_remove_sharp,
                            color: Colors.grey,
                          ),
                          iconSize: 20.0,
                          color: Colors.black,
                          onPressed: () {
                            _controller.clear();
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromRGBO(234, 97, 97, 1),
                    ),
                    child: new IconButton(
                      icon: new Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        builder: (BuildContext context) => FilterBottomSheet(),
                        context: context,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'For You',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
              ),
              SizedBox(
                height: 25.0,
              ),
              JobTile(
                jobTitle: "Product Designer",
                company: "Google",
                location: "Cairo, Egypt",
                salary: "\$4500/mo",
                postTime: "2",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
