import 'package:flutter/material.dart';
import 'package:kapartner_app/presentation/views/registration_screen/customer_registration/customer_reg_screen.dart';
import 'package:kapartner_app/presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart';

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
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TabBarView(
        children: [
          CustomerRegistrationScreen(),
          KaPartnerRegistrationScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.purple,
        child: TabBar(
          // onTap: (indedx) {},
          indicatorColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              icon: Icon(Icons.favorite_border),
              text: "ONE",
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: "TWO",
            ),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}
