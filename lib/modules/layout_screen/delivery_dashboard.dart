// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../components/order_button.dart';
// import '../../components/stats_card.dart';
// import '../../components/status_button.dart';

// class DeliveryDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text(
//           'Odoo Delivery Boy',
//           style: TextStyle(color: Colors.black),
//         ),
//         elevation: 0,
//       ),
//       drawer: Drawer(), // Add drawer if needed
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             OrderButton(
//               title: 'Accept orders',
//               icon: Icons.list,
//               onTap: () {
//                 // Handle accept orders action
//               },
//             ),
//             OrderButton(
//               title: 'Pending orders',
//               icon: Icons.access_time,
//               onTap: () {
//                 // Handle pending orders action
//               },
//             ),
//             OrderButton(
//               title: 'Completed orders',
//               icon: Icons.check_circle,
//               onTap: () {
//                 // Handle completed orders action
//               },
//             ),
//             SizedBox(height: 20),
//             StatsCard(),
//             Spacer(),
//             StatusButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:fazeal_logistics/widgets/orders/order_button.dart';
import 'package:flutter/material.dart';

import '../../components/order_button.dart';

class DeliveryDashboard extends StatefulWidget {
  const DeliveryDashboard({super.key});

  @override
  State<DeliveryDashboard> createState() => _DeliveryDashboardState();
}

class _DeliveryDashboardState extends State<DeliveryDashboard> {
  String selectedButton = 'New Order';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 231, 110, 34),
        title: const Text(
          'Subscription Orders',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OrderButtons(
                  buttonName: "New Order",
                  selectedButton: selectedButton,
                  onSelected: (name) {
                    setState(() {
                      selectedButton = name;
                    });
                  },
                ),
                OrderButtons(
                  buttonName: "On Going",
                  selectedButton: selectedButton,
                  onSelected: (name) {
                    setState(() {
                      selectedButton = name;
                    });
                  },
                ),
                OrderButtons(
                  buttonName: "Completed",
                  selectedButton: selectedButton,
                  onSelected: (name) {
                    setState(() {
                      selectedButton = name;
                    });
                  },
                )
                // TextButton(
                //     style: ButtonStyle(
                //         shape: WidgetStateProperty.all(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //             side:
                //                 BorderSide(color: Colors.orange, width: 1.5)))),
                //     onPressed: () {},
                //     child: Text(
                //       "New Order",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 15),
                //     )),
                // TextButton(
                //     style: ButtonStyle(
                //         shape: WidgetStateProperty.all(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //             side:
                //                 BorderSide(color: Colors.orange, width: 1.5)))),
                //     onPressed: () {},
                //     child: Text(
                //       "Ongoing",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 15),
                //     )),
                // TextButton(
                //     style: ButtonStyle(
                //         shape: WidgetStateProperty.all(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //             side:
                //                 BorderSide(color: Colors.orange, width: 1.5)))),
                //     onPressed: () {},
                //     child: Text(
                //       "Completed",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 15),
                //     )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
