import 'package:beer_barrel/core/constants.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: 20,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height / 2.8),
                    itemBuilder: (context, item) {
                      return const ProductItemWidget();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _profileIcon() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 36,
      width: 36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage(AssetHelper.profileIcon),
          ),
          color: BBColor.white),
    );
  }
}
