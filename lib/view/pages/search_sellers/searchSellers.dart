import 'package:flutter/material.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/models/sellers.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../widgets/appbar.dart';
import 'widgets.dart';

class SearchSellerPage extends StatelessWidget {
  const SearchSellerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.appbar("Sellers",
            bottom: PreferredSize(
                child: AppBarBottom(),
                preferredSize:
                    Size(Dimensions.width(100), Dimensions.height(20)))),
        body: FutureBuilder(
            future: Api().getAllSellers(),
            builder: (BuildContext context, AsyncSnapshot<List<Seller>> snapshot) {

              if (!snapshot.hasData){

                print(snapshot.data);
                print("hiii");
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                );
              }

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
                              print(snapshot.data[index]);
                              return
                              InkWell(
                                child: SellerSearch(data: snapshot.data[index]),
//                                onTap: () {
//                                  if (snapshot.data[index].open)
//                                    if (myUser.usertype == "seller")
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => OfferPage(
//                                              data: snapshot.data[index])),
//                                    );
//                                  else
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => OffersPage(
//                                              data: snapshot.data[index])),
//                                    );
//                                  else if (myUser.usertype == "seller")
//                                    Fluttertoast.showToast(
//                                        msg: "Job is closed",
//                                        toastLength: Toast.LENGTH_SHORT,
//                                        gravity: ToastGravity.BOTTOM,
//                                        timeInSecForIosWeb: 1,
//                                        backgroundColor: Colors.black,
//                                        textColor: Colors.white,
//                                        fontSize: 16.0);
//                                  else
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => JobProgress(
//                                              data: snapshot.data[index])),
//                                    );
//                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              else{
                return Container(child: Center(child: Text("No Seller")));}
            }));
  }
}
