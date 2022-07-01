import 'package:flutter/material.dart';

class WishListSingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  String productId;
  int productPrice;
  VoidCallback onDelete;

  WishListSingleItem({
    this.onDelete,
    this.isBool,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productId,
    // required this.productQuantity
  });

  @override
  State<WishListSingleItem> createState() => _WishListSingleItemState();
}

class _WishListSingleItemState extends State<WishListSingleItem> {
  @override
  Widget build(BuildContext context) {
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
                        : Text("50 Gram")
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
                          border: Border.all(color: Colors.grey),
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
                    : Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: widget.onDelete,
                              child: Icon(
                                Icons.delete,
                                size: 33,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Container(
                            //   height: 25,
                            //   width: 70,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.grey),
                            //     borderRadius: BorderRadius.circular(30),
                            //   ),
                            //   child: Center(
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(
                            //           Icons.add,
                            //           color: Color(0xffd6b738),
                            //           size: 20,
                            //         ),
                            //         Text(
                            //           "Add",
                            //           style: TextStyle(color: Colors.black),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      widget.isBool == false
          ? Container()
          : Divider(
              height: 1,
              color: Colors.black45,
            ),
    ]);
  }
}
