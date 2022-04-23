import 'package:Rehlati/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TripsScreenTripsListViewItem extends StatefulWidget {
  final String tripId;
  final String image;
  final String name;
  final String time;
  final String date;
  final String address;
  final String addressAr;
  final String price;
  bool? favorite;

  TripsScreenTripsListViewItem({
    required this.tripId,
    required this.image,
    required this.name,
    required this.time,
    required this.date,
    required this.address,
    required this.addressAr,
    required this.price,
    this.favorite = false,
    Key? key,
  }) : super(key: key);

  @override
  State<TripsScreenTripsListViewItem> createState() =>
      _TripsScreenTripsListViewItemState();
}

class _TripsScreenTripsListViewItemState
    extends State<TripsScreenTripsListViewItem> {
  String noOfOrders = '0';

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  Future<void> getOrders() async {
    List<Order> orders = [];
    var ordersFromFirebase = await FirebaseFirestore.instance
        .collection('cities')
        .doc(widget.address)
        .collection('trips')
        .doc(widget.tripId)
        .collection('orders')
        .get();

    if (ordersFromFirebase.docs.isNotEmpty) {
      for (var doc in ordersFromFirebase.docs) {
        orders.add(Order.fromMap(doc.data()));
      }
      setState(() {
        noOfOrders = orders.length.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1.5,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Material(
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(25),
                  topEnd: Radius.circular(25),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.time,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.date,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.place,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.address,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.favorite == true
                                ? widget.favorite = false
                                : widget.favorite = true;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 23,
                          child: Icon(
                            Icons.favorite,
                            color: widget.favorite == true
                                ? const Color(0xff5859F3)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '\$${widget.price}',
                        style: const TextStyle(
                          color: Color(0xff5859F3),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      noOfOrders == '0'
                          ? const SizedBox.shrink()
                          : const Icon(
                              Icons.supervisor_account,
                              color: Color(0xff5859F3),
                              size: 20,
                            ),
                      const SizedBox(width: 5),
                      noOfOrders == '0'
                          ? const SizedBox.shrink()
                          : Text(
                              noOfOrders == '1'
                                  ? '$noOfOrders Order'
                                  : '$noOfOrders Orders',
                            ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
