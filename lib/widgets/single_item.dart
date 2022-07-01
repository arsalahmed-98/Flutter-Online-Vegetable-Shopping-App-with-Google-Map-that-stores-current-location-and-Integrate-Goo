import 'package:allinonestore/provider/review_cart_provider.dart';
import 'package:allinonestore/widgets/counts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  String productId;
  int productPrice;
  int productQuantity;
  VoidCallback onDelete;
  var productUnit;

  SingleItem({
    this.onDelete,
    this.productUnit,
    this.isBool,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productQuantity,
    this.productId,
    // required this.productQuantity
  });

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  ReviewCartProvider reviewCartProvider;

  // @override
  // void initState() {
  //   getCount();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                child: Center(
                  child: Image.network(widget.productImage),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: widget.isBool == false
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.productPrice}\$",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    widget.isBool == false
                        ? Container(
                            margin: EdgeInsets.only(right: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "50 Gram",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                                Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 25,
                                    color: Color(0xffd6b738),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text("Item Weight: " + widget.productUnit),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Item Quantity:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: Text(
                              "${widget.productQuantity}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                padding: widget.isBool == false
                    ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                    : EdgeInsets.only(left: 15, right: 15),
                child: widget.isBool == false
                    ? Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(0xffd6b738),
                                size: 20,
                              ),
                              Text(
                                "Add",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: widget.onDelete,
                            child: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (count == 1) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You have received minimum limit");
                                      } else {
                                        setState(() {
                                          count--;
                                        });
                                        reviewCartProvider.updateCartData(
                                          cartImage: widget.productImage,
                                          cartName: widget.productName,
                                          cartId: widget.productId,
                                          cartPrice: widget.productPrice,
                                          cartQuantity: count,
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Color(0xffd6b738),
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    "$count",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (count > 1) {
                                        setState(() {
                                          count++;
                                        });
                                        reviewCartProvider.updateCartData(
                                          cartImage: widget.productImage,
                                          cartName: widget.productName,
                                          cartId: widget.productId,
                                          cartPrice: widget.productPrice,
                                          cartQuantity: count,
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xffd6b738),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      widget.isBool == false
          ? Container()
          : Divider(
              height: 3,
              color: Colors.black45,
            ),
    ]);
  }
}
