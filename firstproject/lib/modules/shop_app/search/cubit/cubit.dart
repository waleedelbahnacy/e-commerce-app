import 'package:bloc/bloc.dart';
import 'package:firstproject/modules/shop_app/search/cubit/states.dart';
import 'package:firstproject/modules/shop_app/search_model.dart';
import 'package:firstproject/shared/network/remote/dio_helper.dart';
import 'package:firstproject/shared/network/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token:token,
      data: 
      {
      'text':text,
    },
    ).then((value) {
      print(value.data);
      model= SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}