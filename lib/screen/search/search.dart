import 'package:allinonestore/models/product_model.dart';
import 'package:allinonestore/widgets/single_item.dart';

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final List<ProductModel> search;
  Search({this.search});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd6b738),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.sort),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Items:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                fillColor: Color.fromARGB(255, 221, 218, 218),
                filled: true,
                hintText: "Search for the item in the store",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem.map((data) {
              return SingleItem(
                isBool: false,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                productQuantity: 1,
                productUnit: data.productUnit,
                onDelete: () {},
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
