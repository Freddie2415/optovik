import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/counter/counter_cubit.dart';
import 'package:optovik/domain/bloc/other_products/other_products_bloc.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/products_module.dart';
import 'package:optovik/presentation/widgets/counter_btn.dart';
import 'package:optovik/presentation/widgets/my_separator.dart';
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
      appBar: AppBar(title: Text(S.current.aboutProduct)),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${this.product.title}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ProductImages(images: this.product.images),
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
                        // RichText(
                        //   text: TextSpan(
                        //     text: "52 500",
                        //     children: [
                        //       TextSpan(
                        //           text: " сум", style: TextStyle(fontSize: 12))
                        //     ],
                        //     style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 12,
                        //         decoration: TextDecoration.lineThrough,
                        //         decorationColor: Colors.red),
                        //   ),
                        // ),
                        // RichText(
                        //   text: TextSpan(
                        //       text: "49 800",
                        //       children: [
                        //         TextSpan(
                        //             text: " сум",
                        //             style: TextStyle(fontSize: 12))
                        //       ],
                        //       style:
                        //           TextStyle(fontSize: 16, color: Colors.black)),
                        // ),
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
                    child: CounterButton(this._counterCubit),
                  )
                ],
              ),
              Divider(),
              DescriptionText(product.description),
              // Divider(),
              // InfoSection(),
              // Divider(),
              BlocBuilder(
                cubit: ProductsModule.otherProductsBloc()
                  ..add(FetchOtherProducts(categoryId, product.id)),
                builder: (context, state) {
                  if (state is OtherProductsFetched) {
                    return ProductSectionWidget(
                      title: S.current.nextToShelf,
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

class CounterButton extends StatelessWidget {
  final CounterCubit _counterCubit;

  const CounterButton(this._counterCubit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _counterCubit,
      builder: (context, counter) {
        return SizedBox(
          height: 35,
          child: counter <= 0
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                  ),
                  onPressed: _counterCubit.increment,
                  child: Text(
                    S.current.addToCard,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : CounterBtn(
                  counter: counter,
                  onRemove: _counterCubit.decrement,
                  onAdd: _counterCubit.increment,
                ),
        );
      },
    );
  }
}

class ProductImages extends StatefulWidget {
  final List<String> images;

  const ProductImages({Key key, this.images}) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Image.asset("assets/images/banner-placeholder.jpg");
    }
    if (widget.images.length <= 1) {
      return FadeInImage.assetNetwork(
        placeholder: "assets/images/banner-placeholder.jpg",
        image: "${widget.images[0]}",
      );
    }
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlayCurve: Curves.easeOut,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.images
                .map(
                  (item) => Container(
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/banner-placeholder.jpg",
                        image: "$item"),
                  ),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.map((item) {
              int index = widget.images.indexOf(item);
              return Container(
                width: 7.0,
                height: 7.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.green : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DescriptionText extends StatefulWidget {
  final String text;

  const DescriptionText(this.text, {Key key}) : super(key: key);

  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  int maxLines = 3;

  @override
  Widget build(BuildContext context) {
    if (widget.text == null || widget.text.isEmpty) {
      return Container(width: 0.0, height: 0.0);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${widget.text}',
            style: TextStyle(
              color: Colors.black,
            ),
            maxLines: maxLines,
          ),
          SizedBox(
            height: 5,
          ),
          maxLines <= 3
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      maxLines = 1000;
                    });
                  },
                  child: Text(
                    " ${S.current.more}",
                    style: TextStyle(color: Colors.green),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}

class InfoSection extends StatefulWidget {
  @override
  _InfoSectionState createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  List<Map> list = [
    {"option": "Категория", "value": "Молоко, сыр, яйца"},
    {"option": "Бренд", "value": "Просто Азбука"},
    {"option": "Страна производитель", "value": "Россия"},
    {"option": "Рекомендуемая температура хранения", "value": "0 .. +20C"},
    {"option": "Срок годности", "value": "10  сут."},
    {
      "option": "Условия хранения",
      "value":
          "Внешний вид сезонного товара может отличаться от представленного на фотографии."
    },
  ];
  bool readMore = false;

  @override
  void initState() {
    readMore = list.length <= 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map> infoList = [];
    if (readMore) {
      infoList = list;
    } else {
      infoList = list.sublist(0, 3);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.info,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        !readMore
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    readMore = true;
                  });
                },
                child: Text(
                  " ${S.current.more}",
                  style: TextStyle(color: Colors.green),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}

class InfoTile extends StatelessWidget {
  final String option;
  final String value;
  final Function onTap;
  final TextStyle textStyle = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  InfoTile({
    Key key,
    this.option,
    this.value,
    this.onTap,
  })  : assert(option != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$option:",
                style: textStyle,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "$value",
                  style: textStyle,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DashSeparator(
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
