import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/style/app_style.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _contentcontroller = TextEditingController();

  String date = DateTime.now().toString();

  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Write new thoughts',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: _titlecontroller,
              decoration: const InputDecoration(
                hintText: 'Thought title',
                border: InputBorder.none,
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              date,
              style: AppStyle.datetitle,
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              controller: _contentcontroller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Imprint your Thoughts',
                border: InputBorder.none,
              ),
              style: AppStyle.mainTitle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          FirebaseFirestore.instance.collection('Notes').add({
            'Note title': _titlecontroller.text,
            'note content': _contentcontroller.text,
            'creation date': date,
            'color_id': color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print('Failed to add user: $error'));
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
