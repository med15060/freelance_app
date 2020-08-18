import 'package:flutter/material.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/homePage.dart';
import 'package:freelance_app/view/pages/payment/widgets.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';




import 'package:webview_flutter/webview_flutter.dart';

class Paypal extends StatefulWidget {
  String id;
  Paypal(String linkforpayment, {Key key,this.id}) : super(key: key);

  @override
  _PaypalState createState(){
    var linkforpaypment=Api().AcceptOffer(this.id).toString();
    _PaypalState(id: this.id,linkforpaypment:linkforpaypment);

  }
}

class _PaypalState extends State<Paypal> {
  String id;

  String linkforpaypment;
  _PaypalState({this.id, String linkforpaypment});
  WebViewController _webViewController;
  TextEditingController _teController = new TextEditingController();
  bool showLoading = false;


  void updateLoading(bool ls) {
    this.setState((){
      showLoading = ls;
    });
  }

  @override
  Widget build(BuildContext context) {

    //String linkforpaypment = Api().AcceptOffer(this.id).toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar.appbar('Payment Gateway', centerTitle: true, actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          ),
        ),
      ]
//        leading: IconButton(
//            icon: Icon(Icons.menu),
//            onPressed: () => Scaffold.of(context).openDrawer()),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              /* Flexible(
                flex: 1,
                child: Container(
                  color: Colors.deepOrange,
                 *//* child: Padding(
                    //padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                      *//**//*  Flexible(
                          flex: 4,
                          child: TextField(
                            autocorrect: false,
                            style: TextStyle(color: Colors.white,fontSize: 20),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2
                                  ),
                                )
                            ),
                            controller: _teController,
                          ),
                        ),*//**//*
                        *//**//*Flexible(
                          flex: 1,
                          child: Center(
                            child: IconButton(icon: Icon(Icons.arrow_forward,color: Colors.white,), onPressed: (){
                              String finalURL = _teController.text;
                              if(!finalURL.startsWith("https://")){
                                finalURL = "https://"+finalURL;
                              }
                              if(_webViewController != null){
                                updateLoading(true);
                                _webViewController.loadUrl(finalURL).then((onValue){

                                }).catchError((e){
                                  updateLoading(false);
                                });
                              }
                            }),
                          ),
                        )*//**//*
                      ],
                    ),
                  ),*//*
                ),
              ),*/
              Flexible(
                  flex: 9,
                  child: Stack(
                    children: <Widget>[
                      WebView(
                        initialUrl:this.linkforpaypment,
                        onPageFinished: (data){
                          updateLoading(false);
                        },

                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (webViewController){
                          _webViewController = webViewController;
                        },
                      ),
                      (showLoading)?Center(child: CircularProgressIndicator(),):Center()
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*

import 'package:flutter/material.dart';
import'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PayPalPayment extends StatefulWidget {
  @override
  _PayPalPaymentState createState() => _PayPalPaymentState();

}

class _PayPalPaymentState extends State<PayPalPayment> {
  String test = "Test Charge";
  int amount = 100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebviewScaffold(
        url: new Uri.dataFromString('''
       <html>
       <head>
       <meta name="viewport" content="width=device-width, initial-scale=1">
       <meta http-equiv="X-UA-Compatible" content="IE=edge" />
       </head>

      <body>
      <script
        src="https://www.paypal.com/sdk/js?client-id=">
      </script>
      <script>paypal.Buttons().render('body');</script>
      </body>
       </html>
                ''', mimeType: 'text/html').toString(),      ),
    );
  }
}

*/



















class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int paymentMethodIndex;
  void changePaymentMethod(int index) {
    setState(() {
      paymentMethodIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appbar("Payment",
          centerTitle: true, leading: CustomBackButton()),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => changePaymentMethod(0),
                  child: PaymentMethods(
                    image: 'credit',
                    isActive: paymentMethodIndex == 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () => changePaymentMethod(1),
                    child: PaymentMethods(
                      image: 'money',
                      isActive: paymentMethodIndex == 1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => changePaymentMethod(2),
                  child: PaymentMethods(
                    image: 'master',
                    isActive: paymentMethodIndex == 2,
                  ),
                ),
              ],
            ),
            CustomTextField(
              margin: const EdgeInsets.only(top: 20),
              child: DropdownButton(
                items: [],
                onChanged: (v) {},
                hint: Text(
                  'Card',
                  style: TextStyle(color: fontGreyColor, fontSize: 16),
                ),
                isExpanded: true,
                underline: Container(),
              ),
            ),
            CustomTextField(
              margin: const EdgeInsets.only(top: 20),
              hint: "Card Number",
            ),
            CustomTextField(
              margin: const EdgeInsets.only(top: 20),
              hint: "Name",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  width: Dimensions.width(38),
                  margin: const EdgeInsets.only(top: 20),
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10
                    ),
                    child: Text(
                      "Date",
                      style: TextStyle(
                        color: fontGreyColor,
                      ),
                    ),
                  ),
                  hint: "mm/yy",
                ),
                SizedBox(
                  width: Dimensions.width(4),
                ),
                CustomTextField(
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Date",
                      style: TextStyle(
                        color: fontGreyColor,
                      ),
                    ),
                  ),
                  width: Dimensions.width(38),
                  margin: const EdgeInsets.only(top: 20),
                  hint: "***",
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            RoundedCornerButton(
              text: "Save",
              onPress: () {},
              width: Dimensions.width(60),
            )
          ],
        ),
      ),
    );
  }
}
