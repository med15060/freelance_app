import 'package:flutter/material.dart';
import 'package:freelance_app/api/api.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../widgets/appbar.dart';
import 'package:freelance_app/models/job.dart';
import 'widgets.dart';
import 'package:freelance_app/view/pages/job_progress/job_progress.dart';
import 'package:freelance_app/view/pages/offers/offers.dart';
import 'package:freelance_app/view/pages/offer/offer.dart';
import 'package:freelance_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.appbar(myUser.usertype=="true"?'Search':"My Jobs",
//            leading: IconButton(
//                icon: Icon(Icons.menu),
//                onPressed: () => Scaffold.of(context).openDrawer()),
            bottom: PreferredSize(
                child: AppBarBottom(),
                preferredSize:
                    Size(Dimensions.width(100), Dimensions.height(20)))),
        body: FutureBuilder(
            future: myUser.usertype=="true"?Api().getAllJobs():Api().getJobsCreated(myUser.id),
            builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
              if (!snapshot.hasData)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                );
              else if (snapshot.hasData)
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width(2),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child : UserSearch(data: snapshot.data[index]),
                                onTap: () {print(snapshot.data[index].open);
                                print(snapshot.data[index].completed);
                                print(myUser.usertype);

                                 // return Container(child: Center(child: Text("No active job")));
                                  if (snapshot.data[index] != null // .open
                                     ) { if (myUser.usertype == "false" && snapshot.data[index].open==true)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OffersPage(
                                              data: snapshot.data[index])),
                                    );
                                  if (myUser.usertype == "false" && snapshot.data[index].open==false)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => JobProgress(
                                              data: snapshot.data[index])),
                                    );

                                  else if (myUser.usertype == "true")
                                    Fluttertoast.showToast(
                                        msg: "Job is closed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }

                                  else  //if (myUser.usertype == "false") if (snapshot.data[index].open==false)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => JobProgress(
                                              data: snapshot.data[index])),
                                    );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              else
                return Container(child: Center(child: Text("No active job")));
            }));
  }
}
