import 'package:admin_panel/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/constants.dart';

class VendorDetailsBox extends StatefulWidget {
  final String? uid;

  const VendorDetailsBox(this.uid);

  @override
  _VendorDetailsBoxState createState() => _VendorDetailsBoxState();
}

class _VendorDetailsBoxState extends State<VendorDetailsBox> {
  final FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _services.vendors.doc(widget.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child:  Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .3,
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  snapshot.data!['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data?['shopName'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(snapshot.data?['dialog']),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 4,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Contact Number',
                                        style: kVendorDetailsTextStyle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        child: Text('+92${snapshot.data?['mobile']}'),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Email',
                                        style: kVendorDetailsTextStyle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10),
                                      child:  Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(snapshot.data?['email']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'address',
                                        style: kVendorDetailsTextStyle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(snapshot.data?['address']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Top Pick Status',
                                        style: kVendorDetailsTextStyle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10),
                                      child:  Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: snapshot.data?['isTopPicked']
                                          ? Chip(
                                        backgroundColor: Colors.green,
                                        label: Row(
                                          children: const [
                                            Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Top Picked',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                          : Container(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child:  Divider(
                                thickness: 2,
                              ),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              CupertinoIcons
                                                  .money_dollar_circle,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Total Revenue'),
                                            Text('12,000'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.shopping_cart,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Active Orders'),
                                            Text('6'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons
                                                  .shopping_bag,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Total Orders'),
                                            Text('130'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons
                                                  .grain_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Products'),
                                            Text('160 Products'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons
                                                  .list_alt_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Statement'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: snapshot.data?['accVerified']
                        ? Chip(
                      backgroundColor: Colors.green,
                      label: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Active',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                        : Chip(
                      backgroundColor: Colors.red,
                      label: Row(
                        children: const [
                          Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Inactive',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}