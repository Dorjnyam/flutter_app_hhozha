import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Hello, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$2,548.00',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Income',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    Text(
                      '\$1,840.00',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Expense',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    Text(
                      '\$284.00',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            const Text(
              'Send Again',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile1.png'),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile2.png'),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile3.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
