import 'package:flutter/material.dart';
import 'package:mobox/core/model/user_profiel.dart';

class ProfileInfoTable extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileInfoTable({Key? key, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text('Address:'),
            ),
            TableCell(
              child: Text(' ${userProfile.address.toString()}'),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('phone:'),
            ),
            TableCell(
              child: Text('${userProfile.phone}'),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('Frozen assets:'),
            ),
            TableCell(
              child: Text('${userProfile.userStore!.frozenAssets}'),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('Over all profit:'),
            ),
            TableCell(
              child: Text('${userProfile.userStore!.overAllProfit}'),
            ),
          ],
        ),
      ],
    );
  }
}
