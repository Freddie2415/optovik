import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/collection_detail.dart';

class CollectionWidget extends StatelessWidget {
  final String name;
  final String image;

  const CollectionWidget({Key key, this.name, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionDetailPage(),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(color: Colors.grey,width: 0.5),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage("$image"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.15),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "$name",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
