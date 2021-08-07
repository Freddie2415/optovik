import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/counter/counter_cubit.dart';
import 'package:optovik/domain/bloc/other_products/other_products_bloc.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/products_module.dart';
import 'package:optovik/presentation/widgets/counter_button_widget.dart';
import 'package:optovik/presentation/widgets/description_text_widget.dart';
import 'package:optovik/presentation/widgets/info_section_widget.dart';
import 'package:optovik/presentation/widgets/product_images_widget.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final CounterCubit _counterCubit;

  ProductDetailPage(this.product, this._counterCubit, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryId =
        product.categories.isNotEmpty ? product.categories.last : null;

    product.images
        .forEach((imageUrl) => precacheImage(NetworkImage(imageUrl), context));

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).aboutProduct)),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ProductImagesWidget(images: this.product.images),
              ),
              Text(
                "${this.product.title}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.unit}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CounterButtonWidget(this._counterCubit),
                  )
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.widgets_outlined,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "ПОДАРКИ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    ),
                    Spacer(),
                    Text(
                      "ID-${product.id}",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              InfoSection(list: []),
              Divider(),
              DescriptionTextWidget(product.description),
              Divider(),
              BlocBuilder(
                cubit: ProductsModule.otherProductsBloc()
                  ..add(FetchOtherProducts(categoryId, product.id)),
                builder: (context, state) {
                  if (state is OtherProductsFetched) {
                    return ProductSectionWidget(
                      title: S.of(context).nextToShelf,
                      products: state.products,
                      categoryId: categoryId,
                    );
                  }
                  return Container(width: 0, height: 0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
