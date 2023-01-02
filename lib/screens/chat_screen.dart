import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        Text('Sair'),
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('chat').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.documents;
          return ListView.builder(
            itemBuilder: ((context, index) => Container(
                  padding: EdgeInsets.all(8),
                  child: Text(documents[index]['text']),
                )),
            itemCount: documents.length,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance.collection('chat').add({
            'text': 'Adicionado manualmente',
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
