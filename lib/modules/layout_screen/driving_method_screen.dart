import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/adaptive_widget.dart';
import '../../components/color.dart';
import '../../components/constants.dart';

class DrivingMethodScreen extends StatelessWidget {
  const DrivingMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);

    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  'assets/signUpAssets/car-02.png',
                  width: isMobileDevice ? thirty : thirtyFour,
                  height: isMobileDevice ? thirty : thirtyFour,
                  fit: BoxFit.cover,
                  color: primaryLogisticColor,
                ),
                SizedBox(
                  width: isMobileDevice ? ten : fourteen,
                ),
                Expanded(
                  child: Text(
                    drivingMethod.tr,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: isMobileDevice ? sixteen : twenty,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: state is LogisticsGetDrivingMethodLoadingState?
          Center(child: AdaptiveIndicator(os: getOS()),):SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(
                isMobileDevice ? ten : sixteen,
              ),
              child: Column(
                children: [
                  Card(
                    elevation: three,
                    child: Padding(
                      padding: EdgeInsets.all(
                        isMobileDevice ? ten : sixteen,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chooseDrivingMethod.tr,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: isMobileDevice ? sixteen : twenty,
                            ),
                          ),
                          SizedBox(
                            height: isMobileDevice ? ten : sixteen,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(zero),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return carMethodsWidget(
                                  cubit.listOfDrivingMethodModel[index].drivingMethod!,
                                  isMobileDevice,
                                  cubit,
                                index,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: isMobileDevice ? ten : sixteen,
                              );
                            },
                            itemCount: cubit.listOfDrivingMethodModel.length,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget carMethodsWidget(
    String carType, bool isMobileDevice, LogisticsCubit cubit, int index) {
  return Row(
    children: [
      if (carType == CarMethod.BICYCLE.name)
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.directions_bike,
                size: isMobileDevice ? thirty : thirtyFour,
                color: primaryLogisticColor,
              ),
              SizedBox(
                width: isMobileDevice ? ten : fourteen,
              ),
              Expanded(
                child: Text(
                  CarMethod.BICYCLE.name.capitalizeFirst!.replaceAll('_', ' ').tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: isMobileDevice ? sixteen : twenty,
                  ),
                ),
              ),
            ],
          ),
        ),
      if (carType == CarMethod.ON_FOOT.name)
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.snowshoeing,
                size: isMobileDevice ? thirty : thirtyFour,
                color: primaryLogisticColor,
              ),
              SizedBox(
                width: isMobileDevice ? ten : fourteen,
              ),
              Expanded(
                child: Text(
                  CarMethod.ON_FOOT.name.capitalizeFirst!.replaceAll('_', ' ').tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: isMobileDevice ? sixteen : twenty,
                  ),
                ),
              ),
            ],
          ),
        ),
      if (carType == CarMethod.VAN.name)
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'assets/logisticAssets/truck-01.png',
                width: isMobileDevice ? thirty : thirtyFour,
                height: isMobileDevice ? thirty : thirtyFour,
                fit: BoxFit.cover,
                color: primaryLogisticColor,
              ),
              SizedBox(
                width: isMobileDevice ? ten : fourteen,
              ),
              Expanded(
                child: Text(
                  CarMethod.VAN.name.capitalizeFirst!.replaceAll('_', ' ').tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: isMobileDevice ? sixteen : twenty,
                  ),
                ),
              ),
            ],
          ),
        ),
      if (carType == CarMethod.CAR.name)
        Expanded(
          child: Row(
          children: [
            Image.asset(
              'assets/logisticAssets/car-01.png',
              width: isMobileDevice ? thirty : thirtyFour,
              height: isMobileDevice ? thirty : thirtyFour,
              fit: BoxFit.cover,
              color: primaryLogisticColor,
            ),
            SizedBox(
              width: isMobileDevice ? ten : fourteen,
            ),
            Expanded(
              child: Text(
                CarMethod.CAR.name.capitalizeFirst!.replaceAll('_', ' ').tr,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: isMobileDevice ? sixteen : twenty,
                ),
              ),
            ),
          ],
      ),
        ),
      Transform.scale(
        scale: isMobileDevice ? onePointOne : onePointTwo,
        child: Radio(
          value: carType,
          groupValue: cubit.divingMethodGroupValue,
          fillColor: MaterialStateProperty.all(primaryLogisticColor),
          onChanged: (v) {
            cubit.changeDrivingMethodGroupValue(v.toString());
            cubit.selectDrivingMethod(vehicleId: cubit.listOfDrivingMethodModel[index].id!);
          },
        ),
      ),
    ],
  );
}
