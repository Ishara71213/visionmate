import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/connect_smart_cane/presentation/bloc/cubit/connect_cane_cubit.dart';

class BleDeviceContainer extends StatefulWidget {
  final int index;
  final ScanResult scanResult;
  const BleDeviceContainer(
      {super.key, required this.index, required this.scanResult});

  @override
  State<BleDeviceContainer> createState() => _BleDeviceContainerState();
}

class _BleDeviceContainerState extends State<BleDeviceContainer> {
  @override
  Widget build(BuildContext context) {
    ConnectCaneCubit connectCane = BlocProvider.of<ConnectCaneCubit>(context);
    return Container(
        constraints:
            const BoxConstraints(minHeight: 100, minWidth: double.infinity),
        decoration: BoxDecoration(
          color: kGuideBoxBgColor.withOpacity(0.90),
          borderRadius: BorderRadius.circular(11),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.scanResult.device.name.isEmpty
                      ? "Unknown Device"
                      : widget.scanResult.device.name,
                  style: kRequestBoxTitle,
                  textAlign: TextAlign.left,
                )),
                widget.scanResult.advertisementData.connectable
                    ? FilledButton(
                        onPressed: () async {
                          connectCane.connectByIndex(widget.index);
                          //await widget.scanResult.device.connect();
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: kButtonPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0))),
                        child: BlocBuilder<ConnectCaneCubit, ConnectCaneState>(
                          builder: (context, state) {
                            if (state is CaneConnecting) {
                              return Text(
                                "Connecting",
                                style: kSmallBtnActiveText,
                              );
                            } else if (state is CaneConnected) {
                              return Text(
                                "Disconnect",
                                style: kSmallBtnActiveText,
                              );
                            } else {
                              return Text(
                                "Connect",
                                style: kSmallBtnActiveText,
                              );
                            }
                          },
                        ),
                      )
                    : FilledButton(
                        onPressed: null,
                        style: FilledButton.styleFrom(
                            backgroundColor: kButtonPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0))),
                        child: Text(
                          "Unavailable",
                          style: kSmallBtnActiveText,
                        ),
                      )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.scanResult.device.id.id.toString(),
                  style: kDarkGreySmalltextStyle,
                  textAlign: TextAlign.left,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "distance : ${widget.scanResult.rssi}",
                  style: kDarkGreySmalltextStyle,
                  textAlign: TextAlign.left,
                )),
              ],
            ),
          ],
        ));
  }
}
