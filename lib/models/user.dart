class User {
  int id, job;
  String name,
      email,
      country,
      state,
      address,
      phone,
      usertype,
      how_many_jobs,
      specializes,
      profile_picture,
      description,
      zip,
      stars_value,
      distance_in_miles,
      last_reviews,
      token,
      hourly_rate;


  User(
      {this.name,
      this.id,
      this.email,
      this.state,
      this.phone,
      this.description,
      this.country,
      this.address,
      this.distance_in_miles,
      this.how_many_jobs,
      this.job,
      this.last_reviews,
      this.profile_picture,
      this.specializes,
      this.stars_value,
      this.usertype,
      this.zip,
      this.hourly_rate,
      this.token});


  factory User.fromJson(Map json) => User(
      name: json['name'],
      id: json['id'],
      email: json['email'],
      description: json['description'],
      country: json['country'],
      address: json['address'],
      distance_in_miles:"10",//json['distance_in_miles'],
      how_many_jobs: "",//json['how_many_jobs'],
      job: json['job'],
      last_reviews: json['last_reviews'],
      phone: json['phone'],
      profile_picture: json['profile_picture'],
      specializes: json['specializes'],
      stars_value: json['stars_value'],
      state: json['state'],
      usertype: json['usertype'],
      zip: json['zip'],
      hourly_rate: json['hourly_rate'],
      token:
      json['token']==null ?"": json['token']
  );
}
