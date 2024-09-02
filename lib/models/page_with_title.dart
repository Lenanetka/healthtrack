import 'package:flutter/material.dart';

abstract class PageWithTitle extends StatefulWidget {
  const PageWithTitle({super.key});
  Icon get icon;
  String get title;
}
