import 'package:fazeal_logistics/components/stats_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatsColumn(label: 'Due amount', value: '\$ 0.0'),
            StatsColumn(label: 'Orders delivered', value: '4'),
            StatsColumn(label: 'Total earnings', value: '\$ 0.0'),
          ],
        ),
      ),
    );
  }
}