import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:note_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:note_app/cubit/note_cubit/note_cubit.dart';
import 'package:note_app/cubit/user_cubit/user_cubit.dart';
import 'package:note_app/models/user_model.dart';
import 'package:note_app/presentation/screens/add_note_page.dart';

import 'package:note_app/presentation/widgets/snackbar.dart';
import 'package:note_app/route/page_const.dart';
import 'package:note_app/utils/const.dart';

import '../../models/note_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.uid, super.key});
  final String? uid;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getMyNotes(NoteModel(creatorId: widget.uid));
    context.read<UserCubit>().myProfile(UserModel(uid: widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Greeting,",
                        style: TextStyle(fontSize: 21, color: whiteColor),
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return CircularProgressIndicator();
                          } else if (state is UserLoaded) {
                            return InkWell(
                              onTap: () {
                                _updateName(state.userModel);
                              },
                              child: Text(
                                state.userModel.username.toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.amberAccent),
                              ),
                            );
                          } else if (state is UserError) {
                            return Text(state.errorMessage);
                          } else
                            return SizedBox();
                        },
                      )
                    ],
                  ),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is UnAuthenticated) {
                        Navigator.pushReplacementNamed(
                            context, PageConst.signInPage);
                        snackbarMessenger(context,
                            "You're now logged out. We're grateful for your time. Until we meet again!");
                      }
                    },
                    child: IconButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).loggedOut();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: whiteColor,
                        )),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: BlocBuilder<NoteCubit, NoteState>(
                  builder: (context, state) {
                    if (state is NoteLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is NoteLoaded) {
                      final arrNotes = state.arrNotes.reversed.toList();
                      return arrNotes.isEmpty
                          ? Center(
                              child: Text(
                              "No notes are there press  + icon to add notes",
                              style: TextStyle(color: whiteColor, fontSize: 20),
                            ))
                          : MasonryGridView.builder(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: arrNotes.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    PageConst.viewNotePage,
                                    arguments: [
                                      arrNotes[index],
                                      getColorByIndex(index)
                                    ],
                                  );
                                },
                                onDoubleTap: () =>
                                    _deleteNoteDialog(arrNotes[index]),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: getColorByIndex(index),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            arrNotes[index].title.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            arrNotes[index]
                                                .description
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: blackColor
                                                    .withOpacity(0.8)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(DateFormat("dd MMMM yyy ")
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      arrNotes[index]
                                                          .createAt!
                                                          .toInt())))
                                        ],
                                      ),
                                    )),
                              ),
                            );
                    } else if (state is NoteError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addNotePage,
              arguments: widget.uid);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _updateName(UserModel user) {
    TextEditingController usernameController = TextEditingController();
    usernameController.text = user.username!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextField(
          controller: usernameController,
          decoration: InputDecoration(
            label: Text("Username"),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              context.read<UserCubit>().updateProfile(UserModel(
                  uid: widget.uid, username: usernameController.text));
              context.read<UserCubit>().myProfile(UserModel(uid: widget.uid));
              Navigator.pop(context);
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }

  void _deleteNoteDialog(NoteModel note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to delete this note ?"),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              log("${note.noteId}");
              BlocProvider.of<NoteCubit>(context)
                  .deleteNote(NoteModel(noteId: note.noteId));

              BlocProvider.of<NoteCubit>(context)
                  .getMyNotes(NoteModel(creatorId: widget.uid));

              Navigator.pop(context);
            },
            child: Text("Yes"),
          )
        ],
      ),
    );
  }
}
