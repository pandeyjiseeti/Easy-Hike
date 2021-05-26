import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/models/job_model.dart';
import 'package:easy_hike/models/profile_model.dart';
import 'package:easy_hike/models/show_model.dart';
import 'package:easy_hike/models/user_model.dart';
import 'package:easy_hike/screens/search/job_tile.dart';
import 'package:easy_hike/screens/profile/profile.dart';
import 'package:easy_hike/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';
import 'package:intl/intl.dart';
import 'search/../filter_bottom_sheet.dart';
import 'package:easy_hike/screens/questions/personalintro.dart';

class MainSearch extends StatefulWidget {
  @override
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  TextEditingController _controller;
  GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _key = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: locator<AuthModel>(),
      child: ScopedModelDescendant<AuthModel>(
        builder: (BuildContext context, Widget child, AuthModel model) =>
            GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () async => buildAlertDialog(context, model),
            child: Scaffold(
              key: _key,
              drawer: NavigationDrawer(),
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(
                    Icons.sort_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () => _key.currentState.openDrawer(),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      ),
                    },
                    child: ScopedModel<ProfileModel>(
                      model: locator<ProfileModel>(),
                      child: ScopedModelDescendant<ProfileModel>(
                        builder: (context, child, ProfileModel model) =>
                            CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 23.0,
                          child: FutureBuilder(
                              future: model.setData(),
                              builder:
                                  (context, AsyncSnapshot<JobUser> snapshot) {
                                if (snapshot.hasData) {
                                  return Image.network(
                                    snapshot.data.profileImage,
                                    width: 28.0,
                                    fit: BoxFit.contain,
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  ScopedModelDescendant<AuthModel>(
                    builder: (context, widget, model) => IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        model.signOut();
                        Navigator.popAndPushNamed(context, '/login');
                      },
                    ),
                  ),
                ],
              ),
              body: ScopedModel<ShowModel>(
                model: locator<ShowModel>(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Search for jobs',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 28.0),
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
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]),
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
                                builder: (BuildContext context) =>
                                    FilterBottomSheet(),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Expanded(
                        child: ScopedModelDescendant<ShowModel>(
                          builder: (BuildContext context, Widget child,
                                  ShowModel model) =>
                              StreamBuilder<List<Job>>(
                                  stream: model.listJobs().asStream(),
                                  builder: (context, snapshot) {
                                    // print(snapshot.data);
                                    if (snapshot.hasData) if (snapshot
                                        .data.isNotEmpty)
                                      return ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                JobTile(
                                          description: snapshot.data[index],
                                          jobTitle: snapshot
                                              .data[index].jobPosition
                                              .toString(),
                                          company: snapshot.data[index].company
                                              .toString(),
                                          location: snapshot
                                              .data[index].location
                                              .toString(),
                                          salary:
                                              "\$${snapshot.data[index].salary}",
                                          postTime: (DateTime.now().day -
                                                  DateFormat('yMMMMd')
                                                      .parse(snapshot
                                                          .data[index]
                                                          .datePosted
                                                          .toString())
                                                      .day)
                                              .toString(),
                                        ),
                                      );
                                    else
                                      return Center(
                                        child: Text('No Jobs Posted Yet'),
                                      );
                                    else
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                  }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
