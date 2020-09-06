import 'package:flutter/material.dart';

/* vai exibir os errors */
class ErrorBox extends StatelessWidget {
  ErrorBox({this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Container();
    }
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white, size: 40),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              'OOOPS! $message. Please try again!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
