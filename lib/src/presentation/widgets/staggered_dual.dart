import 'package:flutter/material.dart';

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({
    required this.itemBuilder,
    required this.itemCount,
    super.key,
    this.spacing = 0.0,
    this.aspectRatio = 0.5,
  });

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        return Transform.translate(
          offset: Offset(0, index.isOdd ? 100 : 0.0),
          child: itemBuilder(context, index),
        );
      },
    );
  }
}
