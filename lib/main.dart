import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTG Life Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LifeCounterScreen(),
    );
  }
}

class LifeCounterScreen extends StatefulWidget {
  @override
  _LifeCounterScreenState createState() => _LifeCounterScreenState();
}

class _LifeCounterScreenState extends State<LifeCounterScreen> {
  // List to store life totals for four players
  List<int> lifeTotals = [40, 40, 40, 40];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MTG Life Counter - Commander'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display a PlayerLifeCounter for each player
            for (int i = 0; i < lifeTotals.length; i++)
              PlayerLifeCounter(
                playerNumber: i + 1,
                lifeTotal: lifeTotals[i],
                onLifeChange: (newLifeTotal) {
                  // Callback to update the life total for a player
                  updateLifeTotal(i, newLifeTotal);
                },
              ),
          ],
        ),
      ),
    );
  }

  // Method to update the life total for a specific player
  void updateLifeTotal(int playerIndex, int newLifeTotal) {
    setState(() {
      lifeTotals[playerIndex] = newLifeTotal;
    });
  }
}

class PlayerLifeCounter extends StatefulWidget {
  final int playerNumber;
  final int lifeTotal;
  final Function(int) onLifeChange;

  PlayerLifeCounter({
    required this.playerNumber,
    required this.lifeTotal,
    required this.onLifeChange,
  });

  @override
  _PlayerLifeCounterState createState() => _PlayerLifeCounterState();
}

class _PlayerLifeCounterState extends State<PlayerLifeCounter> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize a TextEditingController with the current life total
    _controller = TextEditingController(text: widget.lifeTotal.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display player number
          Text('Player ${widget.playerNumber}:'),
          SizedBox(width: 10),
          // Input field for updating the life total
          SizedBox(
            width: 50,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                // Callback to notify parent about the new life total
                int newLifeTotal = int.tryParse(value) ?? 0;
                widget.onLifeChange(newLifeTotal);
              },
            ),
          ),
        ],
      ),
    );
  }
}
