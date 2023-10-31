
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/cache_helper.dart';


class MyLocaleController extends GetxController{

  Locale initialLang= CacheHelper.getData(key: "lang")== null? Get.deviceLocale! : Locale(CacheHelper.getData(key: "lang")) ;

  void changeLang(String codeLange){
    Locale locale= Locale(codeLange);
    CacheHelper.saveData(key: "lang", value: codeLange);
    Get.updateLocale(locale);
  }

}