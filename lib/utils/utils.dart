import 'dart:io';
import 'dart:typed_data';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:intl/intl.dart';

class Utils {
  static void showMessage(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? '',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static String? getTextPriority(Priority? priority) {
    return priority?.text;
  }

  static String? getValuePriority(Priority? priority) {
    return priority?.value;
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static Color getColorByPriority(Priority? priority) {
    Color? color;
    if (priority == Priority.high) {
      color = Color(0xFFA9DF9C);
    } else if (priority == Priority.medium) {
      color = Color(0xFFF9CC7A);
    } else {
      color = Color(0xFFEA8EBC);
    }
    return color;
  }

  static T enumFromString<T>(String key, List<T> values) {
    return values.firstWhere((v) => key == getValuePriority(v as Priority));
  }

  static Future<void> downloadFile({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
    required BuildContext context,
  }) async {
    try {
      await DocumentFileSavePlus().saveFile(
        bytes,
        fileName,
        mimeType,
      );
      Utils.showMessage(context, 'Documento descargado correctamente');
    } catch (e) {
      Utils.showCustomDialog(
        context: context,
        text: 'Ocurrio un error al descargar el archivo',
        isError: true,
      );
    }
  }

  static String dateToString({required DateTime dateTime}) {
    return DateFormat('yyyyMMddHHmmss', 'es').format(dateTime) +
        '${dateTime.millisecond}' +
        '${dateTime.microsecond}';
  }

  static Future<File?> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    File? file;
    if (result != null) {
      file = File(result.files.single.path!);
    }
    return file;
  }

  static Future<bool?> showCustomDialog({
    required BuildContext context,
    String? text,
    bool isError = false,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side:
                BorderSide(color: isError ? kPrimaryColor : Color(0xFFE3DDDD)),
          ),
          backgroundColor: Colors.black,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: kRulukoFont,
                    color: kGrayColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CustomButton(
                  height: 45,
                  color: isError ? kPrimaryColor : Color(0xFF495F75),
                  onTap: () => Navigator.pop(dialogContext),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: kGugiFont,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static EvaluationSummary getEvaluationSummary(double percentage) {
    EvaluationSummary evaluationSummary;
    if (percentage < 33) {
      evaluationSummary = EvaluationSummary.veryDeficient;
    } else if (percentage >= 33 && percentage < 66) {
      evaluationSummary = EvaluationSummary.deficient;
    } else {
      evaluationSummary = EvaluationSummary.excellent;
    }
    return evaluationSummary;
  }
}

enum Priority {
  high('HIGH', 'Mega importante'),
  medium('MEDIUM', 'Importante'),
  low('LOW', 'Normal');

  const Priority(this.value, this.text);
  final String value;
  final String text;
}

enum SummarySurveyType {
  taskCompletion,
  timeManagement,
  participation,
}

enum EvaluationSummary {
  veryDeficient,
  deficient,
  excellent,
}
