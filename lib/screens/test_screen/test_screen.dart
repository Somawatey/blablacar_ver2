import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';



class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Test Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Primary Buttons:', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),
            
            BlaButton(
              text: 'Primary Button',
              onPressed: () => print('Primary pressed'),
            ),
            const SizedBox(height: 8),
            BlaButton(
              text: 'Primary',
              leftIcon: Icons.search,
              onPressed: () => print('primary With icon pressed'),
            ),

            const SizedBox(height: 32),

            const Text(
              'Secondary Buttons:', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),

            BlaButton(
              text: 'Secondary Button',
              type: BlaButtonType.secondary,
              onPressed: () => print('Secondary pressed'),
            ),
            const SizedBox(height: 8),
            BlaButton(
              text: 'Secondary',
              type: BlaButtonType.secondary,
              leftIcon: Icons.history,
              onPressed: () => print('Secondary with icon pressed'),
            ),
          ],
        ),
      ),
    );
  }
}