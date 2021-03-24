import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading...'),);
          }

          final docs = snapshot.data.docs;
          final user = FirebaseAuth.instance.currentUser;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                docs[index]['text'],
                docs[index]['userName'],
                docs[index]['userImage'],
                docs[index]['userId'] == user.uid,
                // key: ValueKey(docs[index].documentID),
              );
            },
            itemCount: docs.length,
          );
        });
  }
}
