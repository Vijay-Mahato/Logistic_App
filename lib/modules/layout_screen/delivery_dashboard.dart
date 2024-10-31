import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/order_button.dart';
import '../../components/stats_card.dart';
import '../../components/status_button.dart';

class DeliveryDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Odoo Delivery Boy',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      drawer: Drawer(), // Add drawer if needed
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OrderButton(
              title: 'Accept orders',
              icon: Icons.list,
              onTap: () {
                // Handle accept orders action
              },
            ),
            OrderButton(
              title: 'Pending orders',
              icon: Icons.access_time,
              onTap: () {
                // Handle pending orders action
              },
            ),
            OrderButton(
              title: 'Completed orders',
              icon: Icons.check_circle,
              onTap: () {
                // Handle completed orders action
              },
            ),
            SizedBox(height: 20),
            StatsCard(),
            Spacer(),
            StatusButton(),
          ],
        ),
      ),
    );
  }
}