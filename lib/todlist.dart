import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TodoList extends StatelessWidget {
   TodoList({super.key});
 final TextEditingController te=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextFormField(controller: te,
            cursorHeight: 300,decoration: InputDecoration(hintText: 'type here'),
      
          ),TextButton(onPressed: () {
            FirebaseFirestore.instance.collection('todolistColle').add({"title":te.text});

            
          }, child: Text('add')),
          StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('todolistColle').snapshots(),
            builder:(context, snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
                return Expanded(
            child: GridView(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3) ,children:  snapshot.data!.docs.map((document) {
                    return Card(child: Center(child: Text(document['title']),));
                  }).toList(),),
 
            );
                
                //  Expanded(
                //   child: ListView(children: snapshot.data!.docs.map((document) {
                //     return ListTile(title: Text(document['title']),);
                //   }).toList(),),
                // );

              }
              
            }, ),
          
      
        
     ] ),
    ));
  }
}