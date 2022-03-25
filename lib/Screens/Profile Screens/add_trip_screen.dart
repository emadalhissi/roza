import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({Key? key}) : super(key: key);

  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  late TextEditingController tripNameEditingController;
  late TextEditingController tripDescriptionEditingController;
  late TextEditingController tripPriceEditingController;
  late TextEditingController tripMinPaymentEditingController;

  @override
  void initState() {
    super.initState();
    tripNameEditingController = TextEditingController();
    tripDescriptionEditingController = TextEditingController();
    tripPriceEditingController = TextEditingController();
    tripMinPaymentEditingController = TextEditingController();
  }

  @override
  void dispose() {
    tripNameEditingController.dispose();
    tripDescriptionEditingController.dispose();
    tripPriceEditingController.dispose();
    tripMinPaymentEditingController.dispose();
    super.dispose();
  }

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String date_ = 'Choose Date';
  String time_ = 'Choose Time';

  String dropDownCityValue = 'Hebron';

  List<String> citiesList = <String>[
    'Hebron',
    'Nablus',
    'Ramallah',
    'Bethlehem',
    'Jenin',
    'Jericho',
  ];

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
          'Add Trip',
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
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                textEditingController: tripNameEditingController,
                hint: 'Trip Name',
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripPriceEditingController,
                hint: 'Trip Price',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripMinPaymentEditingController,
                hint: 'Min Payment',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripDescriptionEditingController,
                hint: 'Description',
                lines: 3,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: time,
                        );
                        if(newTime == null) return;
                        setState(() {
                          time_ = '${newTime.hour}:${newTime.minute}';
                        });
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            time_,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2024),
                        );
                        if (newDate == null) return;
                        setState(() {
                          date_ =
                              '${newDate.year}-${newDate.month}-${newDate.day}';
                        });
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            date_,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  itemHeight: 60,
                  underline: const SizedBox.shrink(),
                  value: dropDownCityValue,
                  items: citiesList
                      .map(
                        (city) => DropdownMenuItem(
                          value: city,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            child: Text(
                              city,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropDownCityValue = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Images',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              // select images
              const SizedBox(height: 60),
              ElevatedButton(
                child: const Text(
                  'Add Trip',
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
