import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/screen/note_editor.dart';
import 'package:notes/screen/note_reader.dart';
import 'package:notes/style/app_style.dart';
import 'package:notes/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppStyle.mainColor,
      
      appBar: AppBar(
        title: const Text('Imprint your thoughts'),
        backgroundColor: AppStyle.bgColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        // width: double.infinity,
        // height: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/notes_app.jpg'),
        //     opacity: 0.8,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  'Your Recent Thoughts',
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Notes')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            crossAxisCount: 2,
                          ),
                          children: snapshot.data!.docs
                              .map((note) => noteCard(
                                  () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NoteReaderScreen(note)))
                                      },
                                  note))
                              .toList(),
                        );
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteEditor()));
        },
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
