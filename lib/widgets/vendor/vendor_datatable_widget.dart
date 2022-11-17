import 'package:admin_panel/services/firebase_services.dart';
import 'package:admin_panel/widgets/vendor/vendor_details_box.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class VendorDataTable extends StatefulWidget {
  const VendorDataTable({Key? key}) : super(key: key);

  @override
  State<VendorDataTable> createState() => _VendorDataTableState();
}

class _VendorDataTableState extends State<VendorDataTable> {
  final FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All Vendors',
    'Active Vendors',
    'Inactive Vendors',
    'Top Picked',
    'Top Rated',
  ];

  bool? topPicked;
  bool? active;

  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        topPicked = true;
      });
    }
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return const C2ChoiceStyle(
                brightness: Brightness.dark,
                color: Colors.black54,
              );
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        const Divider(
          thickness: 4,
        ),
        StreamBuilder(
            stream: _services.vendors
                .where('isTopPicked', isEqualTo: topPicked)
                .where('accVerified', isEqualTo: active)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: DataTable(
                  showBottomBorder: true,
                  dataRowHeight: 60,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('Active/Inactive'),
                    ),
                    DataColumn(
                      label: Text('Top Picked'),
                    ),
                    DataColumn(
                      label: Text('Shop Name'),
                    ),
                    DataColumn(
                      label: Text('Rating'),
                    ),
                    DataColumn(
                      label: Text('Total Sales'),
                    ),
                    DataColumn(
                      label: Text('Mobile No.'),
                    ),
                    DataColumn(
                      label: Text('Email address'),
                    ),
                    DataColumn(
                      label: Padding(
                        padding: EdgeInsets.only(right: 70),
                        child:Text('View Details'),
                    ),
                    ),
                  ],
                  rows: _vendorDetailsRows(snapshot.data, _services),
                ),
              );
            }),
      ],
    );
  }

  List<DataRow> _vendorDetailsRows(snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map<DataRow>((document) {
      return DataRow(cells: [
        DataCell(
          IconButton(
            onPressed: () {
              services.updateVendorStatus(
                  id: document.data()['uid'],
                  status: document.data()['accVerified']);
            },
            icon: document.data()['accVerified']
                ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
                : const Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              services.updateTopPickedVendor(
                  id: document['uid'], status: document['isTopPicked']);
            },
            icon: document['isTopPicked']
                ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
                : const Icon(
              null,
            ),
          ),
        ),
        DataCell(
          Text(document.data()['shopName'].toString()),
        ),
        DataCell(
          Row(
            children: const [
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Text('3.5'),
            ],
          ),
        ),
        const DataCell(Text('20,000')),
        DataCell(Text('+92${document.data()['mobile'].toString()}'),),
        DataCell(Text(document.data()['email'].toString())),
        DataCell(IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            //will popup vendor details screen
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return VendorDetailsBox(document['uid']);
                });
          },
        )),
      ]);
    }).toList();
    return newList;
  }
}
