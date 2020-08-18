import 'package:flutter/material.dart';
import 'package:freelance_app/view/pages/AllJobs/allJobs.dart';
import 'package:freelance_app/view/pages/account/account.dart';
import 'package:freelance_app/view/pages/create_job/create_job.dart';
import 'package:freelance_app/view/pages/job/job.dart';
import 'package:freelance_app/view/pages/login.dart';
import 'package:freelance_app/view/pages/messages/messages.dart';
import 'package:freelance_app/view/pages/notifications/notification.dart';
import 'package:freelance_app/view/pages/search/search.dart';
import 'package:freelance_app/view/pages/search_sellers/searchSellers.dart';
import 'package:freelance_app/view/widgets/bottom_nav.dart';
import 'package:freelance_app/view/widgets/drawer.dart';
import 'package:freelance_app/main.dart';
import 'package:freelance_app/view/pages/myoffers/myOffers.dart';
import 'package:freelance_app/view/pages/saller_profile/seller_profile.dart';

class HomePage extends StatefulWidget {
  final bool isSeller;
  HomePage({Key key,this.isSeller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(isSeller: this.isSeller);
}

class _HomePageState extends State<HomePage> {
  bool isSeller;

  _HomePageState({this.isSeller});
  int currentIndex = 0;
  List pages = [];
  @override
  void initState() {
    super.initState();
    if(this.isSeller)
      {
        pages = [
          AllJobsPage(),
          MyOffersPage(id: myUser.id),
          NotificationPage(),
          MessagesPage(),
          AccountPage(),
          SearchPage()
        ];

      }
    else{
      pages = [
        SearchSellerPage(),
        CreateJob(),
        NotificationPage(),
        MessagesPage(),
        AccountPage(),
        SearchPage()
      ];
    }
  }

  void changeCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.isSeller);
    return Scaffold(
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: currentIndex,
        onTab: changeCurrentIndex,
      ),
      body: pages[currentIndex],
    );
  }
}
