import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:optovik/domain/bloc/products/products_bloc.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/domain/model/sort_type.dart';
import 'package:optovik/internal/dependencies/counter_module.dart';
import 'package:optovik/internal/dependencies/products_module.dart';
import 'package:optovik/presentation/pages/cart.dart';
import 'package:optovik/presentation/pages/filter.dart';
import 'package:optovik/presentation/pages/search.dart';
import 'package:optovik/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';
import 'package:optovik/presentation/widgets/product_widget.dart';
import 'package:optovik/presentation/widgets/sort_button_widget.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  final categoryId;
  final String query;
  final bool isSearchPage;

  ProductsPage({
    Key key,
    @required this.title,
    this.categoryId,
    this.query,
    this.isSearchPage = false,
  }) : super(key: key);

  factory ProductsPage.search(String query) {
    return ProductsPage(
      title: query,
      isSearchPage: true,
      categoryId: null,
      query: query,
    );
  }

  @override
  _ProductsPageState createState() => _ProductsPageState();

  static Route<Object> route({
    @required String title,
    String query,
    dynamic categoryId,
    bool isSearchPage = false,
  }) {
    return MaterialPageRoute(
      builder: (context) => ProductsPage(
        title: title,
        query: query,
        categoryId: categoryId,
        isSearchPage: isSearchPage,
      ),
    );
  }
}

class _ProductsPageState extends State<ProductsPage> {
  final _scrollController = ScrollController();
  final num _scrollThreshold = 200.0;
  ProductsBloc _productsBloc;
  Sort _sort = Sort();

  get _appBar => widget.isSearchPage
      ? null
      : AppBar(
          title: Text("${widget.title}"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(),
                );
              },
            ),
            SortPopupButton(onSelect: _onSelect),
          ],
        );

  @override
  void initState() {
    super.initState();
    _productsBloc = ProductsModule.productsBloc();
    _productsBloc.add(ProductsFetched(
      categoryId: widget.categoryId,
      sort: _sort,
      query: widget.query,
    ));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _productsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 8,
          ),
          child: BlocBuilder<ProductsBloc, ProductsState>(
            cubit: _productsBloc,
            builder: _builder,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  _productsBody(List<Product> products, bool hasReachedMax) {
    final List<ProductWidget> list = products
        .map((product) => ProductWidget(
              product,
              CounterModule.counterCubit(product),
              id: product.id.toString(),
              image: '${product.image}',
              name: product.title,
              price: '',
              unit: '',
            ))
        .toList();

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 2,
            childAspectRatio: 80 / 100,
          ),
          delegate: SliverChildListDelegate(list),
        ),
        SliverToBoxAdapter(
          child: BottomLoader(
            show: !hasReachedMax,
          ),
        )
      ],
    );
  }

  Widget _builder(BuildContext context, state) {
    if (state is ProductsInitial || state is ProductsLoading) {
      return LoadingWidget();
    }
    if (state is ProductsSuccess) {
      if (state.products.isEmpty) {
        return MessageWidget(message: widget.isSearchPage
            ? "Товар не найден"
            : "В этой категории нет товараров",);
      }
      return _productsBody(state.products, state.hasReachedMax);
    }
    if (state is ProductsFailure) {
      return FailureWidget(
        message: state.message,
        onBtnPressed: () {
          _productsBloc.add(ProductsFetched(
            categoryId: widget.categoryId,
            sort: _sort,
            query: widget.query,
          ));
        },
      );
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _productsBloc.add(ProductsFetched(
        sort: _sort,
        categoryId: widget.categoryId,
        query: widget.query,
      ));
    }
  }

  _onSelect(SortType sortType) {
    _sort = Sort(sortType: sortType);
    _productsBloc.add(ProductsFetched(
      categoryId: widget.categoryId,
      sort: _sort,
      query: widget.query,
    ));
  }
}

class BottomLoader extends StatelessWidget {
  final bool show;

  const BottomLoader({Key key, @required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: SizedBox(
                height: 33,
                width: 33,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              ),
            ),
          )
        : Container(width: 0, height: 0);
  }
}
