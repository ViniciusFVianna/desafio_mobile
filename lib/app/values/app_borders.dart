import 'package:flutter/material.dart';
import 'package:get/get.dart';

BorderStyle _style = BorderStyle.solid;
double _width = 1.5;

/// Bordas padrões para os widgets
class AppBorders {
  ///Bordas para fields
  static BoxBorder get input => Border.all(
        color: Theme.of(Get.context!).primaryColor,
        style: _style,
        width: _width,
      );
}

extension BorderInput on BoxBorder {
  InputBorder get borderOutline => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: top,
      );

  ///Permite alterar propriedades de um BoxBoder
  BoxBorder copyWithAll({
    Color? color,
    BorderStyle? style,
    double? width,
  }) {
    return Border.all(
      color: color ?? top.color,
      style: style ?? top.style,
      width: width ?? top.width,
    );
  }
}