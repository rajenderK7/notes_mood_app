import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_mood_app/constants.dart';
import 'package:notes_mood_app/screens/mood_screen.dart';
import 'package:notes_mood_app/screens/notes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userName = "User";
const keyUserName = "username";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  List pages = [
    const NotesPage(),
    const MoodScreen(),
  ];

  @override
  void initState() {
    super.initState();

    getUserName();
  }

  Future getUserName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var currentUserName = sharedPreferences.getString(keyUserName);
    setState(() {
      userName = currentUserName ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      backgroundColor: Colors.white54,
      appBar: buildAppBar(),
      body: pages[index],
      bottomNavigationBar: buildNavBar(),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ADD THIS PART(IMAGE) IF YOU WISH TO HAVE THE USER IMAGE.
                // const Positioned(
                //   top: 2,
                //   left: 2,
                //   child: CircleAvatar(
                //     radius: 40,
                //     backgroundImage: NetworkImage(
                //       "https://images.unsplash.com/photo-1545987796-200677ee1011?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bmV0d29ya3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
                //     ),
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.blue.shade800,
                        ),
                      ),
                      onPressed: () async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(keyUserName, userName);

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 0.5,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            backgroundColor: dashBoardColor,
                            content: Text(
                              "Changes made!\nPlease restart the app..",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                          ),
                        );

                        FocusScope.of(context).previousFocus();
                      },
                    ),
                  ],
                ),
                Text(
                  userName,
                  style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              cursorColor: dashBoardColor,
              initialValue: userName,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildNavBar() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              child: index == 0
                  ? const Icon(
                      Icons.edit,
                      size: 35,
                      color: selectedIconColor,
                    )
                  : const Icon(
                      Icons.edit_outlined,
                      size: 30,
                    ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              child: index == 1
                  ? const Icon(
                      Icons.tag_faces_rounded,
                      size: 35,
                      color: selectedIconColor,
                    )
                  : const Icon(
                      Icons.mood_rounded,
                      size: 30,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: dashBoardColor,
      // backgroundColor: index == 0 ? dashBoardColor : moodScreenColor,
      elevation: 0.0,

      title: Text(
        index == 0
            ? "Notes"
            : index == 1
                ? "Mood"
                : "Personal Info",
        style: GoogleFonts.montserrat(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
