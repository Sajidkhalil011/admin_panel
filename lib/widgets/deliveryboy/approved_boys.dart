import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../services/firebase_services.dart';

class ApprovedBoys extends StatefulWidget {
  const ApprovedBoys({Key? key}) : super(key: key);
  @override
  _ApprovedBoysState createState() => _ApprovedBoysState();
}
class _ApprovedBoysState extends State<ApprovedBoys> {
  bool status = false;
  final FirebaseServices _services  = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _services.boys.where('accVerified',isEqualTo: true).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          try{
            if(snapshot.hasError){
              return Text('Something went wrong..');
            }
          }catch(e,s){
            print('Error is: $e');
            print('Stack Trace is: $s');
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          QuerySnapshot<Object?>? snap = snapshot.data;
          if(snap!.size==0){
            return Center(child: Text('No Approved boys to list'),);
          }
          return SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              dataRowHeight: 60,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columns: <DataColumn>[
                DataColumn(label: Expanded(child: Text('Profile Pic')),),
                DataColumn(label: Text('Name'),),
                DataColumn(label: Text('email'),),
                DataColumn(label: Text('Mobile'),),
                DataColumn(label: Text('Address'),),
                DataColumn(label: Text('Action'),),
                //DataColumn(label: Text('Actions'),),
              ],
              rows: _boysList(snapshot.data,context),
            ),
          ) ;
        },
      ),
    );
  }

  List<DataRow>_boysList(snapshot,context){

    List<DataRow> newList = snapshot.docs.map<DataRow>((DocumentSnapshot document){

      if(document!=null){
        return DataRow(
            cells: [
              DataCell(
                  Container(
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(document['imageUrl'],fit: BoxFit.contain,),
                    ),)
              ),
              DataCell(
                  Text(document['name'])
              ),
              DataCell(
                  Text(document['email'])
              ),
              DataCell(
                  Text(document['mobile'])
              ),
              DataCell(
                  Text(document['address'])
              ),
              DataCell(
                FlutterSwitch(
                  activeText: "Approved",
                  inactiveText: "Not Approved",
                  value: document['accVerified'],
                  valueFontSize: 10.0,
                  width: 110,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (val) {
                    _services.updateBoyStatus(document.id,context,false);
                  },
                ),
              )
            ]
        );
      }
    }).toList();
    return newList;
  }
}