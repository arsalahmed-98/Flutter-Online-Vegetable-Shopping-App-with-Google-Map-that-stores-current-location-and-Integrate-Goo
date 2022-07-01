import 'package:allinonestore/models/product_model.dart';
import 'package:allinonestore/provider/wishlist_products_provider.dart';
import 'package:allinonestore/widgets/single_item.dart';
import 'package:allinonestore/widgets/wish_list_single_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider wishListProductProvider;
  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProductProvider.wishListDataDelete(delete.productId);
        Navigator.of(context).pop();
        // wishListProvider.deleteWishtList(delete.productId);
        // Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Are you sure you want to delete wishList Product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProductProvider = Provider.of(context);
    wishListProductProvider.getWishLishtData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd6b738),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "WishList",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: wishListProductProvider.getWishListProductsDataList.length,
        itemBuilder: (context, index) {
          ProductModel data =
              wishListProductProvider.getWishListProductsDataList[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              WishListSingleItem(
                isBool: true,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                // productQuantity: data.productQuantity,
                onDelete: () {
                  showAlertDialog(context, data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
