import 'package:flutter/material.dart';
class AdminScreen extends StatefulWidget {
  @override
  AdminDashboard createState() =>AdminDashboard();
}
class AdminDashboard extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IteamHub Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Log out logic
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Remplacez par une vraie image
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin IteamHub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Users'),
              onTap: () {
                // Logic to navigate to Users screen
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add),
              title: Text('Posts'),
              onTap: () {
                // Logic to navigate to Posts screen
              },
            ),
            ListTile(
              leading: Icon(Icons.comment),
              title: Text('Comments'),
              onTap: () {
                // Logic to navigate to Comments screen
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                // Logic to navigate to Categories screen
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tableau de bord ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'Utilisateurs',
                    icon: Icons.people,
                    count: 500,
                    color: Colors.blue,
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Communautés',
                    icon: Icons.post_add,
                    count: 1200,
                    color: Colors.green,
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Publications',
                    icon: Icons.comment,
                    count: 4800,
                    color: Colors.orange,
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Notifications',
                    icon: Icons.category,
                    count: 20,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title,
      required IconData icon,
      required int count,
      required Color color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
