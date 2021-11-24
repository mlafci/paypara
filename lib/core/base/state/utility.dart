class Utility {
  static double height, width;
  static double borderRadius = dynamicHeight(0.01);

  static double dynamicHeight(double value) => height * value;
  static double dynamicWidth(double value) => width * value;
  static double dynamicHeightPixel(double size) =>
      dynamicHeight((size / height));
  static double dynamicWidthPixel(double size) => dynamicWidth((size / width));
}
