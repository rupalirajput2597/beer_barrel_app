import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../navigator/app_router.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    _cubit = context.read<HomeCubit>();
    _cubit.fetchBeerList(context);
    _scrollController = ScrollController();
    _onScrollPagination();
    super.initState();
  }

  //pagination on scroll
  _onScrollPagination() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubit.fetchBeerList(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 8.0, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _profileIcon(),
              _chooseBeerMsg(),
              _scrollableContent(),
            ],
          ),
        ),
      ),
    );
  }

  //Beer Initial Msg
  Widget _chooseBeerMsg() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16,
      ),
      child: Text(
        'Time to Cheers! Choose your beer...',
        style: TextStyle(
          color: BBColor.primaryGrey,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  //Beer Products List - Grid-List
  _scrollableContent() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        //showing loader while fetching products
        if (state is LoadingHomeState) {
          return _loader();
        }

        //showing Error Widget
        if (state is ErrorHomeState) {
          return _errorPage(state);
        }
        return Expanded(
          child: RefreshIndicator(
            color: BBColor.white,
            onRefresh: () async {
              _pullToRefresh();
            },
            child: _gridView(),
          ),
        );
      },
    );
  }

  _pullToRefresh() async {
    _cubit.beers = [];
    _cubit.pageNumber = 1;
    _cubit.fetchBeerList(context);
  }

  Widget _gridView() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(10),
      itemCount: _cubit.beers.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        mainAxisExtent: 296,
      ),
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            context.push(
              AppRouter.productDetailsPath,
              extra: _cubit.beers[i],
            );
          },
          child: ProductCard(_cubit.beers[i]),
        );
      },
    );
  }

  Widget _loader() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: BBColor.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _profileIcon() {
    return RoundedButton.profile(
      onTap: () {
        context.push(AppRouter.profilePath);
      },
    );
  }

  _errorPage(ErrorHomeState state) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ErrorPage(
            statusCode: state.statusCode,
            onRefresh: () {
              _cubit.fetchBeerList(context);
            },
          ),
        ],
      ),
    );
  }
}
