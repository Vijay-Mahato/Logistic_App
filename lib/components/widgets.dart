import 'dart:io';

import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../layout/logistic_layout.dart';
import '../modules/Login/login_screen.dart';
import '../shared/cache_helper.dart';
import 'color.dart';
import 'constants.dart';
import 'constants_empty.dart';

void navigatePushReplacement(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigatePushAndRemoveUntil(context, widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget logisticFormField({
  TextEditingController? controller,
  TextInputType? keyboardType = TextInputType.text,
  required bool isMobileDevice,
  bool obscureText = false,
  String? labelText,
  String? hintText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  void Function()? onTap,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  double radiusField = fifty,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,

    style: TextStyle(
      color: Colors.grey[600],
      fontSize: isMobileDevice ? fourteen : twentyFour,
    ),
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    onTap: onTap,
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryLogisticColor.withOpacity(0.4),
            width: one,
          ),
          borderRadius: BorderRadius.circular(radiusField)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryLogisticColor,
            width: one,
          ),
          borderRadius: BorderRadius.circular(radiusField)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryLogisticColor.withOpacity(0.4),
            width: one,
          ),
          borderRadius: BorderRadius.circular(radiusField)),
      contentPadding: EdgeInsets.symmetric(
        vertical: isMobileDevice ? fourteen : eighteen,
        horizontal: isMobileDevice ? eighteen : fourteen,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: isMobileDevice ? fourteen : twentyFour,
      ),
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: isMobileDevice ? fourteen : twentyFour,
      ),
      hintText: hintText,
      prefixIconConstraints: BoxConstraints(maxHeight: isMobileDevice?fortyFive:sixtyFive,maxWidth: isMobileDevice?fortyFive:sixtyFive),
      suffixIconConstraints: BoxConstraints(maxHeight: isMobileDevice?fortyFive:sixtyFive,maxWidth: isMobileDevice?fortyFive:sixtyFive),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    ),
  );
}

Widget logisticButton({
  required bool isMobileDevice,
  required void Function()? onPressed,
  required String buttonTitle,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryLogisticColor,
      disabledBackgroundColor: primaryLogisticColor.withOpacity(0.5),
      padding: EdgeInsets.symmetric(
        vertical: isMobileDevice ? fourteen : sixteen,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(
          fifty,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobileDevice ? sixteen : twentyFour,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}


enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;

      break;

    case ToastStates.ERROR:
      color = Colors.red;

      break;

    case ToastStates.WARNING:
      color = Colors.amber;

      break;
  }

  return color;
}


Future<bool?> showToast(msg, color) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 3,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14.0);

Future<bool?> showToastFailed(msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 14.0);

Future<File?> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  File? selectedImage;
  final pickedImage = await picker.pickImage(source: source);
  if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      return selectedImage;
  }
  return null;
}

Widget alertDialogSelectImage({required BuildContext context}) {
  final cubit = LogisticsCubit.get(context);

  return StatefulBuilder(
    builder: (context, setState) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(fifteen)
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Select File".tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: sixteen,
              backgroundColor: softGrey,
              child: Icon(
                Icons.close,
                color: kDefaultIconDarkColor,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height*0.12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    cubit.imageFile = await pickImage(ImageSource.camera);
                      Navigator.of(context).pop(); // Close the dialog
                  },
                  child: CircleAvatar(
                    radius: thirty,
                    backgroundColor: primaryLogisticColor,
                    child: CircleAvatar(
                      radius: twentyEight,
                      backgroundColor: babyGrey,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: thirtyFive,
                        color: primaryLogisticColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: fifty,
                ),
                GestureDetector(
                  onTap: () async {
                      cubit.imageFile = await pickImage(ImageSource.gallery);
                      Navigator.pop(context); // Close the dialog
                  },
                  child: CircleAvatar(
                    radius: thirty,
                    backgroundColor: primaryLogisticColor,
                    child: CircleAvatar(
                      radius: twentyEight,
                      backgroundColor: babyGrey,
                      child: Icon(
                        Icons.image_outlined,
                        size: thirtyFive,
                        color: primaryLogisticColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget spacesDivider({
  required double sizedBoxSize,
  double height = one
}) {
  return Column(
    children: [
      SizedBox(
        height: sizedBoxSize,
      ),
      Container(width: double.infinity,height: height, color: Colors.grey[300],),
      SizedBox(
        height: sizedBoxSize,
      ),
    ],
  );
}

Widget logisticButton2({
  required bool isMobileDevice,
  required void Function()? onPressed,
  required Widget buttonTitle,
  Color? backgroundColor = primaryLogisticColor
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      disabledBackgroundColor: primaryLogisticColor.withOpacity(0.5),
      padding: EdgeInsets.symmetric(
        vertical: isMobileDevice ? twelve : fourteen,
        horizontal: isMobileDevice ? eighteen : twenty,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(
          fifty,
        ),
      ),
    ),
    child: buttonTitle,
  );
}

Future<Widget> getInitScreen()async{
  accessToken = await CacheHelper.getData(key:'token');
  if(accessToken!=null){
    return LogisticsLayout();
  }else {
    return LoginScreen();
  }
}