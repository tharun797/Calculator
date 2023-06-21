
import 'package:flutter/material.dart';

import '../constants.dart';

class Display extends StatelessWidget {
  const Display({
    super.key,
    required ScrollController scrollController,
    required this.isReverse,
    required this.calculate,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final bool isReverse;
  final String calculate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 170.0),
      height: 296,
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          reverse: isReverse,
          scrollDirection: Axis.horizontal,
          child: Text(
            calculate,
            style: kTextStyle.copyWith(
                fontSize: 100, color: Colors.white70),
          ),
        ),
      ),
    );
  }
}