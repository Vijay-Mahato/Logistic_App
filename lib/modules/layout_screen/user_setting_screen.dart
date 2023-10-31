import 'package:country_picker/country_picker.dart';
import 'package:fazeal_logistics/components/adaptive_widget.dart';
import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/color.dart';
import '../../components/constants.dart';
import '../../components/widgets.dart';

class UserSettingScreen extends StatelessWidget {
  UserSettingScreen({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);

    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is LogisticsGetUserDataLoadingState
              ? Center(child: AdaptiveIndicator(os: getOS()))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: mediaQuery.size.height * 0.3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(fifty),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: const [
                                      primaryLogisticColor,
                                      secondaryLogisticColor,
                                      subColorLogisticColor,
                                    ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(zero, one),
                                      blurRadius: four,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        isMobileDevice ? fourteen : twenty),
                                child: SafeArea(
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.removeProfileImage();
                                      cubit.removeDrivingLicenseImage();
                                      cubit.removeCardIdForDriverSettingImage();
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios_new,
                                            size: isMobileDevice
                                                ? thirty
                                                : thirtySix,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: isMobileDevice ? fifty : eightyFive,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobileDevice ? sixteen : twenty,
                            ),
                            child: SizedBox(
                              width: isMobileDevice
                                  ? oneHundredTwenty
                                  : oneHundredFifty,
                              height: isMobileDevice
                                  ? oneHundredTwenty
                                  : oneHundredFifty,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: isMobileDevice
                                        ? oneHundredTwenty
                                        : oneHundredFifty,
                                    height: isMobileDevice
                                        ? oneHundredTwenty
                                        : oneHundredFifty,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(zero, one),
                                            blurRadius: three,
                                            color: Colors.grey,
                                          )
                                        ]),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: cubit.profileImage != null
                                        ? Image.file(
                                            cubit.profileImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : MyApp.currentUser!
                                                    .userPersonalImageUrl ==
                                                null
                                            ? Image.asset(
                                                'assets/logisticAssets/defultProfileImage.png',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                '$amazonImagePath/${MyApp.currentUser!.userPersonalImageUrl}',
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            alertDialogSelectImage(
                                                context: context),
                                      ).then((value) async {
                                        cubit.addProfileImage(cubit.imageFile);
                                        if (cubit.profileImage != null) {
                                          cubit
                                              .uploadProfileImageDriverSetting();
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: isMobileDevice ? thirtyTwo : forty,
                                      height:
                                          isMobileDevice ? thirtyTwo : forty,
                                      padding: EdgeInsets.all(
                                          isMobileDevice ? five : ten),
                                      decoration: BoxDecoration(
                                        color: primaryLogisticColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: two,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Image.asset(
                                        'assets/logisticAssets/camera-01.png',
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: isMobileDevice ? twenty : thirty,
                      ),
                      Padding(
                        padding: EdgeInsets.all(isMobileDevice ? ten : sixteen),
                        child: Column(
                          children: [
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ten)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    isMobileDevice ? fourteen : twenty),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/signUpAssets/user-circle.png',
                                          width:
                                              isMobileDevice ? thirty : forty,
                                          height:
                                              isMobileDevice ? thirty : forty,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor
                                              .withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        Expanded(
                                          child: Text(
                                            MyApp.currentUser!.userName,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: isMobileDevice
                                                  ? sixteen
                                                  : twentyTwo,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: two,
                                                  color: Colors.grey[300]!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ten)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    isMobileDevice ? fourteen : twenty),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/signUpAssets/user-03.png',
                                          width:
                                              isMobileDevice ? thirty : forty,
                                          height:
                                              isMobileDevice ? thirty : forty,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor
                                              .withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${MyApp.currentUser!.firstName} ${MyApp.currentUser!.lastName}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: isMobileDevice
                                                  ? sixteen
                                                  : twentyTwo,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: two,
                                                  color: Colors.grey[300]!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ten)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    isMobileDevice ? fourteen : twenty),
                                child: Form(
                                  key: passwordKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/signUpAssets/lock-keyhole-circle.png',
                                            width:
                                                isMobileDevice ? thirty : forty,
                                            height:
                                                isMobileDevice ? thirty : forty,
                                            fit: BoxFit.contain,
                                            color: primaryLogisticColor
                                                .withOpacity(0.5),
                                          ),
                                          SizedBox(
                                            width:
                                                isMobileDevice ? ten : sixteen,
                                          ),
                                          Expanded(
                                            child: Text(
                                              changePassword.tr,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: isMobileDevice
                                                    ? sixteen
                                                    : twentyTwo,
                                                shadows: [
                                                  BoxShadow(
                                                    blurRadius: two,
                                                    color: Colors.grey[300]!,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                isMobileDevice ? ten : sixteen,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              oldPasswordController.clear();
                                              newPasswordController.clear();
                                              confirmPasswordController.clear();
                                              cubit.changePasswordOpen();
                                            },
                                            child: state
                                                    is LogisticsUpdatedPasswordLoadingState
                                                ? AdaptiveIndicator(os: getOS())
                                                : Image.asset(
                                                    'assets/logisticAssets/edit-04.png',
                                                    width: isMobileDevice
                                                        ? thirty
                                                        : forty,
                                                    height: isMobileDevice
                                                        ? thirty
                                                        : forty,
                                                    fit: BoxFit.contain,
                                                    color: softGrey,
                                                  ),
                                          ),
                                        ],
                                      ),
                                      if (cubit.isChangePasswordOpen)
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: isMobileDevice
                                                  ? sixteen
                                                  : twenty,
                                            ),
                                            logisticFormField(
                                              controller: oldPasswordController,
                                              isMobileDevice: isMobileDevice,
                                              labelText: oldPassword.tr,
                                              validator: (String? v) {
                                                if (v!.isEmpty) {
                                                  return 'old password required'
                                                      .tr;
                                                }
                                              },
                                              radiusField: fifteen,
                                            ),
                                            SizedBox(
                                              height: isMobileDevice
                                                  ? ten
                                                  : sixteen,
                                            ),
                                            logisticFormField(
                                              controller: newPasswordController,
                                              isMobileDevice: isMobileDevice,
                                              labelText: newPassword.tr,
                                              validator: (String? v) {
                                                if (v!.isEmpty) {
                                                  return 'new password required'
                                                      .tr;
                                                }
                                              },
                                              radiusField: fifteen,
                                            ),
                                            SizedBox(
                                              height: isMobileDevice
                                                  ? ten
                                                  : sixteen,
                                            ),
                                            logisticFormField(
                                              controller:
                                                  confirmPasswordController,
                                              isMobileDevice: isMobileDevice,
                                              labelText: confirmPassword.tr,
                                              validator: (String? v) {
                                                if (v!.isEmpty) {
                                                  return 'confirm password required'
                                                      .tr;
                                                }
                                              },
                                              radiusField: fifteen,
                                            ),
                                            SizedBox(
                                              height: isMobileDevice
                                                  ? ten
                                                  : sixteen,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                logisticButton2(
                                                  isMobileDevice:
                                                      isMobileDevice,
                                                  backgroundColor: Colors.white,
                                                  onPressed: () {
                                                    oldPasswordController
                                                        .clear();
                                                    newPasswordController
                                                        .clear();
                                                    confirmPasswordController
                                                        .clear();
                                                    cubit.changePasswordOpen();
                                                  },
                                                  buttonTitle: Text(
                                                    cancel.tr,
                                                    style: TextStyle(
                                                      fontSize: isMobileDevice
                                                          ? fourteen
                                                          : twenty,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: isMobileDevice
                                                      ? ten
                                                      : sixteen,
                                                ),
                                                logisticButton2(
                                                  isMobileDevice:
                                                      isMobileDevice,
                                                  onPressed: () {
                                                    if (passwordKey
                                                        .currentState!
                                                        .validate()) {
                                                      cubit.updatePassword(
                                                        oldPassword:
                                                            oldPasswordController
                                                                .text,
                                                        newPassword:
                                                            newPasswordController
                                                                .text,
                                                        confirmPassword:
                                                            confirmPasswordController
                                                                .text,
                                                      );
                                                    }
                                                  },
                                                  buttonTitle: Text(
                                                    save.tr,
                                                    style: TextStyle(
                                                      fontSize: isMobileDevice
                                                          ? fourteen
                                                          : twenty,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ten)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    isMobileDevice ? fourteen : twenty),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/signUpAssets/mail-05.png',
                                          width:
                                              isMobileDevice ? thirty : forty,
                                          height:
                                              isMobileDevice ? thirty : forty,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor
                                              .withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        Expanded(
                                          child: Text(
                                            MyApp.currentUser!.email,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: isMobileDevice
                                                  ? sixteen
                                                  : twentyTwo,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: two,
                                                  color: Colors.grey[300]!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            emailController.text =
                                                MyApp.currentUser!.email;
                                            cubit.changeEmailOpen();
                                          },
                                          child: state
                                                  is LogisticsUpdatedEmailLoadingState
                                              ? AdaptiveIndicator(os: getOS())
                                              : Image.asset(
                                                  'assets/logisticAssets/edit-04.png',
                                                  width: isMobileDevice
                                                      ? thirty
                                                      : forty,
                                                  height: isMobileDevice
                                                      ? thirty
                                                      : forty,
                                                  fit: BoxFit.contain,
                                                  color: softGrey,
                                                ),
                                        ),
                                      ],
                                    ),
                                    if (cubit.isEmailEditOpen)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: isMobileDevice
                                                ? sixteen
                                                : twenty,
                                          ),
                                          logisticFormField(
                                            controller: emailController,
                                            isMobileDevice: isMobileDevice,
                                            labelText: email.tr,
                                            validator: (String? v) {
                                              if (v!.isEmpty) {
                                                return "Email required".tr;
                                              }
                                            },
                                            radiusField: fifteen,
                                          ),
                                          SizedBox(
                                            height:
                                                isMobileDevice ? ten : sixteen,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  emailController.text =
                                                      MyApp.currentUser!.email;
                                                  cubit.changeEmailOpen();
                                                },
                                                buttonTitle: Text(
                                                  cancel.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: isMobileDevice
                                                    ? ten
                                                    : sixteen,
                                              ),
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                onPressed: () {
                                                  cubit.updateEmail(
                                                      updatedEmail:
                                                          emailController.text);
                                                },
                                                buttonTitle: Text(
                                                  save.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ten,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  isMobileDevice ? fourteen : twenty,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/signUpAssets/phone-call-01.png',
                                          width:
                                              isMobileDevice ? thirty : forty,
                                          height:
                                              isMobileDevice ? thirty : forty,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor
                                              .withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        Expanded(
                                          child: Text(
                                            MyApp.currentUser!.contactNumber,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: isMobileDevice
                                                  ? sixteen
                                                  : twentyTwo,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: two,
                                                  color: Colors.grey[300]!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            phoneController.text = MyApp
                                                .currentUser!.contactNumber;
                                            cubit.changeContactOpen();
                                          },
                                          child: state
                                                  is LogisticsUpdatedContactLoadingState
                                              ? AdaptiveIndicator(os: getOS())
                                              : Image.asset(
                                                  'assets/logisticAssets/edit-04.png',
                                                  width: isMobileDevice
                                                      ? thirty
                                                      : forty,
                                                  height: isMobileDevice
                                                      ? thirty
                                                      : forty,
                                                  fit: BoxFit.contain,
                                                  color: softGrey,
                                                ),
                                        ),
                                      ],
                                    ),
                                    if (cubit.isContactNumberOpen)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: isMobileDevice
                                                ? sixteen
                                                : twenty,
                                          ),
                                          Row(
                                            children: [
                                              StatefulBuilder(
                                                  builder: (context, setState) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    showCountryPicker(
                                                      countryListTheme:
                                                          CountryListThemeData(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    sixteen)),
                                                        bottomSheetHeight:
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                        textStyle: TextStyle(
                                                          fontSize:
                                                              isMobileDevice
                                                                  ? eighteen
                                                                  : thirty,
                                                        ),
                                                        flagSize: isMobileDevice
                                                            ? thirty
                                                            : forty,
                                                        searchTextStyle:
                                                            TextStyle(
                                                          fontSize:
                                                              isMobileDevice
                                                                  ? eighteen
                                                                  : thirty,
                                                        ),
                                                        inputDecoration:
                                                            InputDecoration(
                                                          suffixIcon: InkWell(
                                                            child: Icon(
                                                              Icons.search,
                                                              size: isMobileDevice
                                                                  ? thirtySix
                                                                  : fortyFive,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          hintText: 'search',
                                                          hintStyle: TextStyle(
                                                            fontSize:
                                                                isMobileDevice
                                                                    ? sixteen
                                                                    : twentySix,
                                                            color: Colors.grey,
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                            isMobileDevice
                                                                ? twenty
                                                                : twentyFour,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        ten),
                                                            borderSide:
                                                                BorderSide(
                                                              width: pointEight,
                                                              color: softGrey,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        ten),
                                                            borderSide:
                                                                BorderSide(
                                                              width: pointEight,
                                                              color: softGrey,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        ten),
                                                            borderSide:
                                                                BorderSide(
                                                              width: pointEight,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      context: context,
                                                      showPhoneCode: false,
                                                      onSelect:
                                                          (Country country) {
                                                        countryCodeController
                                                                .text =
                                                            "+${country.phoneCode}";
                                                        setState(() {});
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: isMobileDevice
                                                          ? fourteen
                                                          : eighteen,
                                                      horizontal: isMobileDevice
                                                          ? eighteen
                                                          : fourteen,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color:
                                                              primaryLogisticColor
                                                                  .withOpacity(
                                                                      0.4),
                                                          width: one,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    twelve)),
                                                    child: Text(
                                                      countryCodeController
                                                              .text.isEmpty
                                                          ? '+1'
                                                          : countryCodeController
                                                              .text,
                                                      style: TextStyle(
                                                        color:
                                                            countryCodeController
                                                                    .text
                                                                    .isEmpty
                                                                ? Colors.grey
                                                                : Colors
                                                                    .grey[600],
                                                        fontSize: isMobileDevice
                                                            ? fourteen
                                                            : twentyFour,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              SizedBox(
                                                width: isMobileDevice
                                                    ? ten
                                                    : sixteen,
                                              ),
                                              Expanded(
                                                child: logisticFormField(
                                                  controller: phoneController,
                                                  isMobileDevice:
                                                      isMobileDevice,
                                                  labelText: phoneNumber.tr,
                                                  validator: (String? v) {
                                                    if (v!.isEmpty) {
                                                      return "phone number is required"
                                                          .tr;
                                                    } else if (!v
                                                        .isPhoneNumber) {
                                                      return "enter valid phone number"
                                                          .tr;
                                                    }
                                                  },
                                                  radiusField: fifteen,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                isMobileDevice ? ten : sixteen,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  phoneController.text = MyApp
                                                      .currentUser!
                                                      .contactNumber;
                                                  cubit.changeContactOpen();
                                                },
                                                buttonTitle: Text(
                                                  cancel.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: isMobileDevice
                                                    ? ten
                                                    : sixteen,
                                              ),
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                onPressed: () {
                                                  cubit.updateContactNumber(
                                                      countryCode:
                                                          countryCodeController
                                                              .text,
                                                      contactNumber:
                                                          phoneController.text);
                                                },
                                                buttonTitle: Text(
                                                  save.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ten,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  isMobileDevice ? fourteen : twenty,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/logisticAssets/credit-card-02.png',
                                          width:
                                              isMobileDevice ? thirty : forty,
                                          height:
                                              isMobileDevice ? thirty : forty,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor
                                              .withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        Expanded(
                                          child: Text(
                                            licenseImage.tr,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: isMobileDevice
                                                  ? sixteen
                                                  : twentyTwo,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: two,
                                                  color: Colors.grey[300]!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            cubit.changeDrivingLicenseOpen();
                                          },
                                          child: state
                                                  is LogisticsUpdatedContactLoadingState
                                              ? AdaptiveIndicator(os: getOS())
                                              : Image.asset(
                                                  'assets/logisticAssets/edit-04.png',
                                                  width: isMobileDevice
                                                      ? thirty
                                                      : forty,
                                                  height: isMobileDevice
                                                      ? thirty
                                                      : forty,
                                                  fit: BoxFit.contain,
                                                  color: softGrey,
                                                ),
                                        ),
                                      ],
                                    ),
                                    if (cubit.isDrivingLicenseOpen)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: isMobileDevice
                                                ? sixteen
                                                : twenty,
                                          ),
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Container(
                                                  width: mediaQuery.size.width * 0.8,
                                                  height: isMobileDevice
                                                      ? oneHundredFifty
                                                      : twoHundred,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: softGrey, width: one),
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(ten),
                                                  ),
                                                  child:  cubit.drivingLicenseImageForDrivingSetting != null
                                                      ? Image.file(
                                                    cubit.drivingLicenseImageForDrivingSetting!,
                                                    fit: BoxFit.cover,
                                                  ): Image.network(
                                                    '$amazonImagePath/${MyApp.currentUser!
                                                        .userLicenceNumberImageUrl!}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        alertDialogSelectImage(
                                                            context: context),
                                                  ).then((value) async {
                                                    cubit.addDrivingLicenseImage(cubit.imageFile);
                                                  });
                                                },
                                                child: Container(
                                                  width: isMobileDevice ? thirtyTwo : forty,
                                                  height:
                                                  isMobileDevice ? thirtyTwo : forty,
                                                  padding: EdgeInsets.all(
                                                      isMobileDevice ? five : ten),
                                                  decoration: BoxDecoration(
                                                    color: primaryLogisticColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: two,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/logisticAssets/camera-01.png',
                                                    fit: BoxFit.contain,
                                                    color: Colors.white,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  cubit.removeDrivingLicenseImage();
                                                  cubit.changeDrivingLicenseOpen();
                                                },
                                                buttonTitle: Text(
                                                  cancel.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: isMobileDevice
                                                    ? ten
                                                    : sixteen,
                                              ),
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                onPressed: () {
                                                  if (cubit.drivingLicenseImageForDrivingSetting != null) {
                                                    cubit.uploadDrivingLicenseImageDriverSetting();
                                                  }
                                                },
                                                buttonTitle: Text(
                                                  save.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ten,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  isMobileDevice ? fourteen : twenty,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/logisticAssets/credit-card-02.png',
                                          width:
                                          isMobileDevice ? thirty : forty,
                                          height:
                                          isMobileDevice ? thirty : forty,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor
                                              .withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        Expanded(
                                          child: Text(
                                            drivingImage.tr,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: isMobileDevice
                                                  ? sixteen
                                                  : twentyTwo,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: two,
                                                  color: Colors.grey[300]!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileDevice ? ten : sixteen,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            cubit.changeCardIdOpen();
                                          },
                                          child: state
                                          is LogisticsUpdatedContactLoadingState
                                              ? AdaptiveIndicator(os: getOS())
                                              : Image.asset(
                                            'assets/logisticAssets/edit-04.png',
                                            width: isMobileDevice
                                                ? thirty
                                                : forty,
                                            height: isMobileDevice
                                                ? thirty
                                                : forty,
                                            fit: BoxFit.contain,
                                            color: softGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (cubit.isCardIdOpen)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: isMobileDevice
                                                ? sixteen
                                                : twenty,
                                          ),
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Container(
                                                  width: mediaQuery.size.width * 0.8,
                                                  height: isMobileDevice
                                                      ? oneHundredFifty
                                                      : twoHundred,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: softGrey, width: one),
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(ten),
                                                  ),
                                                  child:  cubit.cardIdForDriverSettingImage != null
                                                      ? Image.file(
                                                    cubit.cardIdForDriverSettingImage!,
                                                    fit: BoxFit.cover,
                                                  ): Image.network(
                                                    '$amazonImagePath/${MyApp.currentUser!
                                                        .userIdImageUrl!}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        alertDialogSelectImage(
                                                            context: context),
                                                  ).then((value) async {
                                                    cubit.addCardIdForDriverSettingImage(cubit.imageFile);
                                                  });
                                                },
                                                child: Container(
                                                  width: isMobileDevice ? thirtyTwo : forty,
                                                  height:
                                                  isMobileDevice ? thirtyTwo : forty,
                                                  padding: EdgeInsets.all(
                                                      isMobileDevice ? five : ten),
                                                  decoration: BoxDecoration(
                                                    color: primaryLogisticColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: two,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/logisticAssets/camera-01.png',
                                                    fit: BoxFit.contain,
                                                    color: Colors.white,
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  cubit.removeCardIdForDriverSettingImage();
                                                  cubit.changeCardIdOpen();
                                                },
                                                buttonTitle: Text(
                                                  cancel.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: isMobileDevice
                                                    ? ten
                                                    : sixteen,
                                              ),
                                              logisticButton2(
                                                isMobileDevice: isMobileDevice,
                                                onPressed: () {
                                                  if (cubit.cardIdForDriverSettingImage != null) {
                                                    cubit.uploadCardIdImageDriverSetting();
                                                  }
                                                },
                                                buttonTitle: Text(
                                                  save.tr,
                                                  style: TextStyle(
                                                    fontSize: isMobileDevice
                                                        ? fourteen
                                                        : twenty,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ten)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    isMobileDevice ? fourteen : twenty),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/signUpAssets/calendar-date.png',
                                      width: isMobileDevice ? thirty : forty,
                                      height: isMobileDevice ? thirty : forty,
                                      fit: BoxFit.contain,
                                      color:
                                          primaryLogisticColor.withOpacity(0.5),
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : sixteen,
                                    ),
                                    Expanded(
                                      child: Text(
                                        DateFormat.yMMMMd().format(
                                            DateTime.parse(MyApp
                                                .currentUser!.dateOfBirth)),
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: isMobileDevice
                                              ? sixteen
                                              : twentyTwo,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: two,
                                              color: Colors.grey[300]!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : sixteen,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                            Card(
                              elevation: three,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ten)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    isMobileDevice ? fourteen : twenty),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.transgender,
                                      size: isMobileDevice
                                          ? twentySix
                                          : thirtySix,
                                      color:
                                          primaryLogisticColor.withOpacity(0.5),
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : sixteen,
                                    ),
                                    Expanded(
                                      child: Text(
                                        MyApp.currentUser!.genderType,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: isMobileDevice
                                              ? sixteen
                                              : twentyTwo,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: two,
                                              color: Colors.grey[300]!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : sixteen,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isMobileDevice ? fourteen : twenty,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
