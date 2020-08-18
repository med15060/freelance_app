import 'package:flutter/material.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/search/widgets.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocation extends StatelessWidget {
  const PickLocation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(31.7917, 7.0926),
              zoom: 12,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height(10),
              horizontal: 20,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 3,
                            offset: Offset(3, 3))
                      ]),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        color: Color.fromRGBO(255, 95, 87, 1),
                      ),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                      IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                RoundedCornerButton(
                  text: "Save",
                  onPress: () {},
                  width: Dimensions.width(60),
                )
              ],
            ),
          )
        ],
      ),
    );
    */
  }
}
