import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BannerCard extends StatelessWidget {
  final String title;
  final Widget content;
  final bool? isAddRecord;
  final VoidCallback? onTap;

  const BannerCard(
      {Key? key,
      required this.title,
      required this.content,
      this.isAddRecord,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.7),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8.0),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                isAddRecord == true
                    ? InkWell(
                        onTap: onTap ?? () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 8,
                              child: Icon(
                                Icons.add,
                                color: Colors.black.withOpacity(.7),
                                size: 16,
                              ),
                            ),
                            5.width,
                            Text(
                              'Add record',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ],
      ),
    );
  }
}
