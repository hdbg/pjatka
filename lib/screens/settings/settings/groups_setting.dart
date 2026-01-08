
import 'package:flutter/material.dart';
import 'package:pjatka/screens/settings/screen.dart';

class GroupsSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Groups Setting Screen'),
    );
  }
}

final groupSetting = Setting(
  title: 'Groups',
  icon: Icons.group,
  description: 'Manage your groups',
  builder: (context) => GroupsSetting(),
);