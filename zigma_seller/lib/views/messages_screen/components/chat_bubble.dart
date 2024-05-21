import 'package:zigma_seller/constants/const.dart';

Widget chatBubble() {
  // var t =
  // data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  // var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection: TextDirection.ltr,
    // data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          color: purpleColor,
          // color: data['uid'] == currentUser!.uid ? fontGrey : violet,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          normalText(text: "Your message here"),
          // "${data['msg']}".text.size(16).white.make(),
          10.heightBox,
          // time.text.color(whiteColor.withOpacity(0.5)).make(),
          normalText(text: "10:45 pm")
        ],
      ),
    ),
  );
}
