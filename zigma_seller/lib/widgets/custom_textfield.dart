import 'package:zigma_seller/constants/const.dart';

Widget customTextFeild(
    {label, hint, controller, isDesc = false, securePass = false}) {
  return TextFormField(
    style: const TextStyle(color: whiteColor),
    controller: controller,
    obscureText: securePass,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: whiteColor),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey)),
  );
}
