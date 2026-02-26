import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TaskRowShimmer extends StatelessWidget {
  const TaskRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Row(
          children: [
            // Brand shimmer
            _buildBox(flex: 4),
            // Count shimmer
            _buildBox(flex: 2),
            // Type shimmer
            _buildBox(flex: 3),
            // Price shimmer
            _buildBox(flex: 3),
            // Edit icon shimmer
            Expanded(
              flex: 1,
              child: Container(
                height: 65,
                alignment: Alignment.center,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox({required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.red[300],
          border: Border(right: BorderSide(color: Colors.grey, width: 1)),
        ),
      ),
    );
  }
}
