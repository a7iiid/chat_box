import 'package:flutter/material.dart';

import 'view/People_body.dart';

class People extends StatelessWidget {
  const People({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PeopleBody(),
    );
  }
}
