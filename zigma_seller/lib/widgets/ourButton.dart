import 'package:zigma_seller/constants/const.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          foregroundColor: color,
          backgroundColor: color,
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0));
}
