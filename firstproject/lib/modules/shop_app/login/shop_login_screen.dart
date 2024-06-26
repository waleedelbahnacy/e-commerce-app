import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstproject/modules/shop_app/register/shop_register_screen.dart';
import 'package:firstproject/modules/shop_app/shop_layout.dart';
import 'package:firstproject/shared/components/components.dart';
import 'package:firstproject/shared/components/constants.dart';
import 'package:firstproject/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../login_cubit.dart';
import '../../../login_state.dart';
import '../on_boarding/on_boarding_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
       listener: (context,state)
       {
         if(state is ShopLoginSuccessState)
         {
if(state.loginModel.status!)
  {
    print(state.loginModel.message);

CacheHelper.saveData(
  key:'token',
  value: state.loginModel.data!.token,
).then((value)
{
 token=state.loginModel.data!.token!;
 print(token);
  navigateAndFinish(context, ShopLayout(),);
});
  }else
    {
      print(state.loginModel.message);
      showToast(
        text: state.loginModel.message!,
        state: ToastStates.ERROR,
      );
      Fluttertoast.showToast(
          msg: state.loginModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
      );
    }
         }
       },
        builder: (context,state)
        {
         return  Scaffold (
           appBar: AppBar(),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'LOGIN',
                         style: Theme.of(context).textTheme.headline4?.copyWith(
                           color: Colors.black,
                         ),
                       ),
                       Text(
                         'Login now to browse our hot offers',
                         style: Theme.of(context).textTheme.bodyText1?.copyWith(
                           color: Colors.grey,
                         ),
                       ),
                       SizedBox(
                         height: 30.0,
                       ),
                       defaultFormField(
                         controller: emailController,
                         type: TextInputType.emailAddress,
                         validate: (String value) {
                           if (value.isEmpty) {
                             return 'please enter your email address';
                           }else{
                             return null;
                           }
                         },
                         label: 'Email Address',
                         prefix: Icons.email_outlined,
                         suffixpressed: () {}, onSubmit: (value) {  },
                       ),
                       SizedBox(
                         height: 15.0,
                       ),
                       defaultFormField(
                         controller: passwordController,
                         type: TextInputType.visiblePassword,
                         suffix:  ShopLoginCubit.get(context).suffix,
                         onSubmit :(value)
                           {

                           },
                         ispassword:  ShopLoginCubit.get(context).isPassword,
                           suffixpressed:
                               ()
                           {
                           },
                         validate: (String value) {
                           if (value.isEmpty) {
                             return 'password is too short';
                           }
                           else{
                             return null;
                           }
                         },
                         label: 'Password',
                         prefix: Icons.lock_outline,
                       ),
                       SizedBox(
                         height: 30.0,
                       ),
                       ConditionalBuilder(
                         condition: state is! ShopLoginLoadingState,
                         builder: (context)=>defaultButton(
                           onpressed:()
                           {
                             if(formKey.currentState!.validate())
                               {
                                 print("ggg");

                                 ShopLoginCubit.get(context).userLogin(email: emailController.text,
                                   password: passwordController.text,
                                 );
                               }

                           },
                           text: 'login',
                           isUpperCase: true,
                         ),
                         fallback :(context)=>Center(child: CircularProgressIndicator(),
                         ),
                       ),
                       SizedBox(
                         height: 15.0,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('Don\'t have an account?'),
                           defaultTextButton(
                             function:()
                             {
                               navigateTo(context,
                                   ShopRegisterScreen
                               );
                             },
                             text: 'Register',
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
        },
      ),
    );
  }
}
