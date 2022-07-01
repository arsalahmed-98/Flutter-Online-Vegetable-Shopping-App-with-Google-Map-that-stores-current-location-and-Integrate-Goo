import 'package:allinonestore/provider/product_provider.dart';
import 'package:allinonestore/provider/user_provider.dart';
import 'package:allinonestore/screen/review_cart/review_cart.dart';
import 'package:allinonestore/screen/search/search.dart';
import 'package:allinonestore/screen/search/singal_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/drawer_side.dart';
import 'home/product_overview/prodcut_overview.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget drawerElements({IconData icon, String title}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context, listen: false);
    initproductProvider.fetchHerbsProdcutData();
    initproductProvider.fetchFruitsProductsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd6b738),
        title: Text(
          "Allinonestore",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xffd6d382),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Search(search: productProvider.gerAllProductSearch),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xffd6d382),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReviewCart()));
                },
                icon: Icon(
                  Icons.shopping_bag,
                ),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image1.jpg"),
                    )),
                // color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          // color: Colors.pink,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 120.0),
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  // color: Colors.pink,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd6b738),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Vegi",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.yellow,
                                              blurRadius: 10,
                                              offset: Offset(2, 2),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Text(
                                  "30% OFF",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                          blurRadius: 12,
                                          offset: Offset(5, 5),
                                          color: Color(0xffd6b738),
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                "On All Vegetables",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                        shadows: [
                                      BoxShadow(
                                        blurRadius: 12,
                                        offset: Offset(5, 5),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        child: Container(
                            // color: Colors.black,
                            )),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Herbs Seasoning",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Search(
                                  search:
                                      productProvider.getHerbsProdcutDataList,
                                )));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productProvider.getHerbsProdcutDataList.map(
                    (herbsProdcutData) {
                      return GestureDetector(
                        child: SingalProduct(
                          productImage: herbsProdcutData.productImage,
                          productName: herbsProdcutData.productName,
                          productPrice: herbsProdcutData.productPrice,
                          productId: herbsProdcutData.productId,
                          productUnit: herbsProdcutData,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductOverView(
                                    productImage: herbsProdcutData.productImage,
                                    productName: herbsProdcutData.productName,
                                    productPrice: herbsProdcutData.productPrice,
                                    productId: herbsProdcutData.productId,
                                  )));
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fresh Fruits",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Search(
                                  search:
                                      productProvider.getFruitsProductsDataList,
                                )));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productProvider.getFruitsProductsDataList.map(
                    (fruitsProductsData) {
                      return GestureDetector(
                        child: SingalProduct(
                          productImage: fruitsProductsData.productImage,
                          productName: fruitsProductsData.productName,
                          productPrice: fruitsProductsData.productPrice,
                          productId: fruitsProductsData.productId,
                          productUnit: fruitsProductsData,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductOverView(
                                    productImage:
                                        fruitsProductsData.productImage,
                                    productName: fruitsProductsData.productName,
                                    productPrice:
                                        fruitsProductsData.productPrice,
                                    productId: fruitsProductsData.productId,
                                  )));
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
    );
  }
}
