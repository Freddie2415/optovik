import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:optovik/domain/bloc/home/home_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/categories.dart';
import 'package:optovik/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:optovik/presentation/widgets/category_section_widget.dart';
import 'package:optovik/presentation/widgets/drawer_widget.dart';
import 'package:optovik/presentation/widgets/fault_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';
import 'package:optovik/presentation/widgets/slider_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.homeBloc);

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Optovik.uz"),
        actions: [
          IconButton(
            icon: Icon(Icons.widgets_outlined),
            onPressed: () {
              Navigator.of(context).push(CategoriesPage.route());
            },
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _body(),
      ),
      bottomNavigationBar: BottomAppBarWidget(isHome: true),
    );
  }

  _body() {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: homeBloc,
      builder: (context, state) {
        if (state is HomeLoading) {
          return LoadingWidget();
        }
        if (state is HomeError) {
          return FaultWidget(message: state.message);
        }
        if (state is HomeReady) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SliderWidget(
                  banners: state.banners,
                ),
                ProductSectionWidget(
                  title: S.of(context).specialOffers,
                  products: state.hotDeals,
                ),
                CategorySectionWidget(
                  title: S.of(context).allCollections,
                  categories: state.categories,
                ),
                ProductSectionWidget(
                  title: S.of(context).deliciousPrice,
                  products: state.hotProducts,
                ),
                ProductSectionWidget(
                  title: S.of(context).newProducts,
                  products: state.lastProducts,
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  static Route<Object> route() => MaterialPageRoute(
        builder: (context) =>
            HomePage(GetIt.instance.get<HomeBloc>()..add(HomeStart())),
      );

  Future<void> _refreshData() async {
    homeBloc.add(HomeEventRefresh());

    return homeBloc.firstWhere((e) => e is! HomeEventRefresh);
  }
}
