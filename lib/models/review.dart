// {
//        "id": 1,
//        "job": 1,
//        "created": "2020-06-20T18:16:11.007398Z",
//        "creator": 1,
//        "user": 3,
//        "stars": 4,
//        "review": "First review"
//    }

class Review {
  int id, job, user, stars, creator;
  String created, review;

  Review(
      {this.id,
      this.review,
      this.job,
      this.user,
      this.stars,
      this.creator,
      this.created});

  factory Review.fromJson(Map json) => Review(
      user: json['user'],
      created: json['created'],
      job: json['job'],
      id: json['id'],
      stars: json['stars'],
      creator: json['creator'],
      review: json['review']);
}
