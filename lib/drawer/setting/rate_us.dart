import 'package:flutter/material.dart';

class RateUsPage extends StatefulWidget {
  @override
  _RateUsPageState createState() => _RateUsPageState();
}

class _RateUsPageState extends State<RateUsPage> {
  double _rating = 0.0;
  List<int> _ratings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2C3E50),
        title: Text('Rate Us', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please rate our app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Slider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 5,
              label: 'Rating: ${_rating.toStringAsFixed(1)}',
              onChanged: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_rating > 0) {
                  setState(() {
                    _ratings.add(_rating.toInt());
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Thank you for your rating!'),
                      content: Text('Your rating has been saved.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('No Rating'),
                      content: Text('Please select a rating before submitting.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Submit Rating'),
            ),
            SizedBox(height: 20),
            _ratings.isEmpty
                ? Text('No ratings yet.')
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Previous Ratings:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _ratings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Rating: ${_ratings[index]}'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
