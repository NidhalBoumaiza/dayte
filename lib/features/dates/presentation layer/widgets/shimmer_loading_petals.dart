import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingPetals extends StatelessWidget {
  const ShimmerLoadingPetals({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!, // Darker gray for base color
      highlightColor: Colors.grey[200]!, // Lighter gray for highlight color
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
