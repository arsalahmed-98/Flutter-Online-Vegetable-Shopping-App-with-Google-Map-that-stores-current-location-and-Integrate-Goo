import 'package:allinonestore/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> herbsProductList = [];
  ProductModel productModel;

  List<ProductModel> search = [];

  List<ProductModel> fruitsProductsList = [];

  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productUnit: element.get("productUnit"),
    );
    search.add(productModel);
  }

  fetchHerbsProdcutData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  fetchFruitsProductsData() async {
    List<ProductModel> fruitsAnotherList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FruitsProducts").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        fruitsAnotherList.add(productModel);
      },
    );
    fruitsProductsList = fruitsAnotherList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProdcutDataList {
    return herbsProductList;
  }

  List<ProductModel> get getFruitsProductsDataList {
    return fruitsProductsList;
  }

  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}
