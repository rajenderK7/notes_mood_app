import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_mood_app/constants.dart';
import 'package:notes_mood_app/db/notes_database.dart';
import 'package:notes_mood_app/model/note.dart';
import 'package:notes_mood_app/screens/edit_note_page.dart';
import 'package:notes_mood_app/screens/home_screen.dart';
import 'package:notes_mood_app/screens/note_detail_page.dart';
import 'package:notes_mood_app/widgets/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  int index = 0;
  late List<Note> notes;
  bool isLoading = false;
  // var _tapPosition;

  @override
  void initState() {
    super.initState();
    // _tapPosition = const Offset(0.0, 0.0);
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();
    // This below line is to reverse the incoming list of notes from the local database in order to place the latest added note at the top.
    notes = notes.reversed.toList();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff9f8fd),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                // height: MediaQuery.of(context).size.height * 0.17,
                decoration: const BoxDecoration(
                  color: dashBoardColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 20, bottom: 10),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 23,
                        right: 0,
                        left: 0,
                        child: Text(
                          getTime() < 12
                              ? "Good Morning,"
                              : (getTime() < 18
                                  ? "Good Afternoon,"
                                  : "Good Evening,"),
                          style: GoogleFonts.josefinSans(
                            wordSpacing: -3,
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.035,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Text(
                          userName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.053,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // const Positioned(
                      //   right: 25,
                      //   top: 25,
                      //   child: CircleAvatar(
                      //     radius: 35,
                      //     backgroundImage: NetworkImage(
                      //       "https://64.media.tumblr.com/239ad7e946a65c9e1cbc6ed508e12269/tumblr_nwbyqyd8RJ1s9ab4to1_500.gifv",
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 2, right: 2),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: dashBoardColor,
                        )
                      : notes.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Start adding notes..',
                                style: GoogleFonts.lato(
                                    color: Colors.black54, fontSize: 20),
                              ),
                            )
                          : buildNotes(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: index == 0
            ? FloatingActionButton(
                backgroundColor: floatingButtonColor,
                child: const Icon(Icons.add),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddEditNotePage(),
                    ),
                  );

                  refreshNotes();
                },
              )
            : null,
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            // final RenderBox overlay = Overlay.of(context).context.findRenderObject();
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));
              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
            //   onLongPress: () {
            //     showMenu(

            //         context: context,
            //         position:  RelativeRect.fromRect(
            // _tapPosition & const Size(40, 40), // smaller rect, the touch area
            // Offset.zero & overlay.size // Bigger rect, the entire screen
            // ),
            //         items: <PopupMenuEntry<String>>[
            //           const PopupMenuItem(child: Text("delete")),
            //           const PopupMenuItem(child: Text("delete")),
            //         ]);
            //   },
          );
        },
      );

  // void _storePosition(TapDownDetails details) {
  //   _tapPosition = details.globalPosition;
  // }

  int getTime() {
    return DateTime.now().hour;
  }
}
