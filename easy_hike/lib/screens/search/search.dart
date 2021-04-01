import 'package:easy_hike/screens/search/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 15.0,
              child: Icon(Icons.account_circle),
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
    );
  }
}
