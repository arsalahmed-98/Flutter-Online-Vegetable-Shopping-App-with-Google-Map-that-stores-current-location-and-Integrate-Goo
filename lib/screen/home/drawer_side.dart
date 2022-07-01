import 'package:allinonestore/provider/user_provider.dart';
import 'package:allinonestore/screen/home_screen.dart';
import 'package:allinonestore/screen/my_profile/my_profile.dart';
import 'package:allinonestore/screen/wish_list/wish_list.dart';

import 'package:flutter/material.dart';

import '../review_cart/review_cart.dart';

class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
  DrawerSide({this.userProvider});
  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({
    IconData iconData,
    String title,
    VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: Color(0xffd6b738),
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 42,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        backgroundImage: NetworkImage(
                          userData.userImage,
                        ),
                        radius: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userData.userName),
                        Text(userData.userEmail),
                      ],
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text("Welcome Guest"),
                    //     SizedBox(
                    //       height: 20,
                    //     ),
                    //     Container(
                    //       height: 30,
                    //       width: 120,
                    //       child: OutlineButton(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(17),
                    //             side: BorderSide(
                    //               width: 2,
                    //             )),
                    //         onPressed: () {},
                    //         child: Text("Login"),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            listTile(
                iconData: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            listTile(
                iconData: Icons.shop_outlined,
                title: "Review Cart",
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReviewCart()));
                }),
            listTile(
                iconData: Icons.person_outline,
                title: "My Profile",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MyProfile(userProvider: widget.userProvider)));
                }),
            listTile(
                iconData: Icons.notifications_outlined,
                title: "Notifications",
                onTap: () {}),
            listTile(
                iconData: Icons.star_outline,
                title: "Rating & Reviews",
                onTap: () {}),
            listTile(
                iconData: Icons.favorite_outline,
                title: "Whishlist",
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WishList()));
                }),
            listTile(
                iconData: Icons.copy_outlined,
                title: "Raise a Complaint",
                onTap: () {}),
            listTile(
                iconData: Icons.question_answer_outlined,
                title: "FAQS",
                onTap: () {}),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Container(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Support",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Call us "),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "+92334111111",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("Email:"),
                        Padding(
                          padding: const EdgeInsets.only(left: 37),
                          child: Text(
                            "abcd@gmail.com",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120, top: 60),
                      child: Text(
                        "V10.0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
