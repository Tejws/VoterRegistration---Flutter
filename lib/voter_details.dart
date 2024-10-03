import 'package:flutter/material.dart';
import 'voter.dart';

class VoterDetailsPage extends StatelessWidget {
  final Voter voter;

  VoterDetailsPage({required this.voter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(voter.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${voter.name}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('Email: ${voter.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone: ${voter.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Aadhar Card: ${voter.aadharCard}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            if (voter.photo.isNotEmpty)
              Image.network(
                'http://localhost:8000/storage/${voter.photo}',
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Text('Image not loaded', style: TextStyle(color: Colors.red));
                },
              ),
          ],
        ),
      ),
    );
  }
}
