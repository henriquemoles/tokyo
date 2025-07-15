import 'package:go_router/go_router.dart';
import 'package:tokyo/features/auth/page/login_page.dart';
import 'package:tokyo/features/home/page/home_page.dart';
import 'package:tokyo/features/webviews/webviews_page.dart';

final tokyoRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'login',
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'webview',
      path: '/webview',
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? '';
        final title = state.uri.queryParameters['title'] ?? 'WebView';
        return WebViewPage(url: url, title: title);
      },
    ),
  ],
);
