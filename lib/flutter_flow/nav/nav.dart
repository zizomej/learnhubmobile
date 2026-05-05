import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? AdminDashboardWidget()
          : LoginPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? AdminDashboardWidget()
              : LoginPageWidget(),
        ),
        FFRoute(
          name: WelcomePageWidget.routeName,
          path: WelcomePageWidget.routePath,
          builder: (context, params) => WelcomePageWidget(),
        ),
        FFRoute(
          name: LoginPageWidget.routeName,
          path: LoginPageWidget.routePath,
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: DashboardEtudiantWidget.routeName,
          path: DashboardEtudiantWidget.routePath,
          builder: (context, params) => DashboardEtudiantWidget(),
        ),
        FFRoute(
          name: ProfessorDashboardWidget.routeName,
          path: ProfessorDashboardWidget.routePath,
          asyncParams: {
            'academ': getDoc(
                ['academic_records'], AcademicRecordsRecord.fromSnapshot),
          },
          builder: (context, params) => ProfessorDashboardWidget(
            academ: params.getParam(
              'academ',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: DashboardMedecinWidget.routeName,
          path: DashboardMedecinWidget.routePath,
          builder: (context, params) => DashboardMedecinWidget(),
        ),
        FFRoute(
          name: EventStudentWidget.routeName,
          path: EventStudentWidget.routePath,
          builder: (context, params) => EventStudentWidget(),
        ),
        FFRoute(
          name: MedicalStudentWidget.routeName,
          path: MedicalStudentWidget.routePath,
          builder: (context, params) => MedicalStudentWidget(),
        ),
        FFRoute(
          name: PartnersStudentWidget.routeName,
          path: PartnersStudentWidget.routePath,
          builder: (context, params) => PartnersStudentWidget(),
        ),
        FFRoute(
          name: UniversitiesPageWidget.routeName,
          path: UniversitiesPageWidget.routePath,
          builder: (context, params) => UniversitiesPageWidget(),
        ),
        FFRoute(
          name: RessourcesStudentWidget.routeName,
          path: RessourcesStudentWidget.routePath,
          builder: (context, params) => RessourcesStudentWidget(),
        ),
        FFRoute(
          name: ProfilPageStudentWidget.routeName,
          path: ProfilPageStudentWidget.routePath,
          builder: (context, params) => ProfilPageStudentWidget(),
        ),
        FFRoute(
          name: IntershipStudentWidget.routeName,
          path: IntershipStudentWidget.routePath,
          builder: (context, params) => IntershipStudentWidget(),
        ),
        FFRoute(
          name: EventDetailPageStudentWidget.routeName,
          path: EventDetailPageStudentWidget.routePath,
          builder: (context, params) => EventDetailPageStudentWidget(),
        ),
        FFRoute(
          name: CondidaturesStudentWidget.routeName,
          path: CondidaturesStudentWidget.routePath,
          builder: (context, params) => CondidaturesStudentWidget(),
        ),
        FFRoute(
          name: AdminUserWidget.routeName,
          path: AdminUserWidget.routePath,
          builder: (context, params) => AdminUserWidget(),
        ),
        FFRoute(
          name: AdminStatistiquesWidget.routeName,
          path: AdminStatistiquesWidget.routePath,
          builder: (context, params) => AdminStatistiquesWidget(),
        ),
        FFRoute(
          name: AdminNotificationWidget.routeName,
          path: AdminNotificationWidget.routePath,
          builder: (context, params) => AdminNotificationWidget(),
        ),
        FFRoute(
          name: AdminDashboardWidget.routeName,
          path: AdminDashboardWidget.routePath,
          builder: (context, params) => AdminDashboardWidget(),
        ),
        FFRoute(
          name: StudentPageProfWidget.routeName,
          path: StudentPageProfWidget.routePath,
          builder: (context, params) => StudentPageProfWidget(),
        ),
        FFRoute(
          name: DoctorApointementsWidget.routeName,
          path: DoctorApointementsWidget.routePath,
          builder: (context, params) => DoctorApointementsWidget(),
        ),
        FFRoute(
          name: PrescriptionDoctorWidget.routeName,
          path: PrescriptionDoctorWidget.routePath,
          builder: (context, params) => PrescriptionDoctorWidget(),
        ),
        FFRoute(
          name: NotificationWidget.routeName,
          path: NotificationWidget.routePath,
          builder: (context, params) => NotificationWidget(),
        ),
        FFRoute(
          name: NotesProfWidget.routeName,
          path: NotesProfWidget.routePath,
          builder: (context, params) => NotesProfWidget(),
        ),
        FFRoute(
          name: ValidationPageAdminWidget.routeName,
          path: ValidationPageAdminWidget.routePath,
          builder: (context, params) => ValidationPageAdminWidget(),
        ),
        FFRoute(
          name: ModuleProfWidget.routeName,
          path: ModuleProfWidget.routePath,
          builder: (context, params) => ModuleProfWidget(),
        ),
        FFRoute(
          name: UploadRessourceProfWidget.routeName,
          path: UploadRessourceProfWidget.routePath,
          builder: (context, params) => UploadRessourceProfWidget(),
        ),
        FFRoute(
          name: SettingsWidget.routeName,
          path: SettingsWidget.routePath,
          builder: (context, params) => SettingsWidget(),
        ),
        FFRoute(
          name: RDVDoctorWidget.routeName,
          path: RDVDoctorWidget.routePath,
          builder: (context, params) => RDVDoctorWidget(),
        ),
        FFRoute(
          name: ParentDashobardWidget.routeName,
          path: ParentDashobardWidget.routePath,
          builder: (context, params) => ParentDashobardWidget(),
        ),
        FFRoute(
          name: ParentNotesWidget.routeName,
          path: ParentNotesWidget.routePath,
          builder: (context, params) => ParentNotesWidget(),
        ),
        FFRoute(
          name: ModuleStudentWidget.routeName,
          path: ModuleStudentWidget.routePath,
          builder: (context, params) => ModuleStudentWidget(),
        ),
        FFRoute(
          name: UploadModuleProfWidget.routeName,
          path: UploadModuleProfWidget.routePath,
          builder: (context, params) => UploadModuleProfWidget(),
        ),
        FFRoute(
          name: RessourceProfWidget.routeName,
          path: RessourceProfWidget.routePath,
          asyncParams: {
            'record': getDoc(
                ['academic_records'], AcademicRecordsRecord.fromSnapshot),
          },
          builder: (context, params) => RessourceProfWidget(
            record: params.getParam(
              'record',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: ModifyressourceprofWidget.routeName,
          path: ModifyressourceprofWidget.routePath,
          asyncParams: {
            'record': getDoc(
                ['academic_records'], AcademicRecordsRecord.fromSnapshot),
          },
          builder: (context, params) => ModifyressourceprofWidget(
            record: params.getParam(
              'record',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: NoteaffichageWidget.routeName,
          path: NoteaffichageWidget.routePath,
          asyncParams: {
            'reccord': getDoc(
                ['academic_records'], AcademicRecordsRecord.fromSnapshot),
          },
          builder: (context, params) => NoteaffichageWidget(
            reccord: params.getParam(
              'reccord',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: NotesModifyWidget.routeName,
          path: NotesModifyWidget.routePath,
          asyncParams: {
            'record': getDoc(
                ['academic_records'], AcademicRecordsRecord.fromSnapshot),
          },
          builder: (context, params) => NotesModifyWidget(
            record: params.getParam(
              'record',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: ResumeWidget.routeName,
          path: ResumeWidget.routePath,
          builder: (context, params) => ResumeWidget(),
        ),
        FFRoute(
          name: ResultWidget.routeName,
          path: ResultWidget.routePath,
          builder: (context, params) => ResultWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
