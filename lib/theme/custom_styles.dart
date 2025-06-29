import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

const Color secondary = Color(0xFFFFB3BA);
const Color tertiary = Color(0xFFB5EAD7);
const Color primary = Color(0xFFC9C9FF);

final ButtonStyle cancelButtonStyle = TextButton.styleFrom(
  foregroundColor: secondary,
  textStyle: const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
);

final ButtonStyle acceptButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: tertiary,
  foregroundColor: Colors.white,
  textStyle: const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  disabledBackgroundColor: Colors.grey.withOpacity(0.5),
  disabledForegroundColor: Colors.white.withOpacity(0.7),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);