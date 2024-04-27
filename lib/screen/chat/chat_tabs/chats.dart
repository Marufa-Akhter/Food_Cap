import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../const_config/color_config.dart';
import '../../../services/chat_services.dart';
import '../../../widgets/input_widget/simple_input_field.dart';
import '../../../widgets/input_widget/chat_bubble.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firebase.collection('chat').orderBy('time', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  return data.isNotEmpty
                      ? ListView.builder(
                    itemCount: data.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: data[index]['message'],
                        isOwner: data[index]['uuid'].toString().compareTo(_auth.currentUser!.uid.toString()) == 0,
                      );
                    },
                  )
                      : const Center(child: Text("No Chats to show"));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: SimpleInputField(
                    controller: _messageController,
                    hintText: "Aa..",
                    needValidation: true,
                    errorMessage: "Message box can't be empty",
                    fieldTitle: "",
                    needTitle: false,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      ChatService().sendChatMessage(message: _messageController.text);
                      _messageController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
