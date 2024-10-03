import 'package:flutter/material.dart';
import 'api_service.dart';
import 'voter.dart';
import 'voter_details.dart'; // Make sure to import the details page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voter App',
      debugShowCheckedModeBanner: false, // Set to false to remove the debug banner
      theme: ThemeData(
        primaryColor: Colors.purple, // Set the primary color to purple
        scaffoldBackgroundColor: Colors.black, // Set the background color to black
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple, // Set AppBar color
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Title color
        ),
        cardColor: Colors.grey[850], // Card color for better contrast
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white), // Default body text color
          bodySmall: TextStyle(color: Colors.white70), // Slightly lighter text for secondary info
        ),
      ),
      home: VotersPage(),
    );
  }
}

class VotersPage extends StatefulWidget {
  @override
  _VotersPageState createState() => _VotersPageState();
}

class _VotersPageState extends State<VotersPage> {
  late Future<List<Voter>> futureVoters;

  @override
  void initState() {
    super.initState();
    futureVoters = ApiService().getVoters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Voters'),
      ),
      body: FutureBuilder<List<Voter>>(
        future: futureVoters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Voter> voters = snapshot.data!;
            return ListView.builder(
              itemCount: voters.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the VoterDetailsPage when the card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoterDetailsPage(voter: voters[index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    color: Theme.of(context).cardColor, // Use card color from theme
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name: ${voters[index].name}', style: Theme.of(context).textTheme.displayLarge),
                          SizedBox(height: 5),
                          Text('Email: ${voters[index].email}', style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(height: 5),
                          Text('Phone: ${voters[index].phone}', style: Theme.of(context).textTheme.bodyMedium), // Added mobile number
                          SizedBox(height: 5),
                          Text('Aadhar Card: ${voters[index].aadharCard}', style: Theme.of(context).textTheme.bodyMedium), // Added Aadhar Card
                          SizedBox(height: 10),
                          if (voters[index].photo.isNotEmpty)
                            Image.network(
                              'http://localhost:8000/storage/${voters[index].photo}',
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return Text('Image not loaded', style: TextStyle(color: Colors.red));
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No voters found', style: Theme.of(context).textTheme.bodyMedium));
          }
        },
      ),
    );
  }
}
