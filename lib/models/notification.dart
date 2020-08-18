
// {
//        "id": 1,
//        "job": 1,
//        "created": "2020-06-20T18:16:11.007398Z",
//        "creator": 1,
//        "user": 3,
//        "stars": 4,
//        "review": "First review"
//    }

 class MyNotification {
  int id;
  String date, username,notificationContent,userProfile;

  MyNotification(
      {this.id,
        this.date,
        this.username,
        this.notificationContent,
        this.userProfile,
});

  factory MyNotification.fromJson(Map json) => MyNotification(
      username: json['username'],
      date: json['date'],
      //username: json['username'],
      id: json['id'],
      notificationContent: json['notificationContent'],
      userProfile: json['userProfile']);
}
