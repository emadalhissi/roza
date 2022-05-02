import 'package:Rehlati/FireBase/fb_firestore_orders_controller.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  final String tripName;
  final String tripTime;
  final String tripDate;
  final String status;
  final String noOfPeople;
  final int tripAddressId;
  final String tripAddress;
  final String tripAddressAr;
  final String tripId;
  final int firstPayment;
  final int leftPayment;
  final String officeName;
  final String officeEmail;
  final String officeId;
  final String userId;
  final String userName;
  final String userMobile;
  final String userDocId;
  final String userNote;
  final String officeNote;
  final String orderId;
  final bool fullPaid;

  const ReservationScreen({
    required this.tripName,
    required this.tripTime,
    required this.tripDate,
    required this.status,
    required this.noOfPeople,
    required this.tripAddressId,
    required this.tripAddress,
    required this.tripAddressAr,
    required this.tripId,
    required this.firstPayment,
    required this.leftPayment,
    required this.officeName,
    required this.officeEmail,
    required this.officeId,
    required this.userId,
    required this.userName,
    required this.userMobile,
    required this.userDocId,
    required this.fullPaid,
    required this.userNote,
    required this.officeNote,
    required this.orderId,
    Key? key,
  }) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String noOfOrders = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 25,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                          widget.officeName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.tripName,
                          style: const TextStyle(
                            color: Color(0xff5859F3),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        label: Text(
                          orderStatus(),
                          style: TextStyle(color: orderStatusColor()),
                        ),
                        backgroundColor: orderStatusColor().withOpacity(0.09),
                      ),
                      Chip(
                        label: Text(
                          paidStatus(),
                          style: TextStyle(color: paidStatusColor()),
                        ),
                        backgroundColor: paidStatusColor().withOpacity(0.09),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'User Information',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Name: ${widget.userName}',
                style: const TextStyle(
                  color: Color(0xff8A8A8E),
                  fontSize: 16,
                ),
              ),
              Text(
                'Mobile Number: ${widget.userMobile}',
                style: const TextStyle(
                  color: Color(0xff8A8A8E),
                  fontSize: 16,
                ),
              ),
              Text(
                'Doc ID: ${widget.userDocId}',
                style: const TextStyle(
                  color: Color(0xff8A8A8E),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Reservation Details',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Table(
                children: [
                  TableRow(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.tripTime,
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
                            widget.tripDate,
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
                  TableRow(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.place,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            SharedPrefController().getLang == 'en'
                                ? widget.tripAddress
                                : widget.tripAddressAr,
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
                            Icons.people_rounded,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'No. People: ${widget.noOfPeople}',
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
                  TableRow(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Paid: \$${widget.firstPayment}',
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
                            Icons.money_off,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Left: \$${widget.leftPayment}',
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
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'User Notes',
                style: TextStyle(fontSize: 18),
              ),
              widget.userNote != ''
                  ? Text(
                      widget.userNote,
                      style: const TextStyle(
                        color: Color(0xff8A8A8E),
                        fontSize: 16,
                      ),
                    )
                  : const Text(
                      'User did not add any notes!',
                      style: TextStyle(
                        color: Color(0xff8A8A8E),
                        fontSize: 16,
                      ),
                    ),
              const SizedBox(height: 20),
              const Text(
                'Office Notes',
                style: TextStyle(fontSize: 18),
              ),
              widget.officeNote != ''
                  ? Text(
                      widget.officeNote,
                      style: const TextStyle(
                        color: Color(0xff8A8A8E),
                        fontSize: 16,
                      ),
                    )
                  : const Text(
                      'Office did not add any notes!',
                      style: TextStyle(
                        color: Color(0xff8A8A8E),
                        fontSize: 16,
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    if (SharedPrefController().getAccountType == 'admin') {
      return SizedBox(
        width: double.infinity,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: widget.status != 'accepted'
                      ? () {
                          showAlertDialog(context, status: 'accepted');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 70),
                    padding: EdgeInsets.zero,
                    primary: const Color(0xff11A38D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  child: const Text(
                    'Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: widget.status != 'waiting'
                      ? () {
                          showAlertDialog(context, status: 'waiting');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 70),
                    padding: EdgeInsets.zero,
                    primary: const Color(0xff3F6DEB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: widget.status != 'rejected'
                      ? () {
                          showAlertDialog(context, status: 'rejected');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 70),
                    padding: EdgeInsets.zero,
                    primary: const Color(0xffF2533F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (SharedPrefController().getUId == widget.officeId) {
      return const SizedBox.shrink();
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> changeStatus({
    required String status,
  }) async {
    await FbFireStoreOrdersController().changeOrderStatus(
      status: status,
      userId: widget.userId,
      orderId: widget.orderId,
      officeId: widget.officeId,
      tripId: widget.tripId,
      city: widget.tripAddress,
    );
    Navigator.pop(context);
  }

  showAlertDialog(
    BuildContext context, {
    required String status,
  }) {
    Widget cancelButton = TextButton(
      child: const Text(
        'No',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, () {
          setState(() {});
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'Yes',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        Navigator.pop(context);
        changeStatus(status: status);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Change Status!'),
      content: const Text('Are you sure you want to change the status?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String orderStatus() {
    if (widget.status == 'accepted') {
      return SharedPrefController().getLang == 'en' ? 'Accepted' : 'مقبول';
    } else if (widget.status == 'waiting') {
      return SharedPrefController().getLang == 'en'
          ? 'Waiting'
          : 'قيد الإنتظار';
    } else if (widget.status == 'rejected') {
      return SharedPrefController().getLang == 'en' ? 'Rejected' : 'مرفوض';
    } else {
      return '';
    }
  }

  Color orderStatusColor() {
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

  String paidStatus() {
    if (widget.fullPaid) {
      return SharedPrefController().getLang == 'en'
          ? 'Full Paid'
          : 'تم الدفع كامل';
    } else {
      return SharedPrefController().getLang == 'en'
          ? 'Not Full Paid'
          : 'لم يتم الدفع كامل';
    }
  }

  Color paidStatusColor() {
    if (widget.fullPaid) {
      return Colors.pinkAccent;
    } else {
      return Colors.deepOrange;
    }
  }
}
