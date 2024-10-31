import 'package:fazeal_logistics/components/widgets.dart';
import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/models/user_model.dart';
import 'package:fazeal_logistics/modules/Login/login_screen.dart';
import 'package:fazeal_logistics/modules/register/signup_upload_id_card_Image_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/color.dart';
import '../../components/constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  bool genderFill=false;

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
            return SingleChildScrollView(
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
                      padding: EdgeInsets.symmetric(horizontal: isMobileDevice ? ten : sixteen , vertical: isMobileDevice?thirty:forty),
                      child: Form(
                        key: signUpKey,
                        child: Card(
                          elevation: three,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ten)),
                          child: Padding(
                            padding: EdgeInsets.all(isMobileDevice ? five : sixteen),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/signUpAssets/fazeal_logistic_logo.png',
                                    width: isMobileDevice ? twoHundred : threeHundred,
                                    height:
                                        isMobileDevice ? oneHundred : oneHundredFifty,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    signUpToLogistics.tr,
                                    style: TextStyle(
                                      color: primaryLogisticColor,
                                      fontSize: isMobileDevice ? twenty : twentyFour,
                                    ),
                                  ),
                                  SizedBox(
                                    height: isMobileDevice ? sixteen : twenty,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: logisticFormField(
                                          controller: firstNameController,
                                          isMobileDevice: isMobileDevice,
                                          labelText: firstName.tr,
                                          validator: (String? v) {
                                            if (v!.isEmpty) {
                                              return "first name is required".tr;
                                            }
                                          },
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(five),
                                            child: Image.asset(
                                              'assets/signUpAssets/user-03.png',
                                              width: isMobileDevice ? twentyTwo : thirtyTwo,
                                              height: isMobileDevice ? twentyTwo : thirtyTwo,
                                              fit: BoxFit.contain,
                                              color: primaryLogisticColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: isMobileDevice ? ten : twenty,
                                      ),
                                      Expanded(
                                        child: logisticFormField(
                                          controller: lastNameController,
                                          isMobileDevice: isMobileDevice,
                                          labelText: lastName.tr,
                                          validator: (String? v) {
                                            if (v!.isEmpty) {
                                              return "last name is required".tr;
                                            }
                                          },
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(five),
                                            child: Image.asset(
                                              'assets/signUpAssets/users-02.png',
                                              width: isMobileDevice ? twentyTwo : thirtyTwo,
                                              height: isMobileDevice ? twentyTwo : thirtyTwo,
                                              fit: BoxFit.contain,
                                              color: primaryLogisticColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: isMobileDevice ? ten : sixteen,
                                  ),
                                  logisticFormField(
                                    controller: userNameController,
                                    isMobileDevice: isMobileDevice,
                                    labelText: userName.tr,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "user name is required".tr;
                                      }
                                    },
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(five),
                                      child: Image.asset(
                                        'assets/signUpAssets/user-circle.png',
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
                                    controller: emailController,
                                    isMobileDevice: isMobileDevice,
                                    labelText: email.tr,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "email is required";
                                      }
                                      if (!v.isEmail) {
                                        return "Enter valid email please somebody@example.com";
                                      }
                                    },
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(five),
                                      child: Image.asset(
                                        'assets/signUpAssets/mail-05.png',
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
                                    controller: phoneNumberController,
                                    isMobileDevice: isMobileDevice,
                                    labelText: phoneNumber.tr,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "phone number is required";
                                      }
                                    },
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(five),
                                      child: Image.asset(
                                        'assets/signUpAssets/phone-call-01.png',
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
                                    controller: dateOfBirthController,
                                    isMobileDevice: isMobileDevice,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "date of birth is required".tr;
                                      }
                                    },
                                    onTap: () async {
                                      final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: cubit.selectedDate,
                                        firstDate: DateTime(1900, 8),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: primaryLogisticColor,
                                                onPrimary: Colors.white,
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                    textStyle: TextStyle(
                                                        color: Colors
                                                            .white) // button text color
                                                    ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          cubit.selectedDate = picked;
                                          dateOfBirthController.text =
                                              DateFormat('yyyy/MM/dd').format(picked);
                                        });
                                      }
                                    },
                                    labelText: dateOfBirth.tr,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(five),
                                      child: Image.asset(
                                        'assets/signUpAssets/calendar-date.png',
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
                                  Container(
                                    padding: EdgeInsets.all(
                                        isMobileDevice ? five : ten),
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
                                            Icon(
                                              Icons.transgender,
                                              size: isMobileDevice
                                                  ? twentyTwo
                                                  : thirtyTwo,
                                              color: primaryLogisticColor
                                                  .withOpacity(0.5),
                                            ),
                                            SizedBox(
                                              width: isMobileDevice ? ten : sixteen,
                                            ),
                                            Expanded(
                                              child: Text(
                                                gender.tr,
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
                                              value: male,
                                              groupValue: cubit.genderType,
                                              onChanged: (v) {
                                                cubit.changeGender(v.toString());
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
                                                male.tr,
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: isMobileDevice
                                                      ? sixteen
                                                      : twentyFour,
                                                ),
                                              ),
                                            ),
                                            Radio(
                                              value: feMale,
                                              groupValue: cubit.genderType,
                                              onChanged: (v) {
                                                cubit.changeGender(v.toString());
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
                                                feMale.tr,
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: isMobileDevice
                                                      ? sixteen
                                                      : twentyFour,
                                                ),
                                              ),
                                            ),
                                            Radio(
                                              value: other,
                                              groupValue: cubit.genderType,
                                              onChanged: (v) {
                                                cubit.changeGender(v.toString());
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
                                                other.tr,
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
                                  if(genderFill)
                                    Text("please select gender option".tr, style: TextStyle(
                                      color: Colors.red,
                                      fontSize: twelve,
                                    ),),
                                  SizedBox(
                                    height: isMobileDevice ? ten : sixteen,
                                  ),
                                  logisticFormField(
                                    controller: passwordController,
                                    isMobileDevice: isMobileDevice,
                                    labelText: password.tr,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "password is required".tr;
                                      }
                                    },
                                    obscureText: !cubit.passwordVisible,
                                    suffixIcon: InkWell(
                                      onTap: cubit.changeVisibilityPassword,
                                      child: Padding(
                                        padding: EdgeInsets.all(five),
                                        child: cubit.passwordVisible? Image.asset(
                                          'assets/signUpAssets/eye.png',
                                          width: isMobileDevice ? twentyTwo : thirtyTwo,
                                          height: isMobileDevice ? twentyTwo : thirtyTwo,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor.withOpacity(0.5),
                                        ):  Image.asset(
                                          'assets/signUpAssets/eye-off.png',
                                          width: isMobileDevice ? twentyTwo : thirtyTwo,
                                          height: isMobileDevice ? twentyTwo : thirtyTwo,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor.withOpacity(0.5),
                                      ),
                                    ),
                                    ),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(eight),
                                      child: Image.asset(
                                        'assets/signUpAssets/lock-keyhole-circle.png',
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
                                    controller: passwordController2,
                                    isMobileDevice: isMobileDevice,
                                    labelText: confirmPassword.tr,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "password is required".tr;
                                      }
                                    },
                                    obscureText: !cubit.passwordVisible,
                                    suffixIcon: InkWell(
                                      onTap: cubit.changeVisibilityPassword,
                                      child: Padding(
                                        padding: EdgeInsets.all(five),
                                        child: cubit.passwordVisible? Image.asset(
                                          'assets/signUpAssets/eye.png',
                                          width: isMobileDevice ? twentyTwo : thirtyTwo,
                                          height: isMobileDevice ? twentyTwo : thirtyTwo,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor.withOpacity(0.5),
                                        ):  Image.asset(
                                          'assets/signUpAssets/eye-off.png',
                                          width: isMobileDevice ? twentyTwo : thirtyTwo,
                                          height: isMobileDevice ? twentyTwo : thirtyTwo,
                                          fit: BoxFit.contain,
                                          color: primaryLogisticColor.withOpacity(0.5),
                                      ),
                                    ),
                                    ),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(eight),
                                      child: Image.asset(
                                        'assets/signUpAssets/lock-keyhole-circle.png',
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Transform.scale(
                                        scale: isMobileDevice
                                            ? onePointOne
                                            : onePointTwo,
                                        child: Checkbox(
                                          value: cubit.isAcceptTermAndCondition,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          fillColor: MaterialStatePropertyAll(primaryLogisticColor),
                                          onChanged: (v) {
                                            cubit.changeAcceptTermAndCondition();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: isMobileDevice ? fifteen : twentyFive,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: byClick.tr,
                                            style: TextStyle(
                                              fontSize:
                                                  isMobileDevice ? twelve : twenty,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: terms.tr,
                                                style: TextStyle(
                                                    color: primaryLogisticColor,
                                                    fontSize: isMobileDevice
                                                        ? twelve
                                                        : twenty,
                                                    fontWeight: FontWeight.bold),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () async {},
                                              ),
                                              TextSpan(
                                                text: dataPolicy.tr,
                                                style: TextStyle(
                                                  color: primaryLogisticColor,
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twentyThree,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () async {},
                                              ),
                                              TextSpan(
                                                text: and.tr,
                                                style: TextStyle(
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              TextSpan(
                                                text: cookies.tr,
                                                style: TextStyle(
                                                    color: primaryLogisticColor,
                                                    fontSize: isMobileDevice
                                                        ? twelve
                                                        : twenty,
                                                    fontWeight: FontWeight.bold),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () async {},
                                              ),
                                              TextSpan(
                                                text: youCanReceiveViaSms.tr,
                                                style: TextStyle(
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              TextSpan(
                                                text: fromUsAndCanOptOutAnyTime.tr,
                                                style: TextStyle(
                                                  fontSize: isMobileDevice
                                                      ? twelve
                                                      : twenty,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: isMobileDevice ? ten : sixteen,
                                  ),
                                  logisticButton(
                                      isMobileDevice: isMobileDevice,
                                      onPressed: cubit.isAcceptTermAndCondition?() async{
                                        if(cubit.genderType.isNotEmpty){
                                          genderFill=false;
                                          setState((){});
                                        } else {
                                          genderFill=true;
                                          setState((){});
                                        }
                                        if(signUpKey.currentState!.validate() && cubit.genderType.isNotEmpty){
                                          if(passwordController.text==passwordController2.text){
                                            cubit.registerData=RegisterData(firstName: firstNameController.text, lastName:lastNameController.text, email:emailController.text, gender:cubit.genderType, dateOfBirth:dateOfBirthController.text , password:passwordController.text , phoneNumber:phoneNumberController.text , userName:userNameController.text);
                                            navigateTo(context,
                                                SignUpUploadIdCardImageScreen());
                                          }else{
                                            showToastFailed('The passwords is not the same'.tr);
                                          }

                                        }
                                      }:null,
                                      buttonTitle: next.tr,
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
            );
          }),
        );
      },
    );
  }
}
