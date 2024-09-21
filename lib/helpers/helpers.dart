// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/domain/failures/network_failure.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';

Future loader(Future Function() func, {ToastParam? params}) async {
  final context = AppNavigation.context;
  context.loaderOverlay.show(widgetBuilder: (_) => const Indicator());
  try {
    print("object");
    final response = await func();
    return response;
  } on NetworkFailure catch (e) {
    showToast(e.toString(), params: params);
  } catch (e) {
    showToast(e.toString(), params: params);
  } finally {
    context.loaderOverlay.hide();
  }
  return null;
}

List<T> parseResponse<T>(
  response,
  T Function(Map<String, dynamic>) fromJson,
) {
  var data = (response)['result'];
  if (data is! List) {
    data = data['data'];
  }
  return parseList(data, fromJson);
}

List<T> parseList<T>(
  data,
  T Function(Map<String, dynamic>) fromJson,
) {
  final parsedData = (data as List?)?.cast<Map<String, dynamic>>();
  return parsedData?.map(fromJson).toList().cast<T>() ?? [];
}

Future<void> showToast(String message, {ToastParam? params}) async {
  final context = AppNavigation.context;
  showDialog(
    context: context,
    barrierColor: AppColor.transparent,
    barrierDismissible: false,
    builder: (context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });

      return Dialog(
        shadowColor: AppColor.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: AppColor.transparent,
        insetAnimationCurve: Curves.easeIn,
        insetAnimationDuration: const Duration(milliseconds: 500),
        elevation: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            decoration: BoxDecoration(
              color: params?.backgroundColor ?? Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.horizontalSpace,
                Image.asset(
                  params?.image ?? AppImages.access,
                  color: params?.textColor ?? AppColor.white,
                  filterQuality: FilterQuality.high,
                  height: 25,
                ),
                10.horizontalSpace,
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: params?.textColor ?? AppColor.white,
                      fontFamily: "Varela",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<bool> showConfirmationDialog(String title) async {
  final context = AppNavigation.context;
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.all(0),
            backgroundColor: AppColor.white,
            title: Text(title,
                style: Styles.semiBoldStyle(
                  fontSize: 16,
                  color: AppColor.black1,
                  family: FontFamily.varela,
                )),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: Styles.mediumStyle(
                      fontSize: 14,
                      color: AppColor.black1,
                      family: FontFamily.varela,
                    )),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes',
                    style: Styles.mediumStyle(
                        family: FontFamily.varela,
                        fontSize: 14,
                        color: AppColor.black1)),
              ),
            ],
          );
        },
      ) ??
      false;
}

//date functions
String formatDate(DateTime date) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);

  if (difference.inMinutes <= 1) {
    return 'now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    if (difference.inHours == 1) {
      return '1 hour ago';
    }
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 30) {
    if (difference.inDays == 1) {
      return 'yesterday';
    }
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    if (months == 1) {
      return 'last month';
    }
    return '$months months ago';
  } else {
    int years = (difference.inDays / 365).floor();
    if (years == 1) {
      return 'last year';
    }
    return '$years years ago';
  }
}

Future<DateTime?> getDateFromPicke() async {
  final context = AppNavigation.context;
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2028),
  );
  return date;
}

get scrollBottomPadding => const EdgeInsets.only(bottom: 70);

mixin ToastParam {
  Color? backgroundColor;
  Color? textColor;
  String? image;
}
