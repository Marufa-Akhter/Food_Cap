import 'package:flutter/material.dart';
import 'package:final_project/const_config/color_config.dart';
import 'package:final_project/const_config/text_config.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: MyColor.error,
                size: 64,
              ),
              const SizedBox(height: 20),
              Text(
                'Oops!',
                style: TextDesign().dashboardWidgetTitle,
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                style: TextStyle(
                  color: MyColor.disabled,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
