import 'package:flutter/material.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/view/pages/search/widgets.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../widgets/appbar.dart';
import 'package:freelance_app/models/job.dart';
import 'package:freelance_app/view/pages/job_progress/job_progress.dart';
import 'package:freelance_app/view/pages/offers/offers.dart';
import 'package:freelance_app/view/pages/offer/offer.dart';
import 'package:freelance_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllJobsPage extends StatelessWidget {
  const AllJobsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.appbar("All Jobs",
            bottom: PreferredSize(
                child: AppBarBottom(),
                preferredSize:
                Size(Dimensions.width(100), Dimensions.height(20)))),
        body: FutureBuilder(
            future: Api().getAllJobs(),
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
                              print(myUser.usertype );
                              return InkWell(
                                child: UserSearch(data: snapshot.data[index]),
                                onTap: () {
                                  print(myUser);
                                  print(snapshot.data[index]);
                                  if (snapshot.data[index]
                                      .open) if (myUser.usertype == "true"){
                                    print(snapshot.data[index]);


                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OfferPage(
                                              data: snapshot.data[index])),
                                    );
                                  }

                                  else if  (!snapshot.data[index]
                                        .open) if (myUser.usertype == "false")
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OffersPage(
                                              data: snapshot.data[index])),
                                    );
                                  else if  (!snapshot.data[index]
                                      .open) if (myUser.usertype == "true")
                                    Fluttertoast.showToast(
                                        msg: "Job is closed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  else if  (!snapshot.data[index]
                                      .open) if (myUser.usertype == "true")
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
