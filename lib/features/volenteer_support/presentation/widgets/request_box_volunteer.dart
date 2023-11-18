import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';
import 'package:visionmate/features/volenteer_support/presentation/bloc/voluntee_support_cubit/volunteer_support_cubit.dart';

class RequestBoxVolunteer extends StatelessWidget {
  final VolunteerRequestEntity request;
  const RequestBoxVolunteer({
    super.key,
    required this.request,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: (size.width - 48) / 2,
      height: 70,
      decoration: BoxDecoration(
          color: kGuideBoxBgColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    imageUrl: request?.createdUserImageUrl ?? "",
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
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          (request.title?.characters?.length ?? 0) > 41
                              ? "${request.title?.characters.take(41).toString()}..." ??
                                  ""
                              : request.title?.characters.take(41).toString() ??
                                  "",
                          style: kRequestBoxTitle,
                          textAlign: TextAlign.left,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          (request.title?.characters?.length ?? 0) > 41
                              ? "${request.title?.characters.take(41).toString()}..." ??
                                  ""
                              : request.title?.characters.take(41).toString() ??
                                  "",
                          style: kRequstBoxSubTitle,
                          textAlign: TextAlign.left,
                        )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                  child: FilledButton(
                onPressed: request.acceptedUserUserId == null
                    ? () async {
                        await BlocProvider.of<VolunteerSupportCubit>(context)
                            .acceptRequest(request, context);
                      }
                    : null,
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: kButtonPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        request.acceptedUserUserId == null
                            ? "Accept"
                            : "Message",
                        style: kFilledButtonTextstyle)
                  ],
                ),
              )),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                  child: FilledButton(
                onPressed: () async {
                  if (request.requestId != null) {
                    // await BlocProvider.of<VolunteerSupportCubit>(context)
                    //     .deleteRequest(request.requestId!);
                  }
                },
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: KDarkbluGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Reject", style: kFilledButtonTextstyle)],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
