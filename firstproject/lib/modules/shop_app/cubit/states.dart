import 'package:firstproject/models/shop_app/login_model.dart';
import 'package:firstproject/modules/shop_app/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavouritesState extends ShopStates{}

class ShopSuccessChangeFavouritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates{}