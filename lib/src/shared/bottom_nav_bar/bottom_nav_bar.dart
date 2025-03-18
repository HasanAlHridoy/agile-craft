// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final Widget child;
//   const CustomBottomNavBar({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _getSelectedIndex(context),
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               context.go(AppRoutes.dashboardRoute);
//               break;
//             case 1:
//               context.go(AppRoutes.attendanceRoute);
//               break;
//             case 2:
//               context.go(AppRoutes.servicesRoute);
//               break;
//             case 3:
//               context.go(AppRoutes.profileRoute);
//               break;
//           }
//         },
//         backgroundColor: context.theme.cardColor,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in_sharp), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.miscellaneous_services), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize_sharp), label: ''),
//         ],
//       ),
//     );
//   }

//   int _getSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).uri.toString();
//     if (location.startsWith(AppRoutes.attendanceRoute)) return 1;
//     if (location.startsWith(AppRoutes.servicesRoute)) return 2;
//     if (location.startsWith(AppRoutes.profileRoute)) return 3;
//     return 0;
//   }
// }
