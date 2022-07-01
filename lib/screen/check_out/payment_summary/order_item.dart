import 'package:allinonestore/models/review_cart_model.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel data;

  OrderItem({this.data});
  // bool isTrue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        data.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.cartName,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "Wt: " + data.cartUnit,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "\$${data.cartPrice}",
          ),
        ],
      ),
      subtitle: Text("Item Quantity: ${data.cartQuantity}"),
    );
  }
}
