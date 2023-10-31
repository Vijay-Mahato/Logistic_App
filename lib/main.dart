import 'package:fazeal_logistics/layout/cubit/cubit.dart';
import 'package:fazeal_logistics/models/user_model.dart';
import 'package:fazeal_logistics/shared/bloc_observer.dart';
import 'package:fazeal_logistics/shared/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'Locale/locale.dart';
import 'Locale/locale_controller.dart';
import 'components/color.dart';
import 'components/constants_empty.dart';
import 'components/widgets.dart';
import 'models/enviroment.dart';
import 'modules/Login/login_screen.dart';

void main()async {
  await dotenv.load(fileName: Enviroment.fileNameForKube);
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  final Widget screen= await getInitScreen();
  Bloc.observer= AppBlocObserver();
  runApp(MyApp(startScreen: screen,));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  const MyApp({super.key, required this.startScreen});
  static UserDataModel? currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLang= Get.put(MyLocaleController());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => LogisticsCubit()..getUserData(),
        ),
      ],
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        translations:MyLocale(),
        locale: controllerLang.initialLang,
        home: startScreen,
        theme: ThemeData(
          primaryColor: primaryLogisticColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(
                color: Colors.grey[600],
              ),
          ),
        ),
      ),
    );
  }
}
