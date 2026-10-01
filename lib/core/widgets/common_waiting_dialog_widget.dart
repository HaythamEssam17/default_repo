import 'package:flutter/material.dart';
import 'package:pharmacy/core/factories/loading_factory.dart';

Future showWaitingDialog(
  BuildContext context, {
  String msg = 'جاري المعالجة...',
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          contentPadding: const EdgeInsets.all(28),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Center(
                  child: PlatformLoading.buildLoading(context: context),
                ),
              ),
              Text(msg, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    },
  );
}
