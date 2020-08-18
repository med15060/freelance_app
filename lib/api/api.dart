import 'package:freelance_app/models/order.dart';
import 'package:freelance_app/models/sellers.dart';
import 'package:freelance_app/models/transation.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:freelance_app/api/url.dart';
import 'package:freelance_app/models/user.dart';
import 'package:freelance_app/models/job.dart';
import 'package:freelance_app/models/offers.dart';
import 'package:freelance_app/models/review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelance_app/main.dart';
import 'package:dio/dio.dart';
import 'package:freelance_app/models/notification.dart';
class Api {
  Future login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences sp = await SharedPreferences.getInstance();
    //make HTTP REQUEST TO VERIFY CREDENTIALS
    print("MJD: CHECK LOGIN FOR " + LOGIN );

    try {
      http.Response res = await http.post(
        LOGIN,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: {"Content-Type": "application/json"},
      );
      //print(res.body);
      Map<String, dynamic> data = jsonDecode(res.body);
      print(data.toString());

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        print(data.toString());
        sp.setString("token",data["token"].toString());
        print(sp.getString("token"));
        if (data.containsKey("error")){
          print("contains error");
          return null;}
        else {
          //prefs.setString("user", res.body);
          //print(data.toString());
          //prefs.setString("token",data.toString().split(": ")[1].split("}")[0]);
          print("INTERNET OK");
          //print("MJD:DATA" + data.toString());
          print(data);
         sp.setString("token",data["token"].toString());
          //res =getDetails() as http.Response;
          //Map<String, dynamic> results = jsonDecode(res.body);
          myUser = User.fromJson(data);
          return myUser;
        }
      } else {
  print("contains error3");
  return null;
      }


    } catch (e) {
      print("contains error4");
      print(e);
      return null;
    }
  }

  Future getDetails() async {
    //make HTTP REQUEST TO VERIFY CREDENTIALS
    print("MJD: CHECK LOGIN FOR " + USER_DETAIL + "1/");

    try {
      final prefs = await SharedPreferences.getInstance();
      //final token = prefs.getInt("token");
      http.Response res = await http.get(
        USER_DETAIL,
          headers: {"Authorization": "Token "+prefs.getString("token"),"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        if (data.containsKey("error"))
          return null;
        else {
          return res;
        }
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
//    });
  }


  Future getSellerDetails() async {
    //make HTTP REQUEST TO VERIFY CREDENTIALS
    print("MJD: CHECK LOGIN FOR " + USER_DETAIL + "1/");

    try {
      final prefs = await SharedPreferences.getInstance();
      //final token = prefs.getInt("token");
      http.Response res = await http.get(
        USER_DETAIL,
        headers: {"Authorization": "Token "+prefs.getString("token"),"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        if (data.containsKey("error"))
          return null;
        else {
          return res;
        }
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
//    });
  }
  Future<List<Histoftransact>>  getSellerTransaction() async {
    //make HTTP REQUEST TO VERIFY CREDENTIALS
    print("MJD: CHECK LOGIN FOR " + TRANSACTIONS );

    try {
      final prefs = await SharedPreferences.getInstance();
      //final token = prefs.getInt("token");
      http.Response res = await http.get(
        USER_DETAIL,
        headers: {"Authorization": "Token "+prefs.getString("token"),"Content-Type": "application/json"},
      );


      if (res.statusCode == 200) {
          List data = jsonDecode(res.body);
          print("MJD:DATA" + data.toString());
          //print(data.toString());
          return data.map((item) => Histoftransact.fromJson(item)).toList();

      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
//    });
  }
  /*
  ̣password1
email
first_name
last_name
username
description
seller
phone
country
address
specializes
profile_picture
  **/


  Future signup(
      {String name,
        String lastname,
        String phone,
        String email,
        String hourlyRate = "",
        String password,
        String country,
        String state,
        String address,
        String zip,
        String userType,
        String distanceInMiles = "",
        String specializes = "",
        String description = ""}) async {
    //make HTTP REQUEST TO VERIFY CREDENTIALS
    //print("MJD: CHECK LOGIN FOR " + USER_DETAIL + "1/");

    try {
      http.Response res = await http.post(
        SIGNUP,
        body: jsonEncode({
          "first_name": name,
          "last_name": lastname,
          "phone": phone,
          "email": email,
          "hourly_rate": hourlyRate,
          "password1": password,
          "password2": password,
          "country": country,
          "state": state,
          "address": address,
          "zip": zip,
          "seller": userType,
          //"stars_value": "5",
          //"distance_in_miles": distanceInMiles,
          "specializes": specializes,
          "last_reviews": "",
          //"profile_picture": "",
          "description": description,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        if (data.containsKey("error"))
          return null;
        else {
          return true;
        }
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
//    });
  }











  Future<Job> getJob(String id) async {
    print(JOB_URL + "$id/");
    try {
      http.Response res = await http.get(JOB_URL + "$id/");

      if (res.statusCode == 200) {
        print("INTERNET OK");
        Map<String, dynamic> data = jsonDecode(res.body);
        print("MJD:DATA" + data.toString());
        print(data.toString());

        return Job.fromJson(data);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Job>> getAllJobs() async {
    try {
      print(sp.getString("token"));
      http.Response res = await http.get(JOB_URL,headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        print("MJD:DATA" + data.toString());
        //print(data.toString());
        return data.map((item) => Job.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Job>> getMyJobs(int id) async {
    try {
      http.Response res = await http.get(MY_JOBS ,headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        print("MJD:DATA" + data.toString());
        print(data.toString());

        return data.map((item) => Job.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Job>> getJobsCreated(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("Token "+sp.getString("token"));
    try {
      http.Response res = await http.get(JOBS_CREATED,headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        //print("MJD:DATA" + data.toString());
       print(data.toString());

        return data.map((item) => Job.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<List<MyNotification>> getNotifications() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("Token "+sp.getString("token"));
    try {
      http.Response res = await http.get(NOTIFICATION_URL,headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        //print("MJD:DATA" + data.toString());
        //print(data.toString());

        return data.map((item) => MyNotification.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Offer>> getAllOffers(int id) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      print(" this is òe qsking for offer offers"+sp.getString("token"));
      http.Response res = await http.get(GET_OFFERS_for_job + "$id/",headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        //print("MJD:DATA" + data.toString());
        //print(data.toString());
        print(data);

        return data.map((item) => Offer.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Seller>> getAllSellers() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //    return[Seller.fromJson({"id":1, "name":"asdad", "profile":"https://www.google.com/search?q=image&sxsrf=ALeKk001cMP_XzvAs2uvv_grPA_jmuaIfQ:1593800369715&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjEwYSH2bHqAhXPzKQKHf7yDRkQ_AUoAXoECAsQAw&biw=1280&bih=610#imgrc=I0zAF9TavGWK5M","rate":1.2,"description":"asdda"}),
    //        Seller.fromJson({"id":2, "name":"aaassdad", "profile":null,"rate":2.2,"description":"adsadsadsdda"}),
    //    Seller.fromJson({"id":3, "name":"asdadadd", "profile":null,"rate":3.2,"description":"asdda d adasd adas da"})].toList();
        try {//GET_SELLERS
          print("Token "+sp.getString("token"));
          var client = https.Client();
          //Dio dio = new Dio();
          https.Response res = await https.get(GET_SELLERS,headers: {"Authorization": "Token "+sp.getString("token")}); //
          print("res.data");
          print(res);
          if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        print("MJD:DATA" + data.toString());
        print(data.toString());

        return data.map((item) => Seller.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Offer>> getMyOffers(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      print(sp.getString("token"));
      http.Response res = await http.get(MY_OFFERS,headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"}); // + "$id"

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        print("MJD:DATA" + data.toString());
        print(data.toString());

        return data.map((item) => Offer.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Review>> getJobReview(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    try {
      http.Response res = await http.get(JOB_REVIEW + "$id",headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        print("REVIEW:DATA" + data.toString());
        print(data.toString());

        return data.map((item) => Review.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Review>> getUserReviews(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      http.Response res = await http.get(USER_REVIEWS + "$id",headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        print("REVIEW:DATA" + data.toString());
        print(data.toString());

        return data.map((item) => Review.fromJson(item)).toList();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }







  Future submitOffer(int jobId,  double offerAmount, int time,
      String message,) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    try {
      http.Response res = await http.post(CREATE_OFFER+"$jobId/",
          headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"},
          body: jsonEncode({
            "job": jobId,
            "price_per_hour": offerAmount,
            "offer_hours": time,
            "description": message,
          }));
      print(res.statusCode);
      Map response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (response.containsKey("error"))
          return response["error"];
        else
          return "Successfully submitted";
      } else
        return "Unable to submit offer";
    } catch (e) {
      print(e);
      return "Unable to submit offer";
    }
  }

  Future updateJob(
    int jobId,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      http.Response res = await http.post(UPDATE_JOB_STATUS + jobId.toString(),
          headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"},
          );
      print(res.statusCode);
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }




  Future<Order> AcceptOffer(
      String offerId,
      ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print("there is huge prob");
    try {

        http.Response res = await http.post(UPDATE_ORDER + offerId+"/",
            headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"},
            );
        if (res.statusCode == 200) {
          //Map response = jsonDecode(res.body);
          Map<String, dynamic> data = jsonDecode(res.body);
          //print("MJD:DATA" + data.toString());
          print(data.toString());

          return Order.fromJson(data);
       // return response["url_payment"].toString();
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }









  Future Hellperequest(
      String description,
      ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      http.Response res = await http.post(HELPREQUEST ,
          headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "application/json"},
          body: jsonEncode({
            "description": description,

          }));
      print(res.statusCode);
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }



  Future closeJob(
      int jobId, int userId, String review, double stars, int creator) async {
    try {
      http.Response res = await http.post(UPDATE_JOB_STATUS + jobId.toString(),
          headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "multipart/form-data;"},
          body: jsonEncode({
            "completed": true,
          }));

      http.Response response = await http.post(CREATE_REVIEW,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "job": jobId,
            "creator": creator,
            "user": userId,
            "stars": stars,
            "review": review
          }));
      print(res.statusCode);
      print(response.statusCode);
      if (res.statusCode == 200 && response.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future createJob(
      String description,
      String title,
      String address,
      String paymentMethod,
      String specialize,
      String jobPrice,
      String jobHours,
      String jobType,
      int userId) async {
    try {
      print(sp.getString("token"));
      print({
        "description": description,
        "job_budget": int.parse(jobPrice) ,
        "job_hours": int.parse(jobHours) ,

      }.toString());
      http.Response res = await http.post(CREATE_JOB,
          headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type": "multipart/form-data;"},
          body: jsonEncode({
            "description": description,
            "job_budget": int.parse(jobPrice) ,
            "job_hours": int.parse(jobHours) ,

          }));
      //"title": title,
      //"address": address,
      //"specialize": specialize,
      //"job_type": jobType,
      //"job_media": null,
      //"creator": userId
      print(res.statusCode);

      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      try {

        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "description": description,
          "job_budget": int.parse(jobPrice) ,
          "job_hours": int.parse(jobHours) ,

        });
        Response  response = await dio.post(CREATE_JOB, data: {
          "description": description,
          "job_budget": int.parse(jobPrice) ,
          "job_hours": int.parse(jobHours) ,

        },options: Options(headers: {"Authorization": "Token "+sp.getString("token"),"Content-Type":"multipart/form-data; boundary=<calculated when request is sent>"}));

        //FormData formdata = new FormData(); // just like JS
        //formdata.add("photos", new UploadFileInfo(_image, basename(_image.path)));
        //dio.post(uploadURL, data: formdata, options: Options(
        //headers: {
        //Headers.contentLengthHeader: postData.length, // set content-length
        //},
        //))
            //.then((response) => print(response))
            //.catchError((error) => print(error));
        print(response.statusCode);

        if (response.statusCode == 200) {
          return true;
        } else
          return false;


      }catch(e) {
        print(e);
        return null;
      }
      print(e);
      return false;
    }
  }
}
