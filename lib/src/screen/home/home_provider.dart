import 'dart:math';

import 'package:app/src/application.dart';

class HomeProvider extends ChangeNotifier {
  final images = List.generate(100, (index) => networkImage);
  bool isUpdate = true;
  double angle = 0;

  Offset currentPosition = Offset.zero;

  void start(DragStartDetails details) {}

  void update(DragUpdateDetails details) {
    isUpdate = true;
    currentPosition += details.delta;
    angle = (45 * currentPosition.dx / getWidth(100)) * pi / 180;
    notifyListeners();
  }

  void end(DragEndDetails details) {
    isUpdate = false;
    if (currentPosition.dx >= getWidth(40)) return _removeImage(Status.like);
    if (currentPosition.dx <= -getWidth(40)) {
      return _removeImage(Status.dislike);
    }
    if (currentPosition.dy <= -getHeight(20)) {
      return _removeImage(Status.superLike);
    }
    currentPosition = Offset.zero;
    angle = 0;
    notifyListeners();
  }

  void _removeImage(Status status) {
    switch (status) {
      case Status.like:
        currentPosition = Offset(getWidth(100) * 2, currentPosition.dy);
        break;
      case Status.dislike:
        currentPosition = Offset(-getWidth(100) * 2, currentPosition.dy);
        break;
      case Status.superLike:
        currentPosition = Offset(currentPosition.dx, -getHeight(100) * 2);
        break;
    }

    notifyListeners();
    Future.delayed(const Duration(milliseconds: 400), () {
      images.removeLast();
      currentPosition = Offset.zero;
      angle = 0;
      notifyListeners();
    });
  }
}

enum Status { like, dislike, superLike }
