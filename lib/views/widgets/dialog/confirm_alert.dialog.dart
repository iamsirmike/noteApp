import 'package:flutter/material.dart';
import 'package:kngtakehome/utils/colors.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0XFF252525),
      icon: const Icon(
        Icons.info,
        size: 40,
        color: Color(0XFF606060),
      ),
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: Color(0XFFCFCFCF),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 112,
              height: 39,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                ),
                child: Text(
                  'Discard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 35,
            ),
            SizedBox(
              width: 112,
              height: 39,
              child: TextButton(
                key: const Key('saveButton'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0XFF30BE71),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20),
      )),
    );
  }
}
