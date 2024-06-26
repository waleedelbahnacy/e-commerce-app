//POST
//UPDATE
//DELETE



//GET

// base line  :https://newsapi.org
// method :v2/top-headlines?
// query :country=us&category=business&apiKey=00362324b90a4dfd999d189e070e9faf

//https://newsapi.org/v2/everything?q=tesla&apiKey=00362324b90a4dfd999d189e070e9faf

import 'package:firstproject/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.removerData(key: 'token',).then((value){
    navigateAndFinish(context, ShopLoginScreen(),);

  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String ?token = '';