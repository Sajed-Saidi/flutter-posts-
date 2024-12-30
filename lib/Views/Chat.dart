import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/Widgets/MyBottomNavigationBar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [
    {"sender": "User", "message": "Hello!"},
    {"sender": "You", "message": "Hi there! How are you?"},
    {"sender": "User", "message": "I'm good, thanks! What about you?"},
    {"sender": "User", "message": "Hello!"},
    {"sender": "You", "message": "Hi there! How are you?"},
    {"sender": "User", "message": "I'm good, thanks! What about you?"},
    {"sender": "User", "message": "Hello!"},
    {"sender": "You", "message": "Hi there! How are you?"},
    {"sender": "User", "message": "I'm good, thanks! What about you?"},
    {"sender": "User", "message": "Hello!"},
    {
      "sender": "You",
      "message":
          "Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?Hi there! How are you?"
    },
    {"sender": "User", "message": "I'm good, thanks! What about you?"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
              size: 18,
            ),
          ),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.black38,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // "Online" badge
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset("images/avatar-04.png"),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Sajed Saidi",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, // Badge color
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Online',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          // Three dots icon on the right side
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle three dots icon press
            },
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // To display the newest messages at the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isSender = messages[index]["sender"] == "You";
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Align(
                    alignment:
                        isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isSender
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        messages[index]["message"]!,
                        style: TextStyle(
                          color: isSender ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      setState(() {
                        messages.insert(0, {
                          "sender": "You",
                          "message": _messageController.text
                        });
                        _messageController.clear();
                      });
                    }
                  },
                  icon: Center(
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
