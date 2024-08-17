import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/features/dates/presentation%20layer/pages/availability%20screen/availability_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constant.dart';
import '../../../../svgImages.dart';
import '../../../authorisation/domain layer/entities/user_entity.dart';

class ItsADateScreen extends StatefulWidget {
  final User likingUser;
  final User likedUser;
  final String id;

  ItsADateScreen({
    Key? key,
    required this.id,
    required this.likingUser,
    required this.likedUser,
  }) : super(key: key);

  @override
  State<ItsADateScreen> createState() => _ItsADateScreenState();
}

class _ItsADateScreenState extends State<ItsADateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // Use 'this' to provide the TickerProvider
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset(-0.7, 0.0),
      end: Offset(0.3, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.string(
            backgroundEmpty,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.fromLTRB(2.0, 0.h, 2, 25.h),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 80.h,
                      right: 35.w,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..rotateZ(15 * 3.1415927 / 180),
                        child: Container(
                          height: 270.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${widget.likingUser.images?[0].image}'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 50,
                                offset: Offset(5, 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 100.w,
                      child: Image.asset('images/like.png'),
                    ),
                    Positioned(
                      top: 230.h,
                      left: 30.w,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..rotateZ(-15 * 2.2815927 / 180),
                        child: Container(
                          height: 270.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${widget.likedUser.images?[0].image}'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 50,
                                offset: Offset(5, 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: -5.h,
                      child: Image.asset('images/like.png'),
                    ),
                    Positioned(
                      bottom: 80.h,
                      right: 20.w,
                      child: Text(
                        "It's a Dayte!",
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: 35.sp,
                          letterSpacing: 0.3,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold,
                          wordSpacing: 0.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.h,
                      right: 20.w,
                      child: GestureDetector(
                        onTap: () {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                              context, AvailabilityScreen(id: widget.id));
                        },
                        child: SlideTransition(
                          position: _animation,
                          child: SvgPicture.string(arrow),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
