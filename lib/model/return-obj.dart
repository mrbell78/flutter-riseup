import 'package:flutter/material.dart';

class ReturnObj<T> {
  bool success;
  String message;
  T data;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  ReturnObj({
    @required this.success,
    this.message,
    this.data,
  });
}