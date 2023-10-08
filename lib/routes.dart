import 'package:apiapp/pages/firebaseclouddata.dart';
import 'package:apiapp/pages/firebaseclouddatadetail.dart';
import 'package:apiapp/pages/firebaseclouddataedit.dart';
import 'package:apiapp/pages/forgotpassword.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:apiapp/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:apiapp/pages/home.dart';
import 'package:apiapp/pages/datalist.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (_) => const SignIn(),
  SignUp.routeName: (_) => const SignUp(
        isDarkMode: true,
      ),
  Home.routeName: (_) => const Home(
        firstName: '',
        lastName: '',
      ),
  Datalist.routeName: (_) => const Datalist(),
  Firebaseclouddata.routeName: (_) => const Firebaseclouddata(),
  'password_reset': (_) => const Passwordreset(
        isDarkMode: true,
      ),
  UserDetailPage.routeName: (_) => const UserDetailPage(
        fname: '',
        lname: '',
        mobile: '',
        email: '',
        country: '',
        dob: '',
        location: '',
        maritalStatus: '',
        nationality: '',
        documentId: '',
        image: '',
      ),
  EditUserDetailScreen.routeName: (_) => EditUserDetailScreen(
        fname: '',
        lname: '',
        mobile: '',
        email: '',
        country: '',
        dob: '',
        location: '',
        maritalStatus: '',
        nationality: '',
        documentId: '',
        image: '',
      ),
};
