class Offer {
  // ignore: non_constant_identifier_names
  int id, job, user, offer_time;
  // ignore: non_constant_identifier_names
  double offer_amount;
  String created, message, user_name, specialize, stars_value,profile_url;

  Offer(
      {this.id,
      this.message,
      this.offer_amount,
      this.job,
      this.created,
      this.user,
      this.offer_time,
      this.specialize,
      this.stars_value,
      this.user_name,
      this.profile_url});

  factory Offer.fromJson(Map json) => Offer(
      //offer_time: json['offer_time'],
      offer_time:  json['offer_hours']==null ?1:  json['offer_hours'] ,
      user:    json['user'],
      created: json['created'],
      job:  json['jobId']  ,
      offer_amount: json['offer_price']  ,
     message: json['description'].toString(),
      id:  json['id'],
      stars_value:  json['stars_value']==null ?"2.5":json['stars_value'],// ["id","job_id","description","accepted","offer_price","profile_url","offer_hours","price_per_hour","user_name","created","user"]
      specialize: " ",//json['specialize'],
    user_name: json['user_name'],
      profile_url: json['profile_url']
);

}
//[('accepted', False), ('user', 2), ('id', 11), ('jobId', 12), ('description', 'hello guys i do need android app'), ('offer_price', 100.0), ('offer_hours', 10), ('price_per_hour', 10), ('created', '2020-06-27 03:55:34.331582+00:00')]//