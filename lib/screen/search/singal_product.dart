import 'package:allinonestore/models/product_model.dart';
import 'package:allinonestore/widgets/products_unit.dart';
import 'package:flutter/material.dart';

import '../../widgets/counts.dart';

// import 'package:allinonestore/models/product_model.dart';

class SingalProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final String productId;
  final ProductModel productUnit;

  SingalProduct({
    this.productImage,
    this.productName,
    this.productPrice,
    this.productId,
    this.productUnit,
  });

  @override
  _SingalProductState createState() => _SingalProductState();
}

class _SingalProductState extends State<SingalProduct> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 210,
        width: 160,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Image.network(
                  widget.productImage,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 21),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${widget.productPrice}/${unitData == null ? firstValue : unitData}",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ProductUnit(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: widget.productUnit.productUnit
                                            .map<Widget>((data) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      unitData = data;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    data,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xffd6b738),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    });
                              },
                              title: unitData == null ? firstValue : unitData,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Count(
                            productId: widget.productId,
                            productImage: widget.productImage,
                            productName: widget.productName,
                            productPrice: widget.productPrice,
                            productUnit:
                                unitData == null ? firstValue : unitData,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
