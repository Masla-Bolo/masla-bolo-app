import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'extensions.dart';
import '../network/dio/dio_client.dart';
import '../network/network_response.dart';
import 'styles/app_colors.dart';
import 'styles/app_images.dart';
import 'styles/styles.dart';
import 'widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../navigation/app_navigation.dart';

Future loader(Future Function() func, {ToastParam? params}) async {
  final context = AppNavigation.context;
  context.loaderOverlay.show(widgetBuilder: (_) => const Indicator());

  try {
    final response = await func();
    return response;
  } on NetworkResponse catch (e) {
    log("ERROR IN NETWORK: ${e.toString()}");
    if (params?.showToast ?? true) {
      showToast(e.toString(), params: params);
    }
  } on DioException catch (dioError) {
    log("ERROR IN DIO: $dioError");
    final resp = DioClient.handleDioError(dioError);
    showToast(resp.toString(), params: params);
  } catch (e) {
    log("ERROR IN CATCH: ${e.toString()}");
    if (params?.showToast ?? true) {
      showToast("An Internal Error Occurred!", params: params);
    }
  } finally {
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  return null;
}

List<String> getStringList(List<dynamic> data) {
  return data.map((e) => e.toString()).cast<String>().toList();
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
  if (context.mounted) {
    showDialog(
      context: context,
      barrierColor: AppColor.transparent,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(params?.duration ?? const Duration(seconds: 2), () {
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
            alignment: params?.toastAlignment ?? Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
              decoration: BoxDecoration(
                color: params?.backgroundColor ?? context.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (params?.hideImage == false) ...[
                    10.horizontalSpace,
                    Image.asset(
                      params?.image ?? AppImages.access,
                      color: params?.textColor ?? context.colorScheme.primary,
                      filterQuality: FilterQuality.high,
                      height: 25,
                    ),
                  ],
                  10.horizontalSpace,
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: params?.textColor ?? context.colorScheme.primary,
                        fontFamily: "Varela",
                      ),
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
}

Future<bool> showConfirmationDialog(String title) async {
  final context = AppNavigation.context;
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.all(0),
            backgroundColor: context.colorScheme.primary,
            title: Text(title,
                style: Styles.semiBoldStyle(
                  fontSize: 16,
                  color: context.colorScheme.onPrimary,
                  family: FontFamily.varela,
                )),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: Styles.mediumStyle(
                      fontSize: 14,
                      color: context.colorScheme.onPrimary,
                      family: FontFamily.varela,
                    )),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes',
                    style: Styles.mediumStyle(
                        family: FontFamily.varela,
                        fontSize: 14,
                        color: context.colorScheme.onPrimary)),
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

class ToastParam {
  final Color? backgroundColor;
  final Color? textColor;
  final String? image;
  final bool showToast;
  final Duration? duration;
  final Alignment? toastAlignment;
  final bool hideImage;
  ToastParam({
    this.hideImage = false,
    this.duration,
    this.toastAlignment,
    this.backgroundColor,
    this.textColor,
    this.image,
    this.showToast = true,
  });
}
