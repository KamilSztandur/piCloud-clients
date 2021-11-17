import 'package:app/features/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app/common/widgets/under_construction_widget.dart';
import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PICloudAppBar(title: "User Profile"),
      drawer: MainDrawer(),
      body: UnderConstructionInfo(pageName: "UserProfile"),
      bottomNavigationBar: PICloudBottomNavigationBar(),
    );
  }
}
