import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/shop_app/cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width = double.infinity ,
   Color background = Colors.blue ,
  double radius=3.0,
  bool isUpperCase =true,
  required String text, required  Function() onpressed,
}) =>
    Container(
  width:width,
  height: 40.0,
  child: MaterialButton(
    onPressed:onpressed,
    child: Text(
        isUpperCase? text.toUpperCase(): text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),

  ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color:background,
      ),
);
Widget defaultTextButton({
required Function function,
  required String text,
})=>TextButton
  (
  onPressed:(){},
  child: Text(text.toUpperCase(),
  ),
);
Widget defaultButtonText({
  required  void Function()? function,
  required Text,
})=>TextButton(
  onPressed: function,
  child:Text,
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function (String)? onFieldSubmitted,
   void Function(String)?onChanged,
  bool ispassword =false,
   String? Function(String?)? validator,
    required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? onPressed, required String? Function(String value) validate, required Null Function() suffixpressed, required Null Function(dynamic value) onSubmit,
}) => TextFormField (
  controller:controller,
  keyboardType:type ,
  obscureText: ispassword,
  onFieldSubmitted:onFieldSubmitted,
  onChanged:onChanged,
  validator:validator,
  decoration:InputDecoration(
    labelText:label,
    prefixIcon: Icon(
      prefix,
    ),
     suffixIcon: suffix!=null ? IconButton(
       onPressed: onPressed,
       icon: Icon(
         suffix,
       ),
     ) : null,
    border: const OutlineInputBorder(),
  ),
);
Widget MyDivider()=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children:[
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: const DecorationImage(
              image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEO8cwxa1FbYG7SAz7_K1DUVx27G6AT1IEHw&usqp=CAU'),
              fit:BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    'title',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '2023-10-29T12:00:02Z',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
  ),
);
void navigateTo(context,widget)=> Navigator.push(context,
  MaterialPageRoute(
    builder:(context) =>widget,
  ),
);
void navigateAndFinish(context,widget,)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute
(
builder: (context)=>widget,
),
      (route) {
        return false;
      },
);
void showToast({required String text,
  required ToastStates state,
})=>   Fluttertoast.showToast(
  msg: text ,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.TOP,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
enum ToastStates {SUCCESS , ERROR , WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
      {
    case ToastStates.SUCCESS:
        color= Colors.green;
        break;
    case ToastStates.ERROR:
    color= Colors.red;
    break;
    case ToastStates.WARNING:
    color= Colors.amber;
    break;
  }
  return color;
}

Widget buildListProduct(model ,
    context,{
  bool isOldPrice = true,
    }) =>
    Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image!),
              width: 120.0,
              height: 120.0,
            ),
            if(model.discount !=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                    horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price!.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount !=0 && isOldPrice)
                    Text(
                      model.oldPrice!.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id!);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                      ShopCubit.get(context).favorites[model.id]!
                          ?defaultColor : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],

              ),
            ],
          ),
        ),
      ],
    ),
  ),
);