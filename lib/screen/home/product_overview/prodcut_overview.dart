import 'package:allinonestore/provider/wishlist_products_provider.dart';
import 'package:allinonestore/widgets/counts.dart';
// import 'package:allinonestore/widgets/counts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../review_cart/review_cart.dart';

// enum SinginCharacter { fill, outline }

class ProductOverView extends StatefulWidget {
  final String productName;
  final String productId;
  final String productImage;
  final int productPrice;
  // final int productQuantity;

  ProductOverView({
    this.productName,
    this.productImage,
    this.productPrice,
    this.productId,
    // required this.productQuantity,
  });

  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  // SinginCharacter _character = SinginCharacter.fill;

  // Widget bottomNavigationBar(
  //     {required Color iconColor,
  //     required Color backgroundColor,
  //     required Color color,
  //     required String title,
  //     required IconData iconData}) {
  //   return Expanded(
  //       child: GestureDetector(
  //     onTap: () {
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => ReviewCart()));
  //     },
  //     child: Container(
  //       padding: EdgeInsets.all(18),
  //       color: backgroundColor,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             iconData,
  //             size: 17,
  //             color: iconColor,
  //           ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  // Text(
  //   title,
  //   style: TextStyle(color: color),
  // ),
  //         ],
  //       ),
  //     ),
  //   ));
  // }

  Widget bottomNavigationBar({
    Color iconColor,
    Color backgroundColor,
    Color color,
    String title,
    IconData iconData,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ReviewCart()));
      },
      child: Container(
        height: 70,
        width: 180,
        padding: EdgeInsets.all(18),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 17,
              color: iconColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  // Widget bottomNavigationBar1(
  //     {required Color iconColor,
  //     required Color backgroundColor,
  //     required Color color,
  //     required String title,
  //     required IconData iconData,
  //     required VoidCallback onTap}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Expanded(
  //       child: Container(
  //         padding: EdgeInsets.all(18),
  //         color: backgroundColor,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               iconData,
  //               size: 17,
  //               color: iconColor,
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  // Text(
  //   title,
  //   style: TextStyle(color: color),
  // ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget bottomNavigationBar1({
    Color iconColor,
    Color backgroundColor,
    Color color,
    String title,
    IconData iconData,
    VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 180,
        padding: EdgeInsets.all(18),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 17,
              color: iconColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishListProducts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishListProducts")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("wishList");
                        },
                      ),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bottomNavigationBar1(
              iconColor: Colors.red,
              backgroundColor: Colors.black,
              color: Colors.white,
              title: "Add to WhishList",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListProductData(
                    wishListProductId: widget.productId,
                    wishListProductName: widget.productName,
                    wishListProductImage: widget.productImage,
                    wishListProductPrice: widget.productPrice,
                  );
                } else {
                  wishListProvider.wishListDataDelete(widget.productId);
                }
              }),
          bottomNavigationBar(
            iconColor: Colors.red,
            backgroundColor: Color(0xffd1ad17),
            color: Colors.white,
            title: "Go To Cart",
            iconData: Icons.shop_outlined,
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffd6b738),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Product OverView",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListTile(
              title: Text(widget.productName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 14),
            child: Text(
              "\$${widget.productPrice}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Container(
                height: 180,
                width: 300,
                child: Image.network(widget.productImage),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 22),
            width: double.infinity,
            child: Text(
              "Available Options:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          // SizedBox(
          //   width: 40,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "\$${widget.productPrice}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  width: 160,
                ),

                Count(
                  productId: widget.productId,
                  productImage: widget.productImage,
                  productName: widget.productName,
                  productPrice: widget.productPrice,
                  productUnit: '500 Gram',
                  // productQuantity: 1,
                ),
                SizedBox(
                  width: 40,
                ),

                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                //   decoration: BoxDecoration(
                //     // color: Colors.green,
                //     border: Border.all(color: Colors.black),
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.add,
                //         size: 20,
                //         color: Color(0xffd6b738),
                //       ),
                //       Text(
                //         "ADDSsS",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, color: Colors.red),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Description:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
