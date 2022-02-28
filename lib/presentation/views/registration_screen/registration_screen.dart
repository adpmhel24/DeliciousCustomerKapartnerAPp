import 'package:flutter/material.dart';
import './customer_registration/customer_reg_screen.dart';
import './ka_partner_registration/ka_partner_reg.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String title = "Home";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          // onTap: (indedx) {},
          indicatorColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              icon: Icon(Icons.person),
              text: "Customer",
            ),
            Tab(
              icon: Icon(Icons.group_add),
              text: "Ka-Partner",
            ),
          ],
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          CustomerRegistrationScreen(),
          KaPartnerRegistrationScreen(),
        ],
      ),
    );
  }
}
