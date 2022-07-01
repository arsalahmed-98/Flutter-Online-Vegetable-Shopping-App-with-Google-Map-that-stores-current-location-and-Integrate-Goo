import 'package:allinonestore/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class WishListProvider with ChangeNotifier {
  void addWishListProductData({
    String wishListProductId,
    String wishListProductImage,
    String wishListProductName,
    int wishListProductPrice,
    // int? wishListProductQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("WishListProducts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishListProducts")
        .doc(wishListProductId)
        .set(
      {
        "wishListProductId": wishListProductId,
        "wishListProductImage": wishListProductImage,
        "wishListProductName": wishListProductName,
        "wishListProductPrice": wishListProductPrice,
        // "wishListProductQuantity": wishListProductQuantity,
        "wishList": true,
      },
    );
  }

  List<ProductModel> wishList = [];

  void getWishLishtData() async {
    List<ProductModel> newList = [];
    QuerySnapshot wishListValue = await FirebaseFirestore.instance
        .collection("WishListProducts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishListProducts")
        .get();

    wishListValue.docs.forEach((element) {
      ProductModel productModel = ProductModel(
        productName: element.get("wishListProductName"),
        productId: element.get("wishListProductId"),
        productImage: element.get("wishListProductImage"),
        productPrice: element.get("wishListProductPrice"),
        productUnit: element.get("productUnit"),
      );
      newList.add(productModel);
    });
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishListProductsDataList {
    return wishList;
  }

  wishListDataDelete(wishListProductId) {
    FirebaseFirestore.instance
        .collection("WishListProducts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishListProducts")
        .doc(wishListProductId)
        .delete();
    notifyListeners();
  }
}
