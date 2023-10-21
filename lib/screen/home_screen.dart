import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/style/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        title: const Text('Imprint thoughts'),
        backgroundColor: AppStyle.mainColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Recent Thoughts',
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Notes').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  // checking if connection is active
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2));
                  }
                  return Text(
                    'There is no Note here !!!',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
