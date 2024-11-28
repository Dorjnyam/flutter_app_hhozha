import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 240,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login_top.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.arrow_back, color: Colors.white),
                          IconButton(
                            icon: const Icon(Icons.notifications,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Түрийвч',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Нийт үлдэгдэл',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '\$2,548.00',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildActionButton(Icons.add, 'Нэмэх'),
                              _buildActionButton(Icons.qr_code, 'Төлөх'),
                              _buildActionButton(Icons.send, 'Илгээх'),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTabButton(0, "Гүйлгээнүүд"),
                      _buildTabButton(1, "Хүлээгдэж буй гүйлгээ"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: selectedIndex == 0
                        ? _buildTransactionsList()
                        : _buildPendingTransactionsList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, size: 28, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildTabButton(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.white : Colors.grey.shade200,
          border: selectedIndex == index
              ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: selectedIndex == index ? Colors.black : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return ListView(
      children: const [
        _TransactionTile(
          logo: 'assets/profile1.png',
          name: 'Upwork',
          date: 'Today',
          amount: '+ \$850.00',
          amountColor: Colors.green,
        ),
        _TransactionTile(
          logo: 'assets/profile1.png',
          name: 'Transfer',
          date: 'Yesterday',
          amount: '- \$85.00',
          amountColor: Colors.red,
        ),
        _TransactionTile(
          logo: 'assets/profile1.png',
          name: 'Paypal',
          date: 'Jan 30, 2022',
          amount: '+ \$1,406.00',
          amountColor: Colors.green,
        ),
        _TransactionTile(
          logo: 'assets/profile1.png',
          name: 'Youtube',
          date: 'Jan 16, 2022',
          amount: '- \$11.99',
          amountColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildPendingTransactionsList() {
    return ListView(
      children: const [
        _TransactionTile(
          logo: 'assets/profile2.png',
          name: 'Youtube',
          date: 'Feb 28, 2022',
          amount: 'Төлөх',
          amountColor: Colors.orange,
        ),
        _TransactionTile(
          logo: 'assets/profile2.png',
          name: 'Electricity',
          date: 'Mar 28, 2022',
          amount: 'Төлөх',
          amountColor: Colors.orange,
        ),
        _TransactionTile(
          logo: 'assets/profile2.png',
          name: 'House Rent',
          date: 'Mar 31, 2022',
          amount: 'Төлөх',
          amountColor: Colors.orange,
        ),
        _TransactionTile(
          logo: 'assets/profile2.png',
          name: 'Spotify',
          date: 'Feb 28, 2022',
          amount: 'Төлөх',
          amountColor: Colors.orange,
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String logo;
  final String name;
  final String date;
  final String amount;
  final Color amountColor;

  const _TransactionTile({
    required this.logo,
    required this.name,
    required this.date,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(logo),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(date,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: amountColor),
          ),
        ],
      ),
    );
  }
}
