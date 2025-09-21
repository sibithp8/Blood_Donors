import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String? selectedGroup;
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorMobile = TextEditingController();
  void updateDonor(docId){
    final data = {
      'name': donorName.text,
      'mobile number' : donorMobile.text,
      'blood group' : selectedGroup,
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorMobile.text = args['mobile number'];
    selectedGroup = args['blood group'];
    final docId = args['id'];


    return Scaffold(
      appBar: AppBar(
          backgroundColor:Colors.red ,
          title: Text("Update Donors",
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Donor Name'),
              ),
            ),SizedBox(height: 20,),
            TextField(
              controller: donorMobile,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Mobile Number'),
              ),
            ),SizedBox(height: 20,),
            DropdownButtonFormField(
              value: selectedGroup,
                decoration: InputDecoration(
                  label: Text('Select Blood Group'),
                ),
                items: bloodGroups.map((e) =>DropdownMenuItem(
                    child: Text(e),value: e)).toList(), onChanged: (val){
              selectedGroup = val;
            }),SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                updateDonor(docId);
              },
              child: Text('Update',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25),),
              style:ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 50),),
                  backgroundColor: MaterialStateProperty.all(Colors.red)
              ) ,),
          ],
        ),
      ),
    );
  }
}
