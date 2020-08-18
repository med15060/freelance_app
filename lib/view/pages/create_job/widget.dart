import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class UploadedFileWidget extends StatelessWidget {
  final String filename;
  const UploadedFileWidget({Key key, this.filename}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Dimensions.width(80),
      height: Dimensions.height(6),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400],
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            filename,
            style: TextStyle(color: fontGreyColor),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: fontGreyColor,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
