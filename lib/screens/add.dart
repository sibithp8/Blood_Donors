import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodGroups = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String? selectedGroup;
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorMobile = TextEditingController();

void addDonor(){
  final data = {'name': donorName.text, 'mobile number': donorMobile.text, 'blood group': selectedGroup};
  donor.add(data);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:Colors.red ,
          title: Text("Add Donors",
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
              decoration: InputDecoration(
                label: Text('Select Blood Group'),
              ),
              items: bloodGroups.map((e) =>DropdownMenuItem(
                  child: Text(e),value: e)).toList(), onChanged: (val){
                selectedGroup = val;
            }),SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                addDonor();
                Navigator.pop(context);
              },
              child: Text('Submit',
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
