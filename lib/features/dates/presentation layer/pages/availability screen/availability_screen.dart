import 'dart:convert';

import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_circular_progressive_indicator.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../authorisation/presentation layer/widgets/snackBar.dart';
import '../../widgets/checkbox_widget.dart';
import 'controller/availlability_screen_controller.dart';

class AvailabilityScreen extends StatefulWidget {
  String id;

  AvailabilityScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  AvailabilityScreenController availabilityScreenController =
      Get.put(AvailabilityScreenController());

  void _showDialog(function) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        height: SizeScreen.height * 0.35,
        padding: EdgeInsets.only(top: 6.0.h),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeScreen.height * 0.25,
                child: Center(
                  child: CupertinoDatePicker(
                    initialDateTime: time,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: false,
                    // This is called when the user changes the time.
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        time = newTime;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                  child: MyCustomButton(
                    width: double.infinity,
                    height: 45.h,
                    function: function,
                    buttonColor: AppColor.red,
                    text: "Save",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool d1 = false;
  bool d2 = false;
  bool d3 = false;
  bool d4 = false;
  bool d5 = false;
  bool d6 = false;
  bool d7 = false;

  //Time
  // Create a DateTime object that represents the current time
  DateTime time = DateTime(2016, 5, 10, 22, 35);

// Create a DateTime object that represents the first Monday of the month
  DateTime date = findFirstDayInMonth('Monday');

// Create a DateTime object that represents the current time
  DateTime timeToAdd = DateTime.now();

// Create a Duration object that represents the current time
  Duration duration =
      Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    return Stack(
          children: [
    SvgPicture.string(
      backgroundEmpty,
      fit: BoxFit.cover,
    ),
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0.w, 30.h, 15.w, 30.h),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Availability",
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: 25.sp,
                          letterSpacing: 0.3,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.w700,
                          wordSpacing: 0.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    ReusableText(
                      text:
                          "Pick your Availability. when you want to have the dayte",
                      textColor: AppColor.grey,
                      textSize: 12.sp,
                      textFontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    CheckboxWidget(
                      text: 'Monday',
                      d: d1,
                      onChange: (val) {
                        if (d1) {
                          setState(() {
                            d1 = false;
                            availabilityScreenController
                                .deleteDay('Monday');
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d1 = !d1;
                                DateTime date =
                                    findFirstDayInMonth('Monday');
                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);

                                availabilityScreenController.addDay(
                                    'Monday', formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                    CheckboxWidget(
                      text: 'Tuesday',
                      d: d2,
                      onChange: (val) {
                        if (d2) {
                          setState(() {
                            d2 = false;
                            availabilityScreenController
                                .deleteDay('Tuesday');
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d2 = !d2;
                                DateTime date =
                                    findFirstDayInMonth('Tuesday');
                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);
                                availabilityScreenController.addDay(
                                    'Tuesday', formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                    CheckboxWidget(
                      text: 'Wednesday',
                      d: d3,
                      onChange: (val) {
                        if (d3) {
                          setState(() {
                            d3 = false;
                            availabilityScreenController
                                .deleteDay("Wednesday");
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d3 = !d3;
                                DateTime date =
                                    findFirstDayInMonth('Wednesday');
                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);
                                availabilityScreenController.addDay(
                                    "Wednesday", formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                    CheckboxWidget(
                      text: 'Thursday',
                      d: d4,
                      onChange: (val) {
                        if (d4) {
                          setState(() {
                            d4 = false;
                            availabilityScreenController
                                .deleteDay('Thursday');
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d4 = !d4;
                                DateTime date =
                                    findFirstDayInMonth('Thursday');
                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);
                                availabilityScreenController.addDay(
                                    'Thursday', formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                    CheckboxWidget(
                      text: 'Friday',
                      d: d5,
                      onChange: (val) {
                        if (d5) {
                          setState(() {
                            d5 = false;
                            availabilityScreenController
                                .deleteDay('Friday');
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d5 = !d5;
                                DateTime date =
                                    findFirstDayInMonth('Friday');
                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);
                                availabilityScreenController.addDay(
                                    'Friday', formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                    CheckboxWidget(
                      text: 'Saturday',
                      d: d6,
                      onChange: (val) {
                        if (d6) {
                          setState(() {
                            d6 = false;
                            availabilityScreenController
                                .deleteDay('Saturday');
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d6 = !d6;
                                DateTime date =
                                    findFirstDayInMonth('Saturday');
                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);
                                availabilityScreenController.addDay(
                                    'Saturday', formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                    CheckboxWidget(
                      text: 'Sunday',
                      d: d7,
                      onChange: (val) {
                        if (d7) {
                          setState(() {
                            d7 = false;
                            availabilityScreenController
                                .deleteDay('Sunday');
                          });
                        } else {
                          _showDialog(
                            () async {
                              setState(() {
                                d7 = !d7;
                                DateTime date =
                                    findFirstDayInMonth('Sunday');

                                timeToAdd = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                    time.second);
                                String formattedTime =
                                    DateFormat.Hm().format(timeToAdd);

                                availabilityScreenController.addDay(
                                    'Sunday', formattedTime);
                              });
                              Get.back();
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Obx(
                () => Center(
                  child: MyCustomButton(
                    width: double.infinity,
                    height: 45.h,
                    function:
                        availabilityScreenController.isLoaded.value == false
                            ? () async {
                                if (availabilityScreenController
                                    .myMap.isEmpty) {
                                  snackbar(
                                      context,
                                      1,
                                      "You have to select at least a day for the date",
                                      Colors.redAccent);
                                } else {
                                  var body = {
                                    "dateId": widget.id,
                                    "proposedTime":
                                        availabilityScreenController.myMap,
                                  };
                                  var data = jsonEncode(body);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var token = prefs.getString('token');
                                  var res = await http.post(
                                    Uri.parse(
                                        "${dotenv.env['URL']}/date/setProposedDate"),
                                    headers: <String, String>{
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                      "Authorization": "Bearer $token",
                                    },
                                    body: data,
                                  );
                                  final resBody = json.decode(res.body);
                                  if (res.statusCode == 200) {
                                    snackbar(
                                        context,
                                        1,
                                        'Your date time has been saved successfully',
                                        Colors.green);
                                    navigateToAnotherScreenWithSlideTransitionFromBottomToTop(
                                        context, SqueletteHomeScreen());
                                  } else {
                                    snackbar(context, 1, resBody['message'],
                                        Colors.redAccent);
                                  }
                                }

                                print(availabilityScreenController.myMap);
                              }
                            : () {},
                    buttonColor: AppColor.red,
                    text: "Submit",
                    fontWeight: FontWeight.w700,
                    widget:
                        availabilityScreenController.isLoaded.value == true
                            ? ReusablecircularProgressIndicator(
                                indicatorColor: Colors.white,
                                height: 15,
                                width: 15,
                              )
                            : null,
                  ),
                ),
              )
            ]),
      ),
    )
          ],
        );
  }
}

void cancelDayte(context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      // Drawer from the bottom
      return SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: SizeScreen.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return const SizedBox();
                  },
                ),
                Center(
                  child: MyCustomButton(
                    width: double.infinity,
                    height: 45.h,
                    function: () {
                      cancelDayte(context);
                    },
                    buttonColor: AppColor.red,
                    text: "Save",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CheckboxTime extends StatelessWidget {
  String time;
  bool? t;
  Function(bool?)? onChange;

  CheckboxTime({Key? key, required this.time, this.onChange, this.t = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    child: ReusableText(
                      text: time,
                      textSize: 15.sp,
                      textFontWeight: FontWeight.w500,
                      textColor: AppColor.grey,
                    ),
                  ),
                ),
              ),
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(
                  color: Color(0xffADA9A9),
                  width: 2,
                ),
                splashRadius: 0,
                value: t,
                onChanged: onChange,
                activeColor: const Color(0xffADA9A9),
                checkColor: AppColor.red,
              ),
            ],
          ),
          const Divider(
            height: 0,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: Color(0xff7C7C7C),
          ),
        ],
      ),
    );
  }
}

DateTime findFirstDayInMonth(String dayName) {
  // Get the current date
  DateTime now = DateTime.now();

  // Find the first day of the month
  DateTime firstDayOfMonth = DateTime(now.year, now.month, now.day);

  // Map day names to their corresponding integers (e.g., Monday -> 1, Tuesday -> 2, ...)
  Map<String, int> dayMapping = {
    'Monday': DateTime.monday,
    'Tuesday': DateTime.tuesday,
    'Wednesday': DateTime.wednesday,
    'Thursday': DateTime.thursday,
    'Friday': DateTime.friday,
    'Saturday': DateTime.saturday,
    'Sunday': DateTime.sunday,
  };

  // Get the desired day of the week as an integer
  int? desiredDay = dayMapping[dayName];

  // Calculate the date of the first occurrence of the desired day in the current month
  DateTime firstDay = firstDayOfMonth;
  while (firstDay.weekday != desiredDay) {
    firstDay = firstDay.add(const Duration(days: 1));
  }

  return firstDay;
}
