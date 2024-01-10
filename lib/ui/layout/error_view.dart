// import 'package:flutter/widgets.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/misc/logger.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.text,
    this.retry,
    this.error,
    this.enableRetryButton = true,
    super.key,
  });

  final String text;
  final bool enableRetryButton;
  final dynamic error;
  final void Function()? retry;

  @override
  Widget build(BuildContext context) {
    // show error
    logger.e(text, error: error);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (enableRetryButton && retry != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: retry,
                child: Text(t.retry),
              ),
            ),
        ],
      ),
    );
  }
}
