import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/cancel_job/cancel_job.dart';
import 'package:freelance_app/view/pages/job/widgets.dart';
import 'package:freelance_app/view/pages/job_progress/widgets.dart';
import 'package:freelance_app/view/widgets/auth_header.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/models/review.dart';
import 'package:freelance_app/models/job.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelance_app/api/api.dart';

class JobProgress extends StatefulWidget {
  final Job data;
  const JobProgress({Key key, this.data}) : super(key: key);

  @override
  _JobProgressState createState() => _JobProgressState();
}

class _JobProgressState extends State<JobProgress> {
  TextEditingController cntrlReview = new TextEditingController();
  double _rating;

  showReviewDialog(context) {
    showDialog(
        context: (context),
        barrierDismissible: true,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextField(
                      textEditingController: cntrlReview,
                      expandes: true,
                      height: Dimensions.height(10),
                      hint: "Review",
                    ),

                    RatingBar(
                      onRatingChanged: (rating) =>
                          setState(() => _rating = rating),
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: true,
                      filledColor: Colors.green,
                      emptyColor: Colors.redAccent,
                      halfFilledColor: Colors.amberAccent,
                      size: 48,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedCornerButton(
                      text: "Submit",
                      onPress: () => Navigator.pop(context),
                      width: Dimensions.width(40),
                      color: primary,
                    ),

//                  ReviewItem(text: "service", rating: 0),
//                  ReviewItem(text: "Buy Again", rating: 0),
                  ],
                ),
              ),
            )).then((val) {
      setState(() {});
      print(cntrlReview.text);
      print(_rating);

      ProgressDialog pr = ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: false);

      pr.style(
          textAlign: TextAlign.left,
          message: '  Updating Job .... ',
          borderRadius: 0.5,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.white,
          ),
          elevation: 1.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 5.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w200),
          messageTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 13.0,
              fontWeight: FontWeight.w600));
      if (cntrlReview.text != null && _rating != null)
        pr.show().then((value) async {
          //try {
          // int jobId,
          //      int userId,
          //      String review,
          //      double stars,
          //      int creator
          Api()
              .closeJob(widget.data.id, widget.data.assigned_to,
                  cntrlReview.text, _rating, widget.data.creator)
              .then((value) {
            pr.hide();
            if (value) {
              Fluttertoast.showToast(
                  msg: "Job successfully closed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
              cntrlReview.clear();
            } else
              Fluttertoast.showToast(
                  msg: "Unable to close job at the moment",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
          });
        });
      else
        Fluttertoast.showToast(
            msg: "Review and rating required to close the job",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AuthHeader(
            title: "Job",
            bottomMargin: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.data.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.data.description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: Dimensions.height(4),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Specialize(
                      color: Colors.white,
                      text: widget.data.specialize,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                JobDetailsWidget(
                  text1: "Offer Id",
                  text2: widget.data.accepted_offer_id.toString(),
                  text3: "Start Time:",
                  text4: widget.data.start_time,
                ),
                SizedBox(
                  height: 10,
                ),
                JobDetailsWidget(
                  text1: "Status",
                  text2: widget.data.completed ? "Completed" : "In Progress",
                  text3: "Job Created",
                  text4: widget.data.created==null?"":widget.data.created.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.data.completed
                    ? FutureBuilder(
                        future: Api().getJobReview(widget.data.id),
                        builder: (BuildContext context,AsyncSnapshot<List<Review>> snapshot) {
                          if (!snapshot.hasData)
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          else if (snapshot.hasData)
                            return JobDetailsWidget(
                              text1: "Stars",
                              text2: snapshot.data[0].stars.toString(),
                              text3: "Review",
                              text4: snapshot.data[0].review
                            );
                          else
                            return Container(
                              child: Center(
                                child: Text("Unable to get the review"),
                              ),
                            );
                        })
                    : Container(),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          SizedBox(
            height: 30,
          ),
          widget.data.completed
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundedCornerButton(
                      text: "Completed",
                      onPress: () {



                      },
                      width: Dimensions.width(40),
                      color: Colors.lightGreenAccent,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundedCornerButton(
                      text: "Accept work",
                      onPress: () {
                        Api().updateJob(widget.data.id);//  showReviewDialog(context);
                      },
                      width: Dimensions.width(40),
                      color: primary,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RoundedCornerButton(
                      text: "Cancel job",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CancelJob(
                                )),
                        );

                      },
                      width: Dimensions.width(40),
                      color: Color.fromRGBO(255, 95, 87, 1),
                    ),
                  ],
                ),
          SizedBox(
            height: Dimensions.height(10),
          ),
        ],
      ),
    );
  }
}
