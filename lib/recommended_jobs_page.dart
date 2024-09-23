import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendedJobsPage extends StatefulWidget {
  @override
  _RecommendedJobsPageState createState() => _RecommendedJobsPageState();
}

class _RecommendedJobsPageState extends State<RecommendedJobsPage> {
  List<dynamic> recommendedJobs = [];
  bool isLoading = false;
  final TextEditingController _skillsController = TextEditingController();
  
  Future<void> fetchRecommendedJobs(List<String> userSkills) async {
    final String apiUrl = "http://127.0.0.1:5000/recommend";  // Replace with your Flask API URL

    // Encode the user skills into the request body
    var body = jsonEncode({
      'skills': userSkills,
    });

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedJobs = json.decode(response.body);  // Parse the job recommendations
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching jobs: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitSkills() {
    // Get the skills from the input
    String skillsInput = _skillsController.text.trim();
    
    if (skillsInput.isNotEmpty) {
      // Split the input by commas and remove extra spaces
      List<String> userSkills = skillsInput.split(',').map((skill) => skill.trim()).toList();
      
      // Fetch recommendations using user-provided skills
      fetchRecommendedJobs(userSkills);
    } else {
      print("No skills provided");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Jobs'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your skills (comma-separated):',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _skillsController,
              decoration: InputDecoration(
                hintText: 'e.g., Python, Java, SQL',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitSkills,
              child: Text('Get Recommendations',style: TextStyle(
                color: Colors.white
              ),),
              style: ElevatedButton.styleFrom(primary:Colors.teal),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: recommendedJobs.isEmpty
                        ? Text('No recommendations yet. Enter your skills and press Get Recommendations.')
                        : ListView.builder(
                            itemCount: recommendedJobs.length,
                            itemBuilder: (context, index) {
                              final job = recommendedJobs[index];
                              return ListTile(
                                title: Text(job['Job Title']),
                                subtitle: Text("Similarity: ${job['Similarity'].toStringAsFixed(2)}"),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  // Add your onTap functionality here
                                },
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}

