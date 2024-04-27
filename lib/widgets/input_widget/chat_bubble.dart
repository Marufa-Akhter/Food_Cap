import 'package:final_project/const_config/color_config.dart';
import 'package:flutter/material.dart';
import 'package:final_project/const_config/text_config.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isOwner;
  final String? userName; // Add user name field

  const ChatBubble({
    required this.message,
    required this.isOwner,
    this.userName, // Initialize user name field
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isOwner ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          right: isOwner ? 0 : 25,
          left: isOwner ? 25 : 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isOwner)
              CircleAvatar(
                child: Text(userName![0]), // Display first character of user name as avatar
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isOwner ? MyColor.white : MyColor.primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  message,
                  style: TextDesign().bodyTextExtraSmall.copyWith(
                    color: isOwner ? MyColor.black : MyColor.white,
                    // Add other style properties here as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
