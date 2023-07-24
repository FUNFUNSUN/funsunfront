import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 125,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data',
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          children: [
                            const Text('data'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text('data'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFF80C0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
