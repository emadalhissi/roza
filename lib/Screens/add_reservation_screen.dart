import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AddReservationScreen extends StatefulWidget {
  const AddReservationScreen({Key? key}) : super(key: key);

  @override
  _AddReservationScreenState createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {
  late TextEditingController fullNameEditingController;
  late TextEditingController mobileEditingController;
  late TextEditingController userDocIdEditingController;
  late TextEditingController firstPaymentEditingController;
  late TextEditingController noOfPeopleEditingController;
  late TextEditingController userNoteEditingController;

  @override
  void initState() {
    super.initState();
    fullNameEditingController = TextEditingController();
    mobileEditingController = TextEditingController();
    userDocIdEditingController = TextEditingController();
    firstPaymentEditingController = TextEditingController();
    noOfPeopleEditingController = TextEditingController();
    userNoteEditingController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameEditingController.dispose();
    mobileEditingController.dispose();
    userDocIdEditingController.dispose();
    firstPaymentEditingController.dispose();
    noOfPeopleEditingController.dispose();
    userNoteEditingController.dispose();
    super.dispose();
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
              const Text(
                'Trip Details',
                style:  TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                children: [
                  const TableRow(
                    children: [
                      Text(
                        '\$234',
                        style: TextStyle(
                          color: Color(0xff5859F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Office Name',
                        style: TextStyle(
                          color: Color(0xff5859F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Row(
                        children: const [
                           Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 20,
                          ),
                           SizedBox(width: 5),
                          Text(
                            '12:30',
                            style:  TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                           Icon(
                            Icons.date_range,
                            color: Colors.grey,
                            size: 20,
                          ),
                           SizedBox(width: 5),
                          Text(
                            '2022-03-09',
                            style:  TextStyle(
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
                        children: const [
                        Icon(
                            Icons.place,
                            color: Colors.grey,
                            size: 20,
                          ),
                           SizedBox(width: 5),
                          Text(
                            'Trip 1 address',
                            style:  TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.attach_money,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Min. Payment: \$150',
                            style: TextStyle(
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
             const  SizedBox(height: 20),
             const  Text(
                'Reserver Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: fullNameEditingController,
                hint: 'Name',
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userDocIdEditingController,
                hint: 'Document ID #',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: mobileEditingController,
                hint: 'Mobile',
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Details',
                style:  TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: firstPaymentEditingController,
                hint: 'Min. Payment: ??',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                'Other Details',
                style:  TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: noOfPeopleEditingController,
                hint: '# of People',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userNoteEditingController,
                hint: 'Notes',
                lines: 3,
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                child: const Text(
                  'Add Reservation',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  padding: EdgeInsets.zero,
                  primary: const Color(0xff5859F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
