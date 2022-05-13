import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';

class Slider<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(T item) itemBuilder;
  final bool automation, reverse;
  final EdgeInsets? paddingImage;
  // Indicate config
  final double indicateSize,
      // padding
      paddingIndicate;

  const Slider({
    required this.data,
    required this.itemBuilder,
    Key? key,
    this.automation = false,
    this.reverse = true,
    this.indicateSize = 12.0,
    this.paddingIndicate = 5.0,
    this.paddingImage,
  }) : super(key: key);

  @override
  State<Slider<T>> createState() => _SliderState<T>();
}

class _SliderState<T> extends State<Slider<T>> {
  late PageController _controller;
  Timer? timer;
  int currentIndex = 1;
  bool pause = false;

  final _duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1, viewportFraction: .85);
    _setInterval();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  double get _indicateSize => widget.indicateSize;
  double get _indicatePadding => widget.paddingIndicate;
  int get _dataSize => widget.data.length;

  @override
  Widget build(BuildContext context) {
    final width =
        2 * _dataSize * _indicatePadding + (_dataSize + 1) * _indicateSize;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: widget.paddingImage,
          child: PageView.builder(
            controller: _controller,
            pageSnapping: true,
            itemCount: widget.data.length,
            itemBuilder: _itemBuilder,
            onPageChanged: _onPageChanged,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.center,
            height: _indicateSize,
            width: width,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: _indicateBuilder,
              itemCount: widget.data.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final data = widget.data[index];
    return AnimatedContainer(
      padding: EdgeInsets.all(index == currentIndex ? 0.0 : 18.0),
      duration: _duration,
      child: widget.itemBuilder(data),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollTo(int toPage) {
    final page = toPage >= _dataSize ? 0 : toPage;
    _controller.animateToPage(
      page,
      duration: _duration,
      curve: Curves.easeIn,
    );
  }

  void _startSroll() {
    if (timer?.isActive ?? true) {
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (timer) {
          try {
            _scrollTo(currentIndex + 1);
          } catch (error) {
            debugPrint('Error auto scroll');
          }
        },
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() => currentIndex = index);
  }

  Widget _indicateBuilder(BuildContext context, int index) {
    final isCurrent = index == currentIndex;
    final color = isCurrent ? kPrimaryDarkColor : kPlaceholderDarkColor;
    final width = _indicateSize * (isCurrent ? 2 : 1);

    return GestureDetector(
      onTap: () {
        _scrollTo(index);
      },
      child: AnimatedContainer(
        duration: _duration,
        margin: EdgeInsets.symmetric(horizontal: _indicatePadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        height: widget.indicateSize,
        width: width,
      ),
    );
  }

  void _setInterval() {
    if (!widget.automation) return;
    _startSroll();
  }
}
