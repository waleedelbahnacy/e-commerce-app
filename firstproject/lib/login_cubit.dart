import 'package:firstproject/login_state.dart';
import 'package:firstproject/shared/network/remote/dio_helper.dart';
import 'package:firstproject/shared/network/remote/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/shop_app/login_model.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }
  void resetPassword({
    required String email,

  })
  {
    DioHelper.postData(url: 'verify-email', data:{
      "email":email,

    }).then((value) {
      emit(verfiyEmailSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(verfiyEmailErrorState());
    });
  }
}