import 'package:client/features/dates/presentation%20layer/bloc/date%20bloc/date_bloc.dart';
import 'package:client/features/dates/presentation%20layer/pages/bottom%20navigation%20bar%20screens/dayte_screen.dart';
import 'package:client/features/dates/presentation%20layer/pages/bottom%20navigation%20bar%20screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/platform_checker.dart';
import '../cubit/bottom_navigation_bar_cubit.dart';
import '../widgets/reusable_bottom_navigation_bar.dart';
import 'bottom navigation bar screens/petals_screen.dart';

class SqueletteHomeScreen extends StatefulWidget {
  const SqueletteHomeScreen({super.key});

  @override
  State<SqueletteHomeScreen> createState() => _SqueletteHomeScreenState();
}

class _SqueletteHomeScreenState extends State<SqueletteHomeScreen> {
  @override
  void initState() {
    context.read<DateBloc>().add(GetRecommendationEvent(isShuffle: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
        ),
        child: Column(children: [
          BlocBuilder<BottomNavigationCubit, int>(
            builder: (context, state) {
              return checkPlatform(
                  iphoneWidget: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.90,
                    child: bottomNavigationBarScreens[state],
                  ),
                  androidWidget: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.88,
                    child: bottomNavigationBarScreens[state],
                  ));
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h),
            child: ReusableBottomNavigationBar(),
          ),
        ]),
      ),
    );
  }
}

final bottomNavigationBarScreens = [
  ProfileScreen(),
  PetalsScreen(),
  DayteScreen(),
];
