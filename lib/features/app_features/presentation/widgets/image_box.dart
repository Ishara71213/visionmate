import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';

class ImageBox extends StatelessWidget {
  final PostEntity post;
  const ImageBox({
    super.key,
    required this.post,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size.width - 48) / 2,
      height: (size.width - 48) / 2,
      decoration: BoxDecoration(
          color: kGuideBoxBgColor, borderRadius: BorderRadius.circular(14)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: (size.width - 48) / 2,
                height: ((size.width - 48) / 2),
                imageUrl: post.imageUrl!,
                placeholder: (context, url) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 60,
                          color: kGuideBoxIconColor,
                        ),
                      ],
                    ),
                errorWidget: (context, url, error) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 60,
                          color: kGuideBoxIconColor,
                        ),
                      ],
                    )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 46),
                decoration: BoxDecoration(
                    color: kGuideBoxBgColor.withOpacity(0.94),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14))),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        (post.title?.characters?.length ?? 0) > 41
                            ? "${post.title?.characters.take(41).toString()}..." ??
                                ""
                            : post.title?.characters.take(41).toString() ?? "",
                        style: kImageBoxTitle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
