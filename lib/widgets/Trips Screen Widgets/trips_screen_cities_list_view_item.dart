import 'package:flutter/material.dart';

class TripsScreenCitiesListViewItem extends StatelessWidget {

  final String city;
  const TripsScreenCitiesListViewItem({
    required this.city,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 15),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 16,
          ),
          child: Center(
            child: Text(
              city,
              style: const TextStyle(
                color: Color(0xff5859F3),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
