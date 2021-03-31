import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:park/app/maps_service/Gmap_place_search.dart';
import 'package:park/app/model/search_bar.dart';
import 'package:park/app/services/authService.dart';
import 'package:park/app/sign_in/landing_page.dart';
import 'package:park/app/maps_service/gmapsServices.dart';
import 'package:park/app/custom_widgets/show_Dialog_alert.dart';
import 'package:provider/provider.dart';
import 'package:park/app/BLoC/application_bloc.dart';
import 'package:park/app/maps_service/gmap_services_new.dart';
import 'package:park/app/services/places_service.dart';

class HomePagePark extends StatefulWidget {
  @override
  _HomePagePark createState() => _HomePagePark();
}

class _HomePagePark extends State<HomePagePark> {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      auth.signOut().then((res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
            (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signOutDialog(BuildContext context) async {
    final signOutRequest = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure want to Logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (signOutRequest == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => _signOutDialog(context),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[BasicMap()],
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              title: Text("Option 1"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Option 2"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
      ),
    );
  }
}
