import 'package:ezytransact/constants.dart';
import 'package:ezytransact/size_config.dart';
import 'package:flutter/material.dart';

class TransactionViewItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const TransactionViewItemWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: kDarkAccentColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              icon,
              color: kDarkAccentColor,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: TextStyle(
                color: kDarkSecondaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Divider(
          color: kPrimaryColor,
          thickness: SizeConfig.blockSizeVertical*0.2,
        ),
      ],
    );
  }
}
