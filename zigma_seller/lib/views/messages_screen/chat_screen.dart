import 'package:zigma_seller/constants/const.dart';

import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // check video 23 - 16:28

        title: boldText(text: chats, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      return chatBubble();
                    }))),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Enter your message",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor))),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: purpleColor,
                      ))
                ],
              ).box.white.shadowSm.make(),
            )
          ],
        ),
      ),
    );
  }
}
