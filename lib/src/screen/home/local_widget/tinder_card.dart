import 'package:app/src/application.dart';
import 'package:app/src/screen/home/local_widget/local_widgets.dart';

class TinderCard extends StatelessWidget {
  final String image;
  final bool isFront;
  const TinderCard(this.image, this.isFront, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    final card = Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          image,
          width: getWidth(100),
          height: getHeight(100),
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.2),
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
    return isFront
        ? GestureDetector(
            onPanStart: provider.start,
            onPanUpdate: provider.update,
            onPanEnd: provider.end,
            child: AnimatedContainer(
              transform: Matrix4.identity()
                ..translate(getWidth(50), getHeight(50))
                ..rotateZ(provider.angle)
                ..translate(-getWidth(50), -getHeight(50))
                ..translate(
                    provider.currentPosition.dx, provider.currentPosition.dy),
              duration: Duration(milliseconds: provider.isUpdate ? 0 : 400),
              child: Stack(
                children: [
                  card,
                  CustomBanner(
                    Status.like,
                    Colors.green,
                    top: 50,
                    left: 40,
                    opacity: (provider.currentPosition.dx / getWidth(40))
                        .clamp(0, 1),
                  ),
                  CustomBanner(
                    Status.dislike,
                    Colors.red,
                    top: 50,
                    right: 40,
                    opacity: (-provider.currentPosition.dx / getWidth(40))
                        .clamp(0, 1),
                  ),
                  CustomBanner(
                    Status.superLike,
                    Colors.blueAccent,
                    bottom: 50,
                    left: 0,
                    right: 0,
                    opacity: (-provider.currentPosition.dy / getHeight(20))
                        .clamp(0, 1),
                  ),
                ],
              ),
            ),
          )
        : card;
  }
}
