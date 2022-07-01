import 'package:allinonestore/provider/check_out_provider.dart';
import 'package:allinonestore/screen/check_out/google_map/google_map.dart';
import 'package:allinonestore/widgets/custom_text_fiedl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {
  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 48,
          child: checkOutProvider.isLoading == false
              ? MaterialButton(
                  onPressed: () {
                    checkOutProvider.validator(context, myType);
                  },
                  child: Text("Add Address"),
                  color: Color(0xffd6b738),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd6b738),
        title: Text(
          "Add a new Address",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(
              labText: "First Name",
              controller: checkOutProvider.firstName,
            ),
            CustomTextField(
              labText: "Last Name",
              controller: checkOutProvider.lastName,
            ),
            CustomTextField(
              labText: "Mobile No:",
              controller: checkOutProvider.mobileNumber,
            ),
            CustomTextField(
              labText: "Society",
              controller: checkOutProvider.society,
            ),
            CustomTextField(
              labText: "Street",
              controller: checkOutProvider.street,
            ),
            CustomTextField(
              labText: "Landmark",
              controller: checkOutProvider.landMark,
            ),
            CustomTextField(
              labText: "City",
              controller: checkOutProvider.city,
            ),
            CustomTextField(
              labText: "Area",
              controller: checkOutProvider.area,
            ),
            CustomTextField(
              labText: "Pin Code",
              controller: checkOutProvider.pinCode,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CustomGoogleMap(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  height: 47,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkOutProvider.setLocation == null
                          ? Text(
                              "Set Location: ",
                            )
                          : Text(
                              "Done ",
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Address Type"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.home,
                color: Color(0xffd6b738),
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.work,
                color: Color(0xffd6b738),
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.other_houses,
                color: Color(0xffd6b738),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
