import 'package:flutter/material.dart';

import 'PageSection.dart';
import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      /* corta qualquer widget */
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(50),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: Drawer(
          child: ListView(
            children: [CustomDrawerHeader(), PageSection()],
          ),
        ),
      ),
    );
  }
}
