import 'package:allinonestore/models/delivery_address_model.dart';
import 'package:allinonestore/provider/check_out_provider.dart';
import 'package:allinonestore/provider/product_provider.dart';
import 'package:allinonestore/provider/review_cart_provider.dart';
import 'package:allinonestore/screen/check_out/delivery_details/single_delivery_item.dart';
import 'package:allinonestore/screen/check_out/payment_summary/my_google_pay.dart';
import 'package:allinonestore/screen/check_out/payment_summary/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliveryAddressList;

  PaymentSummary({this.deliveryAddressList});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum AddressTypes {
  CashOnDelivery,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.CashOnDelivery;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double totalPrice = reviewCartProvider.getTotalPrice();
    double discount = 30;
    double shippingCharges = 3.7;
    double discountValue;
    double total;

    if (totalPrice > 150) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Summary",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd6b738),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                      "Area: ${widget.deliveryAddressList.area}, Street: ${widget.deliveryAddressList.street}, Society: ${widget.deliveryAddressList.society}, Pincode: ${widget.deliveryAddressList.pinCode}",
                  title:
                      "${widget.deliveryAddressList.firstName} ${widget.deliveryAddressList.lastName}",
                  addressType: widget.deliveryAddressList.addressType ==
                          "AddressTypes.Other"
                      ? "Other"
                      : widget.deliveryAddressList.addressType ==
                              "AddressTypes.Home"
                          ? "Home"
                          : "Work",
                  number: "${widget.deliveryAddressList.mobileNumber}",
                ),
                Divider(
                  color: Colors.black,
                ),
                ExpansionTile(
                    title: Text(
                      "Cart Items: ${reviewCartProvider.getReviewCartDataList.length} ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children:
                        reviewCartProvider.getReviewCartDataList.map((data) {
                      return OrderItem(
                        data: data,
                      );
                    }).toList()),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "\$${totalPrice + 5}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charges:",
                  ),
                  trailing: Text(
                    "\$5",
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Coupon Discout:",
                  ),
                  trailing: Text(
                    "\$$discountValue",
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Text(
                    "Payment Options: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RadioListTile(
                    value: AddressTypes.CashOnDelivery,
                    groupValue: myType,
                    title: Text("Cash On Delivery"),
                    onChanged: (AddressTypes value) {
                      setState(() {
                        myType = value;
                      });
                    },
                    secondary: Image.asset('assets/1554401.png')),
                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("Online Payment"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Image.asset('assets/images.png'),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text(
          "Total Amount: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "\$${total ?? totalPrice + 5}",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: Container(
          width: 160,
          height: 44,
          child: MaterialButton(
            onPressed: () {
              myType == AddressTypes.OnlinePayment
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyGooglePay(
                            total: total,
                          )))
                  : Container();
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            color: Color(0xffd6b738),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        leading: Icon(Icons.shopping_bag_sharp),
      ),
    );
  }
}
