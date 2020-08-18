class Seller {
  int id;
  double rate;
  String profile;
  String name;
  String specializes;
  String description;
  String how_many_jobs;
  String distance_in_miles;

  Seller(
      {this.id,
      this.profile,
      this.name,
      this.rate,
      this.description,
      this.specializes,
        this.how_many_jobs,
        this.distance_in_miles});

  factory Seller.fromJson(Map json) => Seller(
      id:json['id'] ,
      profile:json['profile'],
      name: json['first_name'],//json['name'].toString(),
     rate:json['rate'],// json['first_name'],// double.parse(json['rate']),
      description: json['description'].toString(),
      specializes: json['specializes']==null?json['specializes'].toString():"IT");
}
