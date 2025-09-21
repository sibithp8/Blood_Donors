import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
  void deleteDonor(docId){
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:Colors.red ,
        title: Text("Blood Donors",
          style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold),)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
      backgroundColor: Colors.white,
        child: Icon(
              Icons.add,
              size: 40,
              color: Colors.red,),),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/blood.jpg'),
            opacity: 0.5,),
        ),child: StreamBuilder(
          stream: donor.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemBuilder: (context, index){
                  final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Color.fromARGB(255,194,193,193),
                          blurRadius: 10,
                          spreadRadius: 15,)
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Text(donorSnap['blood group'],
                                style: TextStyle(fontSize: 25,
                                    color: Colors.white),),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(donorSnap['name'],style: TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold
                              ),),
                              Text(donorSnap['mobile number'].toString(),style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold
                    ),),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pushNamed(context, '/update',
                                arguments: {
                                  'name':donorSnap['name'],
                                  'mobile number': donorSnap['mobile number'].toString(),
                                  'blood group': donorSnap['blood group'],
                                  'id': donorSnap.id,
                                });
                              },
                                icon: Icon(Icons.edit),
                              iconSize: 30,
                              color: Colors.blueAccent,),
                              IconButton(onPressed: (){
                                deleteDonor(donorSnap.id);
                              },
                                icon: Icon(Icons.delete),
                                iconSize: 30,
                                  color: Colors.red,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              itemCount: snapshot.data.docs.length,);
            }return Container();
          }),
      ),
    );
  }
}
