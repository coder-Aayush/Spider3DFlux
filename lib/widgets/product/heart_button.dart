import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart' show Product, WishListModel;

class HeartButton extends StatelessWidget {
  final Product product;
  final double? size;
  final Color? color;

  HeartButton({Key? key, required this.product, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // My, Wishlist Out. ThingiVerse Api In.
      visible: false,
      child: ChangeNotifierProvider.value(
        value: Provider.of<WishListModel>(context, listen: false),
        child: Consumer<WishListModel>(
          builder: (BuildContext context, WishListModel model, _) {
            final isExist =
                model.products.indexWhere((item) => item.id == product.id) !=
                    -1;
            if (!isExist) {
              return IconButton(
                onPressed: () {
                  Provider.of<WishListModel>(context, listen: false)
                      .addToWishlist(product);
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.grey[100]!.withOpacity(0.75),
                  child: Icon(FontAwesomeIcons.heart,
                      color: Theme.of(context).accentColor.withOpacity(0.75),
                      size: size ?? 16.0),
                ),
              );
            }

            return IconButton(
              onPressed: () {
                Provider.of<WishListModel>(context, listen: false)
                    .removeToWishlist(product);
              },
              icon: CircleAvatar(
                backgroundColor: Colors.red.withOpacity(0.1),
                child: Icon(FontAwesomeIcons.solidHeart,
                    color: Colors.red[700]!.withOpacity(0.70),
                    size: size ?? 16.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
