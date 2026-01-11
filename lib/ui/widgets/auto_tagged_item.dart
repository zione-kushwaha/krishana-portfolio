import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krishna/provider/current_tag_notifier.dart';
import 'package:provider/provider.dart';

class AutoTaggedItem extends StatefulWidget {
  final String tag;
  final Widget child;

  const AutoTaggedItem({super.key, required this.tag, required this.child});

  @override
  State<AutoTaggedItem> createState() => _AutoTaggedItemState();
}

class _AutoTaggedItemState extends State<AutoTaggedItem> {
  final GlobalKey _key = GlobalKey();
  CurrentTagNotifier? _notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Remove old listener if exists
    _notifier?.removeListener(_onTagChanged);
    // Get notifier and add listener
    _notifier = context.read<CurrentTagNotifier>();
    _notifier?.addListener(_onTagChanged);
  }

  @override
  void dispose() {
    _notifier?.removeListener(_onTagChanged);
    super.dispose();
  }

  void _onTagChanged() {
    if (!mounted) return;
    final currentTag = _notifier?.currentTag;
    if (currentTag == widget.tag) {
      // Add a small delay to ensure layout is complete
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _scrollToItem();
      });
    }
  }

  void _scrollToItem() {
    final context = _key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          _checkVisibility();
        }
        return false;
      },
      child: Container(key: _key, child: widget.child),
    );
  }

  void _checkVisibility() {
    if (!mounted) return;

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;
    final double itemTop = offset.dy;
    final double itemBottom = itemTop + size.height;

    // Calculate how much of this item is visible in the viewport
    final double visibleTop = itemTop < 0 ? 0 : itemTop;
    final double visibleBottom = itemBottom > screenHeight
        ? screenHeight
        : itemBottom;
    final double visibleHeight = visibleBottom - visibleTop;
    final double visibilityPercent = visibleHeight / screenHeight;

    // If this section takes up more than 20% of the screen, it's the current section
    // And it should be in the top portion (below app bar)
    if (visibilityPercent > 0.2 && itemTop < screenHeight * 0.6) {
      _notifier?.setCurrentTag(widget.tag);
    }
  }
}
