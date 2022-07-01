import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  ProductUnit({this.onTap, this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              '$title',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
    );
  }
}
