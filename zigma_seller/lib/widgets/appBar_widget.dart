import 'package:zigma_seller/constants/const.dart';
import 'package:intl/intl.dart' as intl;

AppBar appBarWidget(title) {
  return AppBar(
    backgroundColor: whiteColor,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: darkFontGrey, size: 16.0),
    actions: [
      Center(
          child: boldText(
              text:
                  intl.DateFormat('EEE , MMM d ,' 'yy').format(DateTime.now()),
              color: purpleColor)),
      10.widthBox
    ],
  );
}
