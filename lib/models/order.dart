

class Order {
double total_amount;
String url_payment;
bool paied;

Order(
{this.total_amount,
this.url_payment,
this.paied,
}
);


factory Order.fromJson(Map json) => Order(
total_amount: json['total_amount'],
url_payment: json['url_payment'],
paied: json['paied']=="true" ? true: false);
}