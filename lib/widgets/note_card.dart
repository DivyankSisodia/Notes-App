import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return Scaffold(
    body: InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppStyle.cardsColor[doc['color_id']],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              doc['Note title'],
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 5,),
            Text(
              doc['creation date'],
              style: AppStyle.datetitle,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              doc['note content'],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}
