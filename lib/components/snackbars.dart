import 'package:flutter/material.dart';

void showLoadingSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    backgroundColor: Colors.grey[800],
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      side: BorderSide(color: Colors.yellowAccent, width: 2),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    backgroundColor: Colors.grey[800],
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      side: BorderSide(color: Colors.greenAccent, width: 2),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    backgroundColor: Colors.grey[800],
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      side: BorderSide(color: Colors.redAccent, width: 2),
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
