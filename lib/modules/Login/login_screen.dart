import 'package:fazeal_logistics/components/adaptive_widget.dart';
import 'package:fazeal_logistics/components/widgets.dart';
import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/shared/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/color.dart';
import '../../components/constants.dart';
import '../../layout/logistic_layout.dart';
import '../register/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);
    // userNameController.text= CacheHelper.getData(key: "userName")??"";
    // passwordController.text= CacheHelper.getData(key: "password")??"";
    // cubit.isRememberMeChecked= CacheHelper.getData(key: 'rememberMe')??false;
    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {
        if(state is LogisticsLoginSuccessState){
          if(cubit.isRememberMeChecked){
            CacheHelper.saveData(key: "userName", value: userNameController.text);
            CacheHelper.saveData(key: "password", value: passwordController.text);
            CacheHelper.saveData(key: 'rememberMe', value: true);
          }else{
            CacheHelper.removeData(key: 'userName');
            CacheHelper.removeData(key: 'password');
            CacheHelper.saveData(key: 'rememberMe', value: false);
          }
          navigatePushAndRemoveUntil(context, LogisticsLayout());
        }
      },
      builder: (context, state){
        return Scaffold(
          body: Container(
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
                  padding: EdgeInsets.all(isMobileDevice ? ten : sixteen),
                  child: Form(
                    key: loginKey,
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
                                loginToLogistics.tr,
                                style: TextStyle(
                                  color: primaryLogisticColor,
                                  fontSize: isMobileDevice ? twenty : twentyFour,
                                ),
                              ),
                              SizedBox(
                                height: isMobileDevice ? sixteen : twenty,
                              ),
                              logisticFormField(
                                controller: userNameController,
                                isMobileDevice: isMobileDevice,
                                labelText: userName.tr,
                                validator: (String? v){
                                  if(v!.isEmpty){
                                    return userNameRequired.tr;
                                  }
                                },
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(eight),
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
                                controller: passwordController,
                                isMobileDevice: isMobileDevice,
                                labelText: password.tr,
                                obscureText: !cubit.passwordVisible,
                                validator: (String? v){
                                  if(v!.isEmpty){
                                    return passwordRequired.tr;
                                  }
                                },
                                suffixIcon: InkWell(
                                  onTap: cubit.changeVisibilityPassword,
                                  child: Padding(
                                    padding: EdgeInsets.all(eight),
                                    child: cubit.passwordVisible? Image.asset(
                                      'assets/signUpAssets/eye.png',
                                      width: isMobileDevice ? twentyTwo : thirtyTwo,
                                      height: isMobileDevice ? twentyTwo : thirtyTwo,
                                      fit: BoxFit.contain,
                                      color: primaryLogisticColor.withOpacity(0.5),
                                    ):Image.asset(
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
                              state is LogisticsLoginLoadingState? Center(child: AdaptiveIndicator(os: getOS()),) : logisticButton(
                                isMobileDevice: isMobileDevice,
                                onPressed: () {
                                  if(loginKey.currentState!.validate()){
                                    cubit.loginUser(userName: userNameController.text, password: passwordController.text);
                                  }
                                },
                                buttonTitle: login.tr,
                              ),
                              SizedBox(
                                height: isMobileDevice ? sixteen : twenty,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      ifYouDoNotHaveAccount.tr,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            isMobileDevice ? fourteen : twentyFour,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: isMobileDevice ? three : five,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        cubit.genderType = '';
                                        cubit.selectedDate = DateTime.now();
                                        navigateTo(context, SignUpScreen());
                                      },
                                      child: Text(
                                        signUp.tr,
                                        style: TextStyle(
                                          color: primaryLogisticColor,
                                          fontSize:
                                              isMobileDevice ? fourteen : twentyFour,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: isMobileDevice ? ten : twenty,
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale:
                                        isMobileDevice ? onePointOne : onePointTwo,
                                    child: Checkbox(
                                      value: cubit.isRememberMeChecked,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      fillColor: MaterialStateProperty.all(
                                          primaryLogisticColor),
                                      onChanged: (v) {
                                        cubit.changeRememberMe();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      rememberMe.tr,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            isMobileDevice ? fourteen : twentyFour,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: isMobileDevice ? ten : sixteen,
                                  ),
                                  Expanded(
                                    child: Text(
                                      forgetYourPassword.tr,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: primaryLogisticColor,
                                        fontSize:
                                            isMobileDevice ? fourteen : twentyFour,
                                      ),
                                    ),
                                  ),
                                ],
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
            ),
          ),
        );
      },
    );
  }
}
