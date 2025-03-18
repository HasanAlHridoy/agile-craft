class AppRoutes {
  static const String homeRoute = '/';
  static const String signinRoute = '/signin';

  static const List<String> allRoutes = [
    signinRoute,
    homeRoute,
  ];

  static final List<String> allAuthRequiredRoutes = [...allRoutes]..remove(signinRoute);

  static final List<String> authRelatedRoutes = [signinRoute];
}
