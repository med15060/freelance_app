import 'package:freelance_app/view/pages/Progress/progress.dart';
import 'package:freelance_app/view/pages/account/account.dart';
import 'package:freelance_app/view/pages/chat/chat.dart';
import 'package:freelance_app/view/pages/create_job/create_job.dart';
import 'package:freelance_app/view/pages/homePage.dart';
import 'package:freelance_app/view/pages/job/job.dart';
import 'package:freelance_app/view/pages/login.dart';
import 'package:freelance_app/view/pages/messages/messages.dart';
import 'package:freelance_app/view/pages/notifications/notification.dart';
import 'package:freelance_app/view/pages/payment/payment.dart';
import 'package:freelance_app/view/pages/profile/profile.dart';
import 'package:freelance_app/view/pages/saller_profile/seller_profile.dart';
import 'package:freelance_app/view/pages/search/search.dart';
import 'package:freelance_app/view/pages/sign-up/sign-up.dart';
import 'package:freelance_app/view/pages/withDraw/with_draw.dart';

import '../view/pages/payment/pay.dart';

final routes={
  '/':(context)=>Login(),
  'signup':(context)=>SignUp(),
  'home':(context)=>HomePage(),
  'account':(context)=>AccountPage(),
  'chat':(context)=>ChatScreen(),
  'create_job':(context)=>CreateJob(),
  'job':(context)=>JobPage(),
  'messages':(context)=>MessagesPage(),
  'notification':(context)=>NotificationPage(),
  //'payment':(context)=>Paypal(),
  'profile':(context)=>JobPage(),
  'progress':(context)=>ProgressPage(),
  'seller_profile':(context)=>SellerProfile(),
  'search_page':(context)=>SearchPage(),
  'withdraw':(context)=>WithDrawPage(),
};