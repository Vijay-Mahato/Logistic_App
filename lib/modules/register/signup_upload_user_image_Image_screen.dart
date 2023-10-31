import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/layout/logistic_layout.dart';
import 'package:fazeal_logistics/modules/register/signup_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/adaptive_widget.dart';
import '../../components/color.dart';
import '../../components/constants.dart';
import '../../components/widgets.dart';

class SignUpUploadUserImageScreen extends StatelessWidget {
  SignUpUploadUserImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);

    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: StatefulBuilder(builder: (context, setState) {
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: eight, right: eight, left: eight),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      size: isMobileDevice ? twentyFour : thirtySix,
                                      color: primaryLogisticColor,
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : twenty,
                                    ),
                                    Text(
                                      previousPage.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: primaryLogisticColor,
                                        fontSize: isMobileDevice ? sixteen : twentyFour,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/signUpAssets/fazeal_logistic_logo.png',
                              width: isMobileDevice ? twoHundred : threeHundred,
                              height:
                                  isMobileDevice ? oneHundred : oneHundredFifty,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              pleaseUploadYourImage.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryLogisticColor,
                                fontSize: isMobileDevice ? eighteen : twentyFour,
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? sixteen : twenty,
                            ),
                            InkWell(
                              onTap: () async {
                                await showDialog(context: context, builder: (context) => alertDialogSelectImage(context:context),).then((value) async {
                                  cubit.addPersonalImage(cubit.imageFile);
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(
                                    isMobileDevice ? sixteen : twenty),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: subColorLogisticColor.withOpacity(0.4),
                                    width: one,
                                  ),
                                  borderRadius:
                                  BorderRadiusDirectional.circular(five),
                                  color: primaryLogisticColor.withOpacity(0.1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/signUpAssets/camera-plus.png',
                                      width: isMobileDevice ? forty : fifty,
                                      height: isMobileDevice ? forty : fifty,
                                      fit: BoxFit.contain,
                                      color: primaryLogisticColor,
                                    ),
                                    SizedBox(
                                      height: isMobileDevice ? ten : sixteen,
                                    ),
                                    Text(
                                      clickToAttachImageFromCameraOrGallery.tr,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize:
                                        isMobileDevice ? fourteen : twentyTwo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? sixteen : twenty,
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(ten),
                                  ),
                                  width: double.infinity,
                                  height: isMobileDevice
                                      ? twoHundred
                                      : threeHundred,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: cubit.personalImage!=null?Image.file(
                                    cubit.personalImage!,
                                    fit: BoxFit.cover,
                                  ): Image.network(
                                    'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1480&t=st=1687184223~exp=1687184823~hmac=575be35684d3d0cd2b28db4d8fbf4df55e2e2d0d97496987ddbd8db2acee1f63',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if(cubit.personalImage!=null)
                                  InkWell(
                                    onTap: () {
                                      cubit.removePersonalImage();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: softGrey,
                                        radius:
                                        isMobileDevice ? fourteen : eighteen,
                                        child: Icon(
                                          Icons.clear,
                                          color: Colors.grey,
                                          size: isMobileDevice
                                              ? twentySix
                                              : thirtySix,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: isMobileDevice ? sixteen : twenty,
                            ),
                            state is LogisticsSignupLoadingState? Center(child: AdaptiveIndicator(os: getOS()),) : logisticButton(
                              isMobileDevice: isMobileDevice,
                              onPressed: () async {
                                if(cubit.personalImage!=null && cubit.registerData !=null){
                                    await cubit.signupUser(
                                      userName: cubit.registerData!.userName,
                                      password: cubit.registerData!.password,
                                      firstName: cubit.registerData!.firstName,
                                      lastName: cubit.registerData!.lastName,
                                      gender: cubit.registerData!.gender,
                                      email: cubit.registerData!.email,
                                      numberPhone: cubit.registerData!.phoneNumber,
                                      dateOfBirth: cubit.registerData!.dateOfBirth,
                                    ).then((value) {
                                      if(value){
                                        navigatePushAndRemoveUntil(context, SignUpVehicleScreen());
                                        cubit.clearRegisterDate();
                                      }
                                    });
                                }else{
                                  showToast(pleasePersonalPicture.tr, context);
                                }
                              },
                              buttonTitle: next.tr,
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
            );
          }),
        );
      },
    );
  }
}
