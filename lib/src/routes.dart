import 'package:go_router/go_router.dart';
import 'package:tryout/src/models/webview_args.dart';
import 'models/route_args.dart';
import 'pages/enter_code.dart';
import 'pages/error_page.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/notification_viewer.dart';
import 'pages/notify.dart';
import 'pages/splash.dart';
import 'pages/web_viewer.dart';

class Routes {
  Routes._();
  static const String splash = '/splash';
  static const String enterCode = '/enter_code';
  static const String notify = '/notify';
  static const String notificationViewer = '/notification_viewer';
  static const String home = '/home';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String webViewer = '/web_viewer';
  static const String hcCallback = '/HC2020/ui/auth-callback';

  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String contactus = '/contactus';
  static const String aboutus = '/contactus';

  static GoRouter getRoutes = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const EnterCodePage();
        },
      ),
      GoRoute(
        path: home,
        builder: (context, state) {
          return HomePage(title: 'Home', routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: splash,
        builder: (context, state) {
          return SplashPage(routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: login,
        builder: (context, state) {
          return LoginPage(routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: enterCode,
        builder: (context, state) {
          return EnterCodePage(routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: notify,
        builder: (context, state) {
          return NotifyPage(routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: notificationViewer,
        builder: (context, state) {
          return NotificationViewerPage(routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: webViewer,
        builder: (context, state) {
          return WebViewerPage(routeArgs: _getRouteArgs(state));
        },
      ),
      GoRoute(
        path: hcCallback,
        builder: (context, state) {
          RouteArgs args = _getRouteArgs(state);
          WebViewArgs wvArgs = WebViewArgs();
          wvArgs.initialUrl = 'https://uat.mediresource.com/HC2020/ui/main/dashboard';
          args.extra = wvArgs;
          return WebViewerPage(routeArgs: args);
        },
      ),                                                
    ],
    errorBuilder: (context, state) {
      return ErrorPage(routeArgs: _getRouteArgs(state));
    },
  );

  static RouteArgs _getRouteArgs(GoRouterState state){
    return RouteArgs(
      state.uri, 
      state.matchedLocation, 
      state.name, 
      state.path, 
      state.fullPath, 
      state.pathParameters, 
      state.extra, 
      state.pageKey,
      state.error?.message);
  }
}