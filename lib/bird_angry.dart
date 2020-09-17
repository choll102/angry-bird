import 'dart:ui';

import 'package:flutter/material.dart';
class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
        width: 65,
        child: Image.asset('lib/images/angrybird.png', )
    );
  }
}
