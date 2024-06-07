import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task00/screens/home.dart';
class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SIGN UP",style: TextStyle(fontSize: 40),),
            SizedBox(height: 30,),
            SizedBox(
              width: 340,
              child: TextFormField(
                controller: _email,
                decoration:InputDecoration(
                  border: OutlineInputBorder(),
                hintText: "Enter ur email..."
              ),),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 340,
              child: TextFormField(
                controller: _pass,
                decoration:InputDecoration(
                  border: OutlineInputBorder(),
                hintText: "Enter ur pass..."
              ),),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              create(_email.text, _pass.text);
              _email.clear();
              _pass.clear();
            }, child: Text("submit")),
          ],
        ),
      ),
    );
  }
  void create(String email,String pass)async{

    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      await addUserdetails(email);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    }
    on FirebaseAuthException catch(e){
      if(e.code == "weak-password"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }}
      catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
  }
Future<void> addUserdetails(String email) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    print("No user is currently signed in.");
    return;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String _email = currentUser.email!;
  Map<String, dynamic> userdata = {
    "email": _email,
    "uid": currentUser.uid
  };
  users.add(userdata)
      .then((value) => print("User added"))
      .catchError((error) => {print("Failed to add the user data: $error")});
}

}