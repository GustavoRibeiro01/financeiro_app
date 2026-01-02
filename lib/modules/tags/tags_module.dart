import 'package:flutter_modular/flutter_modular.dart';
import 'tags_page.dart';

class TagsModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const TagsPage());
  }
}
