import 'package:fazeal_logistics/components/widgets.dart';
import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/modules/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/color.dart';
import '../../components/constants.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);

    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      primaryLogisticColor,
                      secondaryLogisticColor,
                      subColorLogisticColor
                    ],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobileDevice ? ten : sixteen,
                        vertical: isMobileDevice ? seventy : forty),
                    child: Card(
                      elevation: three,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ten)),
                      child: Padding(
                        padding: EdgeInsets.all(isMobileDevice ? ten : sixteen),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/signUpAssets/fazeal_logistic_logo.png',
                                  width: isMobileDevice
                                      ? twoHundred
                                      : threeHundred,
                                  height: isMobileDevice
                                      ? oneHundred
                                      : oneHundredFifty,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  successfullyRegistered.tr,
                                  style: TextStyle(
                                    color: primaryLogisticColor,
                                    fontSize:
                                        isMobileDevice ? twenty : twentyFour,
                                  ),
                                ),
                                SizedBox(
                                  height: isMobileDevice ? sixteen : twenty,
                                ),
                                Image.asset(
                                  'assets/signUpAssets/alarm-clock-check.png',
                                  width: isMobileDevice
                                      ? twoHundred
                                      : threeHundred,
                                  height: isMobileDevice
                                      ? oneHundred
                                      : oneHundredFifty,
                                  color: subColorLogisticColor,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: isMobileDevice ? sixteen : twenty,
                                ),
                                Text(
                                  confirmationMessage.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: secondaryLogisticColor,
                                    fontSize:
                                        isMobileDevice ? sixteen : twentyFour,
                                  ),
                                ),
                                SizedBox(
                                  height: isMobileDevice ? sixteen : twenty,
                                ),
                                logisticButton(
                                  isMobileDevice: isMobileDevice,
                                  onPressed: () {
                                    navigatePushAndRemoveUntil(
                                        context, LoginScreen());
                                  },
                                  buttonTitle: ok.tr,
                                ),
                                SizedBox(
                                  height: isMobileDevice ? sixteen : twenty,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
