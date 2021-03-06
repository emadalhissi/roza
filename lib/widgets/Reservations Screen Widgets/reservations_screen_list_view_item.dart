import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReservationsScreenListViewItem extends StatefulWidget {
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
  State<ReservationsScreenListViewItem> createState() => _ReservationsScreenListViewItemState();
}

class _ReservationsScreenListViewItemState extends State<ReservationsScreenListViewItem> {
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
                    image: CachedNetworkImageProvider(widget.image),
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
                        Text(widget.city),
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
                      widget.name,
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
                        Text(widget.time),
                        Text(widget.date),
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
    if (widget.status == 'accepted') {
      return AppLocalizations.of(context)!.accepted;
    } else if (widget.status == 'waiting') {
      return AppLocalizations.of(context)!.waiting;
    } else if (widget.status == 'rejected') {
      return AppLocalizations.of(context)!.rejected;
    } else {
      return '';
    }
  }

  Color statusColor() {
    if (widget.status == 'accepted') {
      return const Color(0xff11A38D);
    } else if (widget.status == 'waiting') {
      return const Color(0xff3F6DEB);
    } else if (widget.status == 'rejected') {
      return const Color(0xffF2533F);
    } else {
      return const Color(0xff000000);
    }
  }
}
