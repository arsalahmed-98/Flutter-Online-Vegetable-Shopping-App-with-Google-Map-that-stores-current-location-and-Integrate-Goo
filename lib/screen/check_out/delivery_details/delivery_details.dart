import 'package:allinonestore/models/delivery_address_model.dart';
import 'package:allinonestore/provider/check_out_provider.dart';
import 'package:allinonestore/screen/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:allinonestore/screen/check_out/delivery_details/single_delivery_item.dart';
import 'package:allinonestore/screen/check_out/payment_summary/payment_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd6b738),
        title: Text(
          "Delivery Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffd6b738),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddDeliveryAddress()),
          );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressBack.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => AddDeliveryAddress()),
                  )
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentSummary(
                          deliveryAddressList: value,
                        )));
          },
          child: deliveryAddressProvider.getDeliveryAddressBack.isEmpty
              ? Text("Add a new Address")
              : Text("Payment Summary"),
          color: Color(0xffd6b738),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver to: "),
            leading: Image.asset(
              "assets/location1.png",
              height: 40,
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          deliveryAddressProvider.getDeliveryAddressBack.isEmpty
              ? Container(
                  child: Center(
                    child: Text("No Data"),
                  ),
                )
              : Column(
                  children: deliveryAddressProvider.getDeliveryAddressBack
                      .map((data) {
                  setState(() {
                    value = data;
                  });
                  return SingleDeliveryItem(
                    address:
                        "Area: ${data.area}, Street: ${data.street}, Society: ${data.society}, Pincode: ${data.pinCode}",
                    title: "${data.firstName} ${data.lastName}",
                    addressType: data.addressType == "AddressTypes.Other"
                        ? "Other"
                        : data.addressType == "AddressTypes.Home"
                            ? "Home"
                            : "Work",
                    number: "${data.mobileNumber}",
                  );
                }).toList()
                  // children: [
                  // deliveryAddressProvider.getDeliveryAddressBack.isEmpty
                  //     ? Container(
                  //         child: Center(
                  //           child: Text("No Data"),
                  //         ),
                  //       )
                  // : SingleDeliveryItem(
                  //     address: "area, Sindh, Karachi, Pakistan",
                  //     title: "Syed Arsal Ahmed",
                  //     addressType: "Home",
                  //     number: 923341111111,
                  //   ),
                  // ],
                  ),
        ],
      ),
    );
  }
}
