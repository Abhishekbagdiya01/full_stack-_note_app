import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/presentation/screens/edit_note_page.dart';
import 'package:note_app/utils/const.dart';

import '../../models/note_model.dart';
import 'home_page.dart';

class ViewNoteScreen extends StatelessWidget {
  ViewNoteScreen({required this.noteModel, required this.color, super.key});
  NoteModel noteModel;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_sharp)),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 21),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNoteScreen(
                              noteModel: noteModel, color: color!),
                        ));
                  },
                  child: Text(
                    noteModel.title.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(DateFormat("dd MMMM yyy").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          noteModel.createAt!.toInt()))),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNoteScreen(
                              noteModel: noteModel, color: color!),
                        ));
                  },
                  child: Text(
                    noteModel.description.toString(),
                    style: TextStyle(fontSize: 23, color: blackColor),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
