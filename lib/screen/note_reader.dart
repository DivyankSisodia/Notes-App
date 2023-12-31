import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
        backgroundColor: AppStyle.cardsColor[color_id],
        appBar: AppBar(
          backgroundColor: AppStyle.cardsColor[color_id],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                widget.doc['Note title'],
                style: AppStyle.mainTitle,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.doc['creation date'],
                style: AppStyle.datetitle,
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  widget.doc['note content'],
                  style: AppStyle.mainContent,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
             await FirebaseFirestore.instance
                .collection('Notes')
                .doc(widget.doc.id)
                .delete();
                setState(() {
                  
                });
                Navigator.pop(context);
          },
          label: const Text('Delete'),
          icon: const Icon(Icons.delete),
        ));
  }
}
