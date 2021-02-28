import 'package:flutter/material.dart';

class StatDashboardWidget extends StatelessWidget {
  final String statDesc;
  final String statTitle;
  final Function onTap;

  const StatDashboardWidget({
    Key key,
    this.statDesc,
    this.statTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Theme(
        isMaterialAppTheme: true,
        data: Theme.of(context).copyWith(
          textTheme:
              Theme.of(context).textTheme.merge(Typography.whiteCupertino),
        ),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Text(
                  statDesc,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  statTitle,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
