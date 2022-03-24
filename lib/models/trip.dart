class Trip {
  late String image;
  late String name;
  late String time;
  late String date;
  late String address;
  late String price;
  late String? rate;
  late bool favorite;
  late String city;
  late String noOfOrders;

  Trip({
    required this.image,
    required this.name,
    required this.time,
    required this.date,
    required this.address,
    required this.price,
    this.rate,
    required this.favorite,
    required this.city,
    required this.noOfOrders,
  });
}
