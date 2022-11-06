import 'package:fashion_app/const/AppColors.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/screens/components/details/details_screen.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => DetailsScreen(product: product))),
      child: Card(
        elevation: 5.0,
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Material(
                child: InkWell(
                  child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rs.${product.price}.00",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
