import 'package:flutter/material.dart';
import 'package:medichub/screens/profile.dart';
import 'package:medichub/screens/appointments_screen.dart';
import 'package:medichub/screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/doctors_list_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  int currentPageIndex = 1;
  int homeSubPageIndex = 0;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final List<Widget> _homeSectionScreens = [
      HomeScreen(onSearchPressed: (String query) {
        setState(() {
          homeSubPageIndex = 1;
          searchQuery = query;
        });
      }),
      DoctorsListScreen(query: searchQuery,iconPress: (){
        setState(() {
          homeSubPageIndex=2;
        });
      }),
      Profile(backPress:(){
        setState(() {
          homeSubPageIndex=1;
        });
      })
    ];

    final List<Widget> _screens = [
      AppointmentsScreen(),
      _homeSectionScreens[homeSubPageIndex],
      ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) => states.contains(WidgetState.selected)
                  ? const TextStyle(color: Color(0xFFCEFDFF))
                  : const TextStyle(color: Colors.white)
          ),
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.alarm, color: currentPageIndex == 0 ? Color(0xFF007EA7) : Colors.white),
              label: 'Citas',
            ),
            NavigationDestination(
              icon: Icon(Icons.home, color: currentPageIndex == 1 ? Color(0xFF007EA7) : Colors.white),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.person, color: currentPageIndex == 2 ? Color(0xFF007EA7) : Colors.white),
              label: 'Perfil',
            )
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              if (index == 1) {
                homeSubPageIndex = 0;
              }
            });
          },
          backgroundColor: Color(0xFF007EA7),
          animationDuration: Duration(microseconds: 1000),
          indicatorColor: Colors.white,
        ),
      ),
    );
  }
}
