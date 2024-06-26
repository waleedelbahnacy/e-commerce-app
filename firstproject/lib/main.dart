import 'package:firstproject/modules/shop_app/cubit/cubit.dart';
import 'package:firstproject/modules/shop_app/cubit/states.dart';
import 'package:firstproject/modules/shop_app/login/shop_login_screen.dart';
import 'package:firstproject/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:firstproject/modules/shop_app/shop_layout.dart';
import 'package:firstproject/shared/components/constants.dart';
import 'package:firstproject/shared/network/local/cache_helper.dart';
import 'package:firstproject/shared/network/remote/dio_helper.dart';
import 'package:firstproject/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark')??false;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget ?widget;
  if(onBoarding !=null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else
    {
      widget = OnBoardingScreen();
    }

   runApp( MyApp(
       isDark:isDark!,
     startWidget: widget,
   ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp(
      {required this.isDark,
        required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience()..changeAppMode(sharedPreference: isDark,),),
      BlocProvider(create: (BuildContext context)=> ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      ),
    ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,

            home: startWidget,
          );
        },
      ),
    );
  }
}
