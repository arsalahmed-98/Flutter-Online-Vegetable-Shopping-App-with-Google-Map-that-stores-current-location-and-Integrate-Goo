import 'package:allinonestore/models/delivery_address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  LocationData setLocation;

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstName Can't be Empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastName can't be Empty");
    } else if (mobileNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNumber can't be Empty");
    } else if (society.text.isEmpty) {
      Fluttertoast.showToast(msg: "society can't be Empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street can't be Empty");
    } else if (landMark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landMark can't be Empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city can't be Empty");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "area can't be Empty");
    } else if (pinCode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pinCode can't be Empty");
    } else if (setLocation == null) {
      Fluttertoast.showToast(msg: "Location can't be Empty");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliveryAddress")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "firstName": firstName.text,
        "lastName": lastName.text,
        "mobileNumber": mobileNumber.text,
        "society": society.text,
        "street": street.text,
        "landMark": landMark.text,
        "city": city.text,
        "area": area.text,
        "pinCode": pinCode.text,
        "addressType": myType.toString(),
        "longitude": setLocation.longitude,
        "latitude": setLocation.latitude,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(
            msg: "Delivery Details added Successfully! ");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];

  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliveryAddress")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    if (_db.exists) {
      DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstName"),
        lastName: _db.get("lastName"),
        mobileNumber: _db.get("mobileNumber"),
        society: _db.get("society"),
        street: _db.get("street"),
        landMark: _db.get("landMark"),
        city: _db.get("city"),
        area: _db.get("area"),
        pinCode: _db.get("pinCode"),
        addressType: _db.get("addressType"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }
    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressBack {
    return deliveryAddressList;
  }
}
