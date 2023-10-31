
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {

  // static String get fileNameForProd{
  //
  //     return '.env.prod';
  // }
  //
  // static String get fileNameForStg{
  //
  //     return '.env.stg';
  //
  // }

  static String get fileNameForKube{
      return '.env.kube';

  }

  static String get apiUrl{

    return dotenv.env['API_URL'] ?? 'API_URL not found!';
  }

  static String get apiUrlBusiness{

    return dotenv.env['BUSINESS_URL'] ?? 'API_URL not found!';
  }
}