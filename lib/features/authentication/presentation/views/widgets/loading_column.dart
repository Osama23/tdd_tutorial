import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  const LoadingColumn({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10,),
          Text('$message...'),
        ],
      ),
    );
  }
}
