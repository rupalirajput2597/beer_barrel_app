import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/navigator/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<HomeCubit>();
    _cubit.fetchBeerList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BBColor.pageBackground,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _profileIcon(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Text(
                  'Time to Cheers! Choose your beer...',
                  style: TextStyle(
                      color: BBColor.primaryGrey, fontWeight: FontWeight.w700),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state is LoadingHomeState) {
                  return CircularProgressIndicator(
                    color: BBColor.white,
                  );
                }

                return Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: _cubit.beers.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 12,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height / 2.8),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTap: () {
                              context.push(AppRouter.productDetailsPath,
                                  extra: _cubit.beers[i]);
                            },
                            child: ProductItemWidget(_cubit.beers[i]));
                      }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  _profileIcon() {
    return GestureDetector(
      onTap: () {
        //  context.push(AppRouter.profilePath);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage(AssetHelper.profileIcon),
            ),
            color: BBColor.white),
      ),
    );
  }
}
