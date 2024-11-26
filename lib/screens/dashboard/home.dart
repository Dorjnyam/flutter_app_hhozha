import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'status.dart';
import '../profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          const StatusPage(),
          const DashboardScreen(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildBottomNavItem(Icons.home_filled, 0),
          _buildBottomNavItem(Icons.bar_chart, 1),
          _buildBottomNavItem(Icons.account_balance_wallet_outlined, 2),
          _buildBottomNavItem(Icons.person_outline, 3),
        ],
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                // FAB action
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add, size: 20, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.green : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.white : Colors.grey[700],
        ),
      ),
      label: '',
    );
  }

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              'assets/login_top.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Positioned(
              bottom: 165,
              left: 12,
              right: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Өглөөний мэнд?',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Хэн нэгэн',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -75,
              left: 16,
              right: 16,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/balance_section.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                    top: 30,
                    left: 40,
                    right: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Нийт үлдэгдэл',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                Text(
                                  '\$2,548.00',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Colors.green,
                                      size: 16,
                                    )
                                  ],
                                ),
                                Text(
                                  '\$1,840.00',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$284.00',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: const [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.work),
                ),
                title: Text('Upwork'),
                subtitle: Text('Income'),
                trailing: Text(
                  '\$500.00',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.transfer_within_a_station),
                ),
                title: Text('Шилжүүлэг'),
                subtitle: Text('Expense'),
                trailing: Text(
                  '\$150.00',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.money),
                ),
                title: Text('Paypal'),
                subtitle: Text('Income'),
                trailing: Text(
                  '\$940.00',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.video_library),
                ),
                title: Text('Youtube'),
                subtitle: Text('Expense'),
                trailing: Text(
                  '\$70.00',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Send Again',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile1.png'),
                radius: 32,
              ),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile2.png'),
                radius: 32,
              ),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile3.png'),
                radius: 32,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
