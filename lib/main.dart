import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/view/pages/pick_location.dart';
import 'package:freelance_app/view/pages/sign-up/sign-up.dart';
import 'package:freelance_app/view/pages/splachscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/routes.dart';
import 'view/pages/Progress/progress.dart';
import 'view/pages/account/account.dart';
import 'view/pages/chat/chat.dart';
import 'view/pages/offers/offers.dart';
import 'view/pages/homePage.dart';
import 'view/pages/job/job.dart';
import 'view/pages/login.dart';
import 'view/pages/notifications/notification.dart';
import 'view/pages/payment/payment.dart';
import 'view/pages/profile/profile.dart';
import 'view/pages/saller_profile/seller_profile.dart';
import 'view/pages/search/search.dart';
import 'view/pages/withDraw/with_draw.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/colors.dart';
import 'view/pages/messages/messages.dart';
import 'package:freelance_app/models/user.dart';

SharedPreferences sp;
void main() async{
  // runApp(
  // DevicePreview(builder:(context)=>App())
  // );
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  runApp(App());
}

User myUser;

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  bool isUserLogged() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool logged = isUserLogged();
    return MaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      //routes: routes,
      theme: ThemeData(
          scaffoldBackgroundColor: background,
          primaryColor: primary,
          primarySwatch: colorCustom,
          iconTheme: IconThemeData(color: fontColor),
          appBarTheme: AppBarTheme(
              color: background,
              elevation: 0,
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
                      fontSize: 20,
                      letterSpacing: 0.3)),
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
          textTheme: TextTheme(
              bodyText2: TextStyle(color: fontColor),
              bodyText1: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fontColor)
                  .apply(),
              headline1: GoogleFonts.montserrat(
                      fontSize: 50, fontWeight: FontWeight.w900,color: fontnew)
                  .apply()),
          fontFamily: GoogleFonts.openSans().fontFamily),
      home:  isUserLogged() ? HomePage() : MyApp(),

//      home: ChatScreen(
//        senderId: "test@gmail.com",
//        recieverName: "Med Sidi",
//        recieverId: "raxi.akbar@hotmail.com",
//        senderName: "Muhammad Razi",
//        image:
//            "https://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg",
//      ),
    );
  }

  static Map<int, Color> color = {
    50: Color.fromRGBO(88, 99, 249, .1),
    100: Color.fromRGBO(88, 99, 249, .2),
    200: Color.fromRGBO(88, 99, 249, .3),
    300: Color.fromRGBO(88, 99, 249, .4),
    400: Color.fromRGBO(88, 99, 249, .5),
    500: Color.fromRGBO(88, 99, 249, .6),
    600: Color.fromRGBO(88, 99, 249, .7),
    700: Color.fromRGBO(88, 99, 249, .8),
    800: Color.fromRGBO(88, 99, 249, .9),
    900: Color.fromRGBO(88, 99, 249, 1),
  };
  final MaterialColor colorCustom = MaterialColor(0x5C3BFE, App.color);
}
