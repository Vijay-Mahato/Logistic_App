import 'package:fazeal_logistics/components/adaptive_widget.dart';
import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/color.dart';
import '../../components/constants.dart';

class DrivingMethodInfoScreen extends StatelessWidget {
  const DrivingMethodInfoScreen({Key? key}) : super(key: key);

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
                  'assets/signUpAssets/speedometer-04.png',
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
                    drivingMethodInfo.tr,
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
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(zero),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: three,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ten)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            isMobileDevice ? ten : sixteen,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  carMethodsAssets(
                                    cubit.listOfDrivingMethodModel[index].drivingMethod!,
                                    isMobileDevice,
                                    cubit,
                                  ),
                                  SizedBox(
                                    width: isMobileDevice ? ten : fourteen,
                                  ),
                                  Expanded(
                                    child: Text(
                                      cubit.listOfDrivingMethodModel[index].drivingMethod!
                                          .capitalizeFirst!
                                          .replaceAll('_', ' ')
                                          .tr,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            isMobileDevice ? sixteen : twenty,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: isMobileDevice ? ten : sixteen,
                              ),
                              if(cubit.listOfDrivingMethodModel[index].vehicleImages!.isNotEmpty)
                              Container(
                                height: isMobileDevice
                                    ? twoHundred
                                    : twoHundredFifty,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(ten)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  'https://img.freepik.com/premium-photo/blue-sports-car-abstract-futuristic-concrete-architecture-3d-render_103577-6440.jpg?w=2000',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if(cubit.listOfDrivingMethodModel[index].vehicleImages!.isNotEmpty)
                              SizedBox(
                                height: isMobileDevice ? ten : sixteen,
                              ),
                              if(cubit.listOfDrivingMethodModel[index].drivingMethod != CarMethod.ON_FOOT.name)
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${speed.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].mileAge}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${brand.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].brand}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${modelName.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].modelName}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${capacity.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].capacity}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${fuelType.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].fuelType}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${year.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].year}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${vehicleStatus.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].status}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              isMobileDevice ? ten : sixteen,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${carColor.tr}: ',
                                              style: TextStyle(
                                                color: secondaryLogisticColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isMobileDevice
                                                    ? fourteen
                                                    : twenty,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${cubit.listOfDrivingMethodModel[index].color}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(cubit.listOfDrivingMethodModel[index].drivingMethod == CarMethod.ON_FOOT.name)
                              Row(
                                children: [
                                  Text(
                                    '${vehicleStatus.tr}: ',
                                    style: TextStyle(
                                      color: secondaryLogisticColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobileDevice
                                          ? fourteen
                                          : twenty,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${cubit.listOfDrivingMethodModel[index].status}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: isMobileDevice
                                            ? twelve
                                            : twenty,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: isMobileDevice ? ten : sixteen,
                      );
                    },
                    itemCount: cubit.listOfDrivingMethodModel.length,
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


dynamic carMethodsAssets(
    String carType, bool isMobileDevice, LogisticsCubit cubit) {
  if (carType == CarMethod.BICYCLE.name) {
    return Icon(
      Icons.directions_bike,
      size: isMobileDevice ? thirty : thirtyFour,
      color: primaryLogisticColor,
    );
  } else if (carType == CarMethod.ON_FOOT.name) {
    return Icon(
      Icons.snowshoeing,
      size: isMobileDevice ? thirty : thirtyFour,
      color: primaryLogisticColor,
    );
  } else if (carType == CarMethod.VAN.name) {
    return Image.asset(
      'assets/logisticAssets/truck-01.png',
      width: isMobileDevice ? thirty : thirtyFour,
      height: isMobileDevice ? thirty : thirtyFour,
      fit: BoxFit.cover,
      color: primaryLogisticColor,
    );
  } else {
    return Image.asset(
      'assets/logisticAssets/car-01.png',
      width: isMobileDevice ? thirty : thirtyFour,
      height: isMobileDevice ? thirty : thirtyFour,
      fit: BoxFit.cover,
      color: primaryLogisticColor,
    );
  }
}
