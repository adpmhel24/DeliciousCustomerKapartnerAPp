import 'package:flutter/material.dart';

import 'components/body.dart';

class CustomerRegistrationScreen extends StatefulWidget {
  const CustomerRegistrationScreen({Key? key}) : super(key: key);

  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
