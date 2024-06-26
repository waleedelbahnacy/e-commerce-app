import 'package:firstproject/modules/shop_app/cubit/cubit.dart';
import 'package:firstproject/modules/shop_app/cubit/states.dart';
import 'package:firstproject/modules/shop_app/login/shop_login_screen.dart';
import 'package:firstproject/modules/shop_app/search/search_screen.dart';
import 'package:firstproject/shared/components/components.dart';
import 'package:firstproject/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text
              (
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen(),);
                },
                icon: Icon(Icons.search),),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
bottomNavigationBar: BottomNavigationBar(
  onTap: (index)
  {
    cubit.changeBottom(index);
  },
   currentIndex: cubit.currentIndex,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label: 'categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ],
),

        );
      },
    );
  }
}
