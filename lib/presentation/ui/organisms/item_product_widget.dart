import 'package:eye_ia_detection/core/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    required this.imageUrl,
    required this.name,
    this.ontap,
    this.isMinimunVersion = false,
  });

  final String? imageUrl;
  final String name;
  final Function? ontap;
  final bool isMinimunVersion;

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black26,
            )
          ]),
      width: (sizeScreen.width / 2) / (isMinimunVersion ? 1.5 : 1),
      height: (sizeScreen.width / 1.9) / (isMinimunVersion ? 1.5 : 1),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      ontap?.call();
                    },
                    child: Ink(
                      // color: Colors.red,
                      width: sizeScreen.width / 2,
                      height: sizeScreen.width / 2,
                      child: Image.network(
                        imageUrl ??
                            'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://edteam-media.s3.amazonaws.com/blogs/big/2ab53939-9b50-47dd-b56e-38d4ba3cc0f0.png',
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: CustomColors.primaryAccent,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'COD-312',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: (isMinimunVersion ? 8 : 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (isMinimunVersion ? 10 : 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
