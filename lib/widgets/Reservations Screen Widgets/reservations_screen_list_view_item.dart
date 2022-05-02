import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReservationsScreenListViewItem extends StatelessWidget {
  final String image;
  final String city;
  final String status;
  final String name;
  final String time;
  final String date;

  const ReservationsScreenListViewItem({
    required this.image,
    required this.city,
    required this.status,
    required this.name,
    required this.time,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        // height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1.5,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(city),
                        Chip(
                          label: Text(
                            orderStatus(),
                            style: TextStyle(color: statusColor()),
                          ),
                          backgroundColor: statusColor().withOpacity(0.09),
                        ),
                      ],
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xff222222),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(time),
                        Text(date),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String orderStatus() {
    if (status == 'accepted') {
      return SharedPrefController().getLang == 'en' ? 'Accepted' : 'مقبول';
    } else if (status == 'waiting') {
      return SharedPrefController().getLang == 'en' ? 'Waiting' : 'قيد الإنتظار';
    } else if (status == 'rejected') {
      return SharedPrefController().getLang == 'en' ? 'Rejected' : 'مرفوض';
    } else {
      return '';
    }
  }

  Color statusColor() {
    if (status == 'accepted') {
      return const Color(0xff11A38D);
    } else if (status == 'waiting') {
      return const Color(0xff3F6DEB);
    } else if (status == 'rejected') {
      return const Color(0xffF2533F);
    } else {
      return const Color(0xff000000);
    }
  }
}
