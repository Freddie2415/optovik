import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optovik/presentation/widgets/counter_btn.dart';
import 'package:optovik/presentation/widgets/my_separator.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final List<String> images;

  const ProductDetailPage({Key key, this.name, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("О товаре"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ProductImages(
                  images: images,
                ),
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
                        RichText(
                          text: TextSpan(
                            text: "52 500",
                            children: [
                              TextSpan(
                                  text: " сум", style: TextStyle(fontSize: 12))
                            ],
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text: "49 800",
                              children: [
                                TextSpan(
                                    text: " сум",
                                    style: TextStyle(fontSize: 12))
                              ],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                        Text(
                          "1 шт (500 г)",
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
                    child: CounterButton(),
                  )
                ],
              ),
              Divider(),
              DescriptionText(),
              Divider(),
              InfoSection(),
              Divider(),
              ProductSectionWidget(title: "Рядом на полке", products: [],),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterButton extends StatefulWidget {
  @override
  State createState() => _CounterButton();
}

class _CounterButton extends State<CounterButton>
    with SingleTickerProviderStateMixin {
  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return counter < 1
        ? FlatButton(
            height: 35,
            color: Colors.lightGreen,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            child: Text("В корзину"),
          )
        : CounterBtn(
            height: 35,
            initialIterator: counter,
            onRemove: () {
              setState(() {
                counter--;
              });
            },
            onAdd: () {
              setState(() {
                counter++;
              });
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
  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  int maxLines = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Описание",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Есть много вариантов Lorem Ipsum, но большинство из них имеет не всегда приемлемые модификации, например, юмористические вставки или слова, которые даже отдалённо не напоминают латынь. Если вам нужен Lorem Ipsum для серьёзного проекта, вы наверняка не хотите какой-нибудь шутки, скрытой в середине абзаца. Также все другие известные генераторы Lorem Ipsum используют один и тот же текст, который они просто повторяют, пока не достигнут нужный объём. Это делает предлагаемый здесь генератор единственным настоящим Lorem Ipsum генератором. Он использует словарь из более чем 200 латинских слов, а также набор моделей предложений. В результате сгенерированный Lorem Ipsum выглядит правдоподобно, не имеет повторяющихся абзацей или "невозможных" слов.',
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
                    " Подробнее",
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
          "Информация",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: infoList
              .map((e) => InfoTile(
                    option: "${e['option']}",
                    value: "${e['value']}",
                  ))
              .toList(),
        ),
        !readMore
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    readMore = true;
                  });
                },
                child: Text(
                  " Подробнее",
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
  final TextStyle textStyle = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  InfoTile({
    Key key,
    this.option,
    this.value,
  })  : assert(option != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        SizedBox(
          height: 5,
        ),
        MySeparator(
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
