import 'package:app/src/application.dart';
import 'package:app/src/screen/home/local_widget/tinder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<HomeProvider>();
    return Scaffold(
      body: Stack(
        children: provider.images
            .map((image) => TinderCard(image, image == provider.images.last))
            .toList(),
      ),
    );
  }
}
