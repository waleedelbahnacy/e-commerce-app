import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstproject/modules/shop_app/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class FavoritesScreen extends StatelessWidget   {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(itemBuilder: (context, index) =>buildFavItem(ShopCubit.get(context).favoritesmodel!.data!.data![index],context),
             separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                height: 0.5,
                width: double.infinity,
                color: Colors.black,
              ),
            ),
            itemCount : ShopCubit.get(context).favoritesmodel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildFavItem(FavoritesData model,context)=> Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
    child: Column(
      children:
      [
        Row(
          children:
          [
            SizedBox(
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children:
                [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 140,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image:NetworkImage(model.product!.image!),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  if(model.product!.discount!=0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    model.product!.name! ==null? 'm':model.product!.name! ,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children:
                    [
                      const Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 15,),),
                      const SizedBox(width: 5,),
                      Text(
                        model.product!.price.toString() ==null? 'm':model.product!.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                      ),

                      const Spacer(),
                      IconButton(onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.product!.id!);

                      }, icon: CircleAvatar(
                        radius: 13,
                        backgroundColor:  ShopCubit.get(context).favorites[model.product!.id]!?Colors.red:Colors.grey,
                        child: const Icon(Icons.favorite,color: Colors.white,size: 13,),),iconSize: 12,),

                    ],
                  ),
                  Row(
                    children: [
                      const Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 15,),),
                      const SizedBox(width: 5,),
                      Text(
                        model.product!.oldPrice.toString() ==null? 'm':model.product!.oldPrice.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                      const SizedBox(width: 5,),
                      if(model.product!.discount!=0)

                        Text('${model.product!.discount ==null? 'm': model.product!.discount}'+ ' % OFF',style: const TextStyle(color: Colors.red,fontSize: 11),),

                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
