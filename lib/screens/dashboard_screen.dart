import 'package:ezytransact/constants.dart';
import 'package:ezytransact/screens/chart_screen.dart';
import 'package:ezytransact/screens/create_transaction_screen.dart';
import 'package:ezytransact/screens/home_screen.dart';
import 'package:ezytransact/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: Column(
            children: [
              Consumer<AuthenticationService>(
                builder: (context, authenticationService, child) {
                  authenticationService.getUserDetails(context);
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello!',
                              style: TextStyle(
                                color: kDarkAccentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              authenticationService.activeUser.name ?? '',
                              style: TextStyle(
                                color: kDarkSecondaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<AuthenticationService>(context,
                                  listen: false)
                              .signOut();
                        },
                        child: Icon(
                          Icons.logout,
                          color: kDarkAccentColor,
                          size: 25,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Divider(
                color: kPrimaryColor,
                thickness: 1,
                height: 30,
              ),
              const SizedBox(height: 5),
              _screens[_currentIndex],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTransactionScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: kLightSecondaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.compare_arrows,
                      color: _currentIndex == 0
                          ? kDarkAccentColor
                          : kLightAccentColor,
                    ),
                    Text(
                      'Transactions',
                      style: TextStyle(
                        color: _currentIndex == 0
                            ? kDarkAccentColor
                            : kLightAccentColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.insert_chart,
                      color: _currentIndex == 1
                          ? kDarkAccentColor
                          : kLightAccentColor,
                    ),
                    Text(
                      'Analytics',
                      style: TextStyle(
                        color: _currentIndex == 1
                            ? kDarkAccentColor
                            : kLightAccentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
