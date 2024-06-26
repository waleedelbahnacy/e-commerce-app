import 'package:firstproject/modules/shop_app/search/cubit/cubit.dart';
import 'package:firstproject/modules/shop_app/search/cubit/states.dart';
import 'package:firstproject/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var SearchController =TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener:(context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                      defaultFormField(
                        controller: SearchController,
                          type: TextInputType.text,
                          label: 'Search',
                          prefix: Icons.search,
                          validate: (String value)
                        {
                          if(value.isEmpty)
                            {
                              return 'enter text to search';
                            }
                          return null;
                        },
                          suffixpressed: (){},
                          onSubmit: ( text)
                          {
                            SearchCubit.get(context).search(text);
                          },
                        onChanged: ( text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(itemBuilder: (context, index) =>buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false,),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 0.5,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                        ),
                        itemCount : SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}