import 'package:fazeal_logistics/components/widgets.dart';
import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/modules/Login/login_screen.dart';
import 'package:fazeal_logistics/modules/register/confirmation_screen.dart';
import 'package:fazeal_logistics/modules/register/signup_upload_vehicle_Image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/adaptive_widget.dart';
import '../../components/color.dart';
import '../../components/constants.dart';
import '../../components/constants_empty.dart';

class SignUpVehicleScreen extends StatelessWidget {
  SignUpVehicleScreen({Key? key}) : super(key: key);

  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController licensePlateNumberController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelNameController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController fuelTypeController = TextEditingController();
  TextEditingController mileAgeController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  GlobalKey<FormState> signUpVehicleKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);

    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: mediaQuery.size.height,
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
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobileDevice ? ten : sixteen , vertical: isMobileDevice?twenty:thirty),
                    child: Form(
                      key: signUpVehicleKey,
                      child: Card(
                        elevation: three,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ten)),
                        child: Padding(
                          padding: EdgeInsets.all(isMobileDevice ? ten : sixteen),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/signUpAssets/fazeal_logistic_logo.png',
                                  width: isMobileDevice ? twoHundred : threeHundred,
                                  height:
                                  isMobileDevice ? oneHundred : oneHundredFifty,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  addYourVehicle.tr,
                                  style: TextStyle(
                                    color: primaryLogisticColor,
                                    fontSize: isMobileDevice ? twenty : twentyFour,
                                  ),
                                ),
                                SizedBox(
                                  height: isMobileDevice ? ten : sixteen,
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                      isMobileDevice ? ten : fourteen),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadiusDirectional.circular(fifteen),
                                    border: Border.all(
                                      color: primaryLogisticColor.withOpacity(0.5),
                                      width: one,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/signUpAssets/rocket-02.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor
                                                .withOpacity(0.5),
                                          ),
                                          SizedBox(
                                            width: isMobileDevice ? ten : sixteen,
                                          ),
                                          Expanded(
                                            child: Text(
                                              drivingMethod.tr,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: isMobileDevice
                                                    ? sixteen
                                                    : twentyFour,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: CarMethod.CAR.name,
                                            groupValue: cubit.drivingMethod,
                                            onChanged: (v) {
                                              cubit.changeDrivingMethod(v.toString());
                                            },
                                            materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                            fillColor: MaterialStatePropertyAll(
                                                primaryLogisticColor),
                                          ),
                                          SizedBox(
                                            height: isMobileDevice ? five : ten,
                                          ),
                                          Expanded(
                                            child: Text(
                                              CarMethod.CAR.name.capitalizeFirst!.tr,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: isMobileDevice
                                                    ? sixteen
                                                    : twentyFour,
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            value: CarMethod.BICYCLE.name,
                                            groupValue: cubit.drivingMethod,
                                            onChanged: (v) {
                                              cubit.changeDrivingMethod(v.toString());
                                            },
                                            materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                            fillColor: MaterialStatePropertyAll(
                                                primaryLogisticColor),
                                          ),
                                          SizedBox(
                                            height: isMobileDevice ? five : ten,
                                          ),
                                          Expanded(
                                            child: Text(
                                              CarMethod.BICYCLE.name.capitalizeFirst!.tr,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: isMobileDevice
                                                    ? sixteen
                                                    : twentyFour,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: CarMethod.ON_FOOT.name,
                                            groupValue: cubit.drivingMethod,
                                            onChanged: (v) {
                                              cubit.changeDrivingMethod(v.toString());
                                            },
                                            materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                            fillColor: MaterialStatePropertyAll(
                                                primaryLogisticColor),
                                          ),
                                          SizedBox(
                                            height: isMobileDevice ? five : ten,
                                          ),
                                          Expanded(
                                            child: Text(
                                              CarMethod.ON_FOOT.name.replaceAll('_', ' ').capitalizeFirst!.tr,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: isMobileDevice
                                                    ? sixteen
                                                    : twentyFour,
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            value: CarMethod.VAN.name,
                                            groupValue: cubit.drivingMethod,
                                            onChanged: (v) {
                                              cubit.changeDrivingMethod(v.toString());
                                            },
                                            materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                            fillColor: MaterialStatePropertyAll(
                                                primaryLogisticColor),
                                          ),
                                          SizedBox(
                                            height: isMobileDevice ? five : ten,
                                          ),
                                          Expanded(
                                            child: Text(
                                              CarMethod.VAN.name.capitalizeFirst!.tr,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: isMobileDevice
                                                    ? sixteen
                                                    : twentyFour,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if(cubit.drivingMethod!=CarMethod.ON_FOOT.name)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: brandController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: brand.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/car-02.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: modelNameController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: modelName.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/award-01.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: vehicleTypeController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: vehicleType.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/bus.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: capacityController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: capacity.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/route.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: fuelTypeController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: fuelType.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Icon(
                                            Icons.local_gas_station,
                                            size: isMobileDevice ? twentyFour : thirtyFour,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: mileAgeController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: mileAge.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/speedometer-04.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: licensePlateNumberController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: licensePlateNumber.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/passport.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: yearController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: year.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/calendar.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: statusController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: vehicleStatus.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/message-check-circle.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? ten : sixteen,
                                      ),
                                      logisticFormField(
                                        controller: colorController,
                                        isMobileDevice: isMobileDevice,
                                        labelText: carColor.tr,
                                        validator: (text){
                                          if(text!.isEmpty){
                                            return "Required".tr;
                                          }
                                          return null;
                                        },
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(ten),
                                          child: Image.asset(
                                            'assets/signUpAssets/colors.png',
                                            width: isMobileDevice ? twentyTwo : thirtyTwo,
                                            height: isMobileDevice ? twentyTwo : thirtyTwo,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor.withOpacity(0.5),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                SizedBox(
                                  height: isMobileDevice ? ten : sixteen,
                                ),
                                state is LogisticsSignupLoadingState? Center(child: AdaptiveIndicator(os: getOS()),) : logisticButton(
                                  isMobileDevice: isMobileDevice,
                                  onPressed: () async{
                                    if(cubit.drivingMethod!=CarMethod.ON_FOOT.name) {
                                      if (signUpVehicleKey.currentState!
                                          .validate()) {
                                        await cubit.registerVehicle(
                                            modelName: modelNameController.text,
                                            year: yearController.text,
                                            status: statusController.text,
                                            color: colorController.text,
                                            mileAge: mileAgeController.text,
                                            licensePlateNumber: licensePlateNumberController
                                                .text,
                                            fuelType: fuelTypeController.text,
                                            drivingMethod: cubit.drivingMethod,
                                            capacity: capacityController.text,
                                            brand: brandController.text,
                                            type: vehicleTypeController.text)
                                            .then((value) {
                                          if (value) {
                                            navigatePushAndRemoveUntil(context,
                                                SignUpUploadVehicleImageScreen(
                                                  vehicleId: myVehicleId!,));
                                          } else {}
                                        });
                                      }
                                    }else{
                                      await cubit.registerVehicle(
                                          modelName: modelNameController.text,
                                          year: yearController.text,
                                          status: statusController.text,
                                          color: colorController.text,
                                          mileAge: mileAgeController.text,
                                          licensePlateNumber: licensePlateNumberController
                                              .text,
                                          fuelType: fuelTypeController.text,
                                          drivingMethod: cubit.drivingMethod,
                                          capacity: capacityController.text,
                                          brand: brandController.text,
                                          type: vehicleTypeController.text).then((value) {
                                         if(value){
                                           cubit.vehicleImage=null;
                                           navigateTo(context, ConfirmationScreen());
                                         }
                                      });
                                    }
                                  },
                                  buttonTitle: cubit.drivingMethod!=CarMethod.ON_FOOT.name?next.tr:add.tr,
                                ),
                                SizedBox(
                                  height: isMobileDevice ? ten : sixteen,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ifYouAlreadyHaveAccount.tr,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        isMobileDevice ? fourteen : twentyFour,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigatePushAndRemoveUntil(
                                            context, LoginScreen());
                                      },
                                      child: Text(
                                        login.tr,
                                        style: TextStyle(
                                          color: primaryLogisticColor,
                                          fontSize: isMobileDevice
                                              ? fourteen
                                              : twentyFour,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: isMobileDevice ? ten : twenty,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
