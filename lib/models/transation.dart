class Trasaction {
  String reciever;
  String date;
  String amount;
  String type;
  bool sent;
  Trasaction({
    this.reciever,
    this.date,
    this.amount,
    this.type,
    this.sent
  });
  
}
class Histoftransact {
  int id;
  String requested;
  String done_on;
  String amount;
  double balance;
  bool pending;
  bool refusied;
  Histoftransact({


    this.id,
    this.requested,
    this.done_on,
    this.amount,
    this.balance,
    this.pending,
    this.refusied
  });
  factory Histoftransact.fromJson(Map json) => Histoftransact(
      id:json['id'] ,
      requested: json['requested']==null?json['requested'].toString():"",
      done_on:  json['done_on']==null?json['done_on'].toString():"",//json['name'].toString(),
      amount: json['amount']==null?json['amount'].toString():"",// json['first_name'],// double.parse(json['rate']),
      balance:json['balance']==null?json['balance']:"",
      pending: json['pending']==null?json['pending']:"");
}


