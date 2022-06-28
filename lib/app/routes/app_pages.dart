import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/session/bindings/session_binding.dart';
import '../modules/session/views/session_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.session;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.session,
      page: () => const SessionView(),
      binding: SessionBinding(),
    ),
  ];
}
