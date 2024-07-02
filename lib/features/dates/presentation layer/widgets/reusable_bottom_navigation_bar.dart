import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/bottom_navigation_bar_cubit.dart';
import 'icon_bottom_navigation_bar.dart';

class ReusableBottomNavigationBar extends StatelessWidget {
  const ReusableBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomNavigationIcons.map((icon) {
            final isSelected = bottomNavigationIcons.indexOf(icon) == state;
            return GestureDetector(
              onTap: () {
                context
                    .read<BottomNavigationCubit>()
                    .changePage(bottomNavigationIcons.indexOf(icon));
              },
              child: IconBottomNavigationBar(
                icon: !isSelected
                    ? icon.icon
                    : isSelected && bottomNavigationIcons.indexOf(icon) == 0
                        ? Icon(
                            Icons.person_2_outlined,
                            size: 25.sp,
                            color: Color(0xffAB3333),
                          )
                        : isSelected && bottomNavigationIcons.indexOf(icon) == 2
                            ? Icon(Icons.calendar_month_outlined,
                                size: 25.sp, color: Color(0xffAB3333))
                            : SvgPicture.asset("images/red_petals.svg"),
                pageName: icon.pageName,
                textColor: isSelected ? Color(0xffAB3333) : Color(0xff907A7A),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

List<IconBottomNavigationBar> bottomNavigationIcons = [
  IconBottomNavigationBar(
    icon: Icon(
      Icons.person_2_outlined,
      size: 25.sp,
      color: Color(0xff907A7A),
    ),
    pageName: 'Profile',
    textColor: Color(0xff907A7A),
  ),
  IconBottomNavigationBar(
    icon: SvgPicture.asset("images/grey_petals.svg"),
    pageName: 'Petals',
    textColor: Color(0xff907A7A),
  ),
  IconBottomNavigationBar(
    icon: Icon(
      Icons.calendar_month_outlined,
      size: 25.sp,
      color: Color(0xff907A7A),
    ),
    pageName: 'Dayte',
    textColor: Color(0xff907A7A),
  ),
];
