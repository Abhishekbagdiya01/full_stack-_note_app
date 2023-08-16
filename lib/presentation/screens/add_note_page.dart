import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/note_cubit/note_cubit.dart';
import 'package:note_app/models/note_model.dart';

import 'package:note_app/presentation/widgets/snackbar.dart';
import 'package:note_app/route/page_const.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({this.uid, super.key});

  String? uid;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 237, 200),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_sharp)),
                  BlocListener<NoteCubit, NoteState>(
                    listener: (context, state) {
                      if (state is NoteAddedState) {
                        snackbarMessenger(context, "Note added ");
                        Navigator.pushReplacementNamed(
                            context, PageConst.homePage,
                            arguments: uid);
                      } else if (state is NoteError) {
                        snackbarMessenger(context, state.errorMessage);
                      }
                    },
                    child: MaterialButton(
                      onPressed: () {
                        NoteModel noteModel = NoteModel(
                            title: titleController.text,
                            description: descController.text,
                            creatorId: uid);

                        BlocProvider.of<NoteCubit>(context).addNote(noteModel);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 5,
                decoration: InputDecoration(hintText: "Description"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
