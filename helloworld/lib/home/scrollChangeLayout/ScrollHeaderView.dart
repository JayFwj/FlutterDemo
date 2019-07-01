import 'dart:math';

import 'package:flutter/material.dart';


class ScrollHeaderView extends StatelessWidget {

  double offset;

  ScrollHeaderView(this.offset);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width - 24;

    double searchWidth = max(100, (width - offset));

    double searchHeight = max(42, (90 - offset / 2));

    return Container(
      width: searchWidth,
      height: searchHeight,
      color: Colors.orange,
      margin: EdgeInsets.fromLTRB(12, 8, 12, 8),

    );
  }
}
