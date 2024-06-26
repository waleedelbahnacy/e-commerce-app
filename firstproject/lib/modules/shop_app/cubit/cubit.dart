import 'package:firstproject/layout/shop_app/categories_model.dart';
import 'package:firstproject/models/shop_app/login_model.dart';
import 'package:firstproject/modules/shop_app/categories/categories_screen.dart';
import 'package:firstproject/modules/shop_app/change_favorites_model.dart';
import 'package:firstproject/modules/shop_app/cubit/states.dart';
import 'package:firstproject/modules/shop_app/favorites/favorites_screen.dart';
import 'package:firstproject/modules/shop_app/home_model.dart';
import 'package:firstproject/modules/shop_app/products/products_screen.dart';
import 'package:firstproject/modules/shop_app/settings/settings_screen.dart';
import 'package:firstproject/shared/components/constants.dart';
import 'package:firstproject/shared/network/remote/dio_helper.dart';
import 'package:firstproject/shared/network/remote/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorites_model.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=> BlocProvider.of(context);
  int currentIndex=0;
 List<Widget> bottomScreens =[
   ProductsScreen(),
   CategoriesScreen(),
   FavoritesScreen(),
   SettingsScreen(),
 ];

 void changeBottom(int index)
 {
   currentIndex = index;
   emit(ShopChangeBottomNavState());
 }
HomeModel ?homeModel;

 Map<int , bool> favorites = {};
 void getHomeData()
 {
   emit(ShopLoadingHomeDataState());
   
   DioHelper.getData(
     url: Home,
     token: token,
   ).then((value)
   {
     print(value.data);
homeModel = HomeModel.fromJson(value.data);

print(homeModel!.status);

     homeModel!.data!.products.forEach((element) {
       favorites.addAll({
         element.id !: element.inFavourites!,
       });
     });

     emit(ShopSuccessHomeDataState());
   }).catchError((error)
   {
   //  print(error.toString());
     emit(ShopErrorHomeDataState());
     });
 }

  CategoriesModel ?categoriesModel;
  void getCategories()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);


      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      //print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel ?changeFavoritesModel;

void changeFavorites(int productId)
{
  favorites [productId] = !favorites [productId]!;

  emit(ShopChangeFavouritesState());
DioHelper.postData(
    url: FAVOTITES,
    data: {
       'product_id' : productId,
    },
  token: token,
).then((value)
{
  changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
  print(value.data);
  
  if(!changeFavoritesModel!.status!)
    {
      favorites [productId] = !favorites [productId]!;

    }else
      {
        getFavorites();
      }
  emit(ShopSuccessChangeFavouritesState(changeFavoritesModel!));
}).catchError((error){

  favorites [productId] = !favorites [productId]!;
  emit(ShopErrorChangeFavouritesState());
});
}

  FavoritesModel ?favoritesmodel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url:FAVOTITES,
      token: token,
    ).then((value)
    {
      favoritesmodel = FavoritesModel.fromJson(value.data);
     // print(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
  ShopLoginModel ?userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print('get profile'+userModel!.data!.name!);
      }
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,

})
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url:UPDATE_PROFILE,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);


      print(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error)
    {
      print("jjfnljlnrenf");

      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}

