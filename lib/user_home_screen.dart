import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';

class UserHomeScreen extends StatelessWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Career Nexus',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () {
              // Handle logout logic here
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserLoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello, $username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Build Resume'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.recommend),
              title: Text('Recommended Jobs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Account Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Welcome, $username!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Dashboard Overview
            SizedBox(height: 10),
            Card(
              color: Colors.teal.shade50,
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Build Your Resume'),
                trailing: Icon(Icons.build),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Card(
              color: Colors.teal.shade50,
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Recommended Jobs'),
                trailing: Icon(Icons.recommend),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}