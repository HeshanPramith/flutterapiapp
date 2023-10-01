import 'package:flutter/material.dart';
import 'package:apiapp/pages/home.dart';
import 'package:apiapp/pages/datalist.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName: (_) => const Home(),
  Datalist.routeName: (_) => const Datalist(),
};
