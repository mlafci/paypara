class Utility {
  static double height, width;
  static double borderRadius = dynamicWidth(0.05);

  static double dynamicHeight(double value) => height * value;
  static double dynamicWidth(double value) => width * value;
  static double dynamicHeightPixel(double size) =>
      dynamicHeight((size / height));
  static double dynamicWidthPixel(double size) => dynamicWidth((size / width));
}
