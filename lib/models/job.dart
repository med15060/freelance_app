//"id": 1,
//"description": "It's a great job 1",
//"title": "Job 1",
//"address": "3632 Little Dipper Drive",
//"pay": "paypal",
//"open": true,
//"job_price": "500",
//"job_hours": "7",
//"job_type": "manager",
//"job_media": "mehedi.JPG",
//"created": "2020-06-19 00:04:32.092962+00:00",
//"completed": true,
//"creator": 1,
//"assigned_to": 1

class Job {
  int id, creator, assigned_to, accepted_offer_id;
  String description,
      title,
      address,
      pay,
      job_price,
      job_hours,
      job_type,
      job_media,
      created,
      specialize,
      start_time;
  bool open, completed;

  Job(
      {this.id,
      this.description,
      this.address,
      this.title,
      this.assigned_to,
      this.completed,
      this.created,
      this.creator,
      this.job_hours,
      this.job_media,
      this.job_price,
      this.job_type,
      this.open,
      this.pay,
      this.specialize,
      this.accepted_offer_id,
      this.start_time});

  factory Job.fromJson(Map json) => Job(
      //description: json['description'],
      description:  json['description']==null ?" description   ":json['description'],
       id: json['id'],
      title:  json['title']==null ? " ":json['title'],//json['id']!=null ? , //(json['id']==null)id: json['id']?something1():(foo==2)? something2()
  address:" ",
      assigned_to: 1,
      completed:json['completed']=="True"?true:false,
      created:json['created'],
      creator: 1,
      job_hours: json['job_hours'].toString(),
      job_media: json['job_media'].toString(),
      job_price: json['job_budget'].toString(),
      job_type: "Remote",
      open: json['open'].toString()=="true"?true:false,
      pay: "",
      specialize: "IT",
      accepted_offer_id:2,
  start_time: "");
}
