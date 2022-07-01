import 'package:flutter/material.dart';

class singlefruitProdcuts extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;

  singlefruitProdcuts({
    this.productName,
    this.productImage,
    this.productPrice,
  });

  @override
  State<singlefruitProdcuts> createState() => _singlefruitProdcutsState();
}

class _singlefruitProdcutsState extends State<singlefruitProdcuts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 230,
      width: 160,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 248, 247, 247),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image.network(widget.productImage),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${widget.productPrice}/250 Gram",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 1),
                          height: 30,
                          width: 50,
                          // color: Colors.black,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "50 Gram",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )),
                              Center(
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          width: 50,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 2,
                              ),
                              Icon(Icons.remove,
                                  size: 20, color: Colors.yellow),
                              SizedBox(
                                width: 5,
                              ),
                              Text("1"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
