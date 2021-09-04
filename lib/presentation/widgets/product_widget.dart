import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/counter/counter_cubit.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/presentation/pages/product_detail.dart';

import 'counter_btn.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final String id;
  final String name;
  final String price;
  final String oldPrice;
  final String promo;
  final String image;
  final String unit;
  final Color promoColor;
  final CounterCubit _counterCubit;

  const ProductWidget(
    this.product,
    this._counterCubit, {
    Key key,
    this.id,
    this.name,
    this.price,
    this.oldPrice = "",
    this.promo = "",
    this.image,
    this.unit,
    this.promoColor = Colors.transparent,
  }) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _listener(context, this.widget.product.qty);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterCubit, int>(
      cubit: widget._counterCubit,
      listenWhen: (previous, current) => current != previous,
      listener: _listener,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        splashColor: Colors.indigo,
        onTap: onClick,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.grey, width: 0.5, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/placeholder.jpg",
                        image: "${widget.image}",
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/placeholder.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "${widget.oldPrice}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                              ),
                            ),
                            Text(
                              "${widget.price}",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.unit}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 100),
                        child: FlatButton(
                          minWidth: 40,
                          padding: EdgeInsets.all(0),
                          color: Colors.indigo,
                          onPressed: onCartPress,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: BlocBuilder(
                        cubit: widget._counterCubit,
                        builder: (context, state) => CounterBtn(
                          height: _height,
                          counter: state,
                          onRemove: widget._counterCubit.decrement,
                          onAdd: widget._counterCubit.increment,
                        ),
                      ),
                    ),
                    duration: Duration(milliseconds: 100),
                    curve: Curves.linear,
                    reverseDuration: Duration(milliseconds: 100),
                    vsync: this,
                  ),
                ],
              ),
              Positioned(
                child: promoWidget(),
                top: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget promoWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 100 / 81 * MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        color: widget.promo.isNotEmpty ? Colors.red : Colors.transparent,
        padding: EdgeInsets.all(5.0),
        child: Text(
          widget.promo,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          // maxLines: 1,
        ),
      ),
    );
  }

  void onCartPress() {
    showCounter();
    widget._counterCubit.increment();
  }

  void onClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(
          widget.product,
          widget._counterCubit,
        ),
      ),
    );
  }

  hideCounter() {
    setState(() {
      _visible = true;
      _height = 0;
    });
  }

  void showCounter() {
    setState(() {
      _height = 35;
      _visible = false;
    });
  }

  void _listener(BuildContext context, int state) {
    state > 0 ? showCounter() : hideCounter();
  }
}
