import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstproject/modules/shop_app/cubit/cubit.dart';
import 'package:firstproject/modules/shop_app/cubit/states.dart';
import 'package:firstproject/shared/components/components.dart';
import 'package:firstproject/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var model = ShopCubit.get(context).userModel;
        nameController.text=model!.data?.name!??"";
        emailController.text=model!.data?.email??"";
        phoneController.text=model!.data?.phone??"";
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name  ,
                    validate:(String value)
                    {
                      if(value.isEmpty)
                      {
                        return'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person, suffixpressed: () {  },
                    onSubmit: (value) {  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate:(String value)
                    {
                      if(value.isEmpty)
                      {
                        return'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                    suffixpressed: () {  },
                    onSubmit: (value) {  },
                  ),
                SizedBox(
                  height: 20.0,
                ),
              
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate:(String value)
                  {
                    if(value.isEmpty)
                    {
                      return'phone must not be empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: Icons.phone,
                  suffixpressed: () {  },
                  onSubmit: (value) {  },
                ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    onpressed: () {
                      if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                    },
                    text:'update',
                  ),
                    SizedBox(
                  height: 20.0,
                 ),
                   defaultButton(
                     onpressed: () {
                       signOut(context);
                     },
                   text:'Logout',
                   ),
                  ],
              ),
            ),
          ),
          fallback: (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}