import 'package:flutter/material.dart';

class TaggedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? scrollController;

  const TaggedListView({
    super.key,
    required this.children,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => children[index],
            childCount: children.length,
          ),
        ),
      ],
    );
  }
}
