import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_mood_app/constants.dart';
import 'package:notes_mood_app/model/exp.dart';
import 'package:notes_mood_app/model/quote.dart';

const quoteCardColors = [
  dashBoardColor,
  Color(0xffA2D2FF),
  Color(0xff34A853),
  Color(0xffFF8243),
  Color(0xffFF5C58),
  Color(0xffF5A962),
  Color(0xff9FE6A0),
];

const moodDashText = [
  "Motivation",
  "Thoughts",
  "Quotes",
  "Wise Words",
];

class MoodScreen extends StatelessWidget {
  const MoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbRef = FirebaseDatabase.instance.reference();
    final _quotesRef = _dbRef.child('quotes');

    final quoteStyle = GoogleFonts.josefinSans(
      fontSize: 25,
      color: Colors.black,
    );

    final authorStyle = GoogleFonts.roboto(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff9f8fd),
        body: Center(
          child: Column(
            children: [
              StreamBuilder(
                stream: _quotesRef.orderByKey().limitToLast(11).onValue,
                builder: (context, snapshot) {
                  final quotesList = <QuoteListItem>[];
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: dashBoardColor,
                      )),
                    );
                  }
                  final myQuotes = Map<String, dynamic>.from(
                      (snapshot.data! as Event).snapshot.value);
                  myQuotes.forEach(
                    (key, value) {
                      final quotes =
                          Quote.fromJson(Map<String, dynamic>.from(value));
                      final quote = QuoteListItem(
                          quote: quotes.quote, author: quotes.author);
                      quotesList.add(quote);
                    },
                  );
                  return Expanded(
                    child: ListView.builder(
                      itemCount: quotesList.length,
                      itemBuilder: (
                        context,
                        index,
                      ) =>
                          index == 0
                              ? buildMoodDashboard(context)
                              : buildQuoteCard(
                                  index, context, quoteStyle, authorStyle,
                                  quote: quotesList[index].quote,
                                  author: quotesList[index].author),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildMoodDashboard(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: const BoxDecoration(
            color: dashBoardColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Today's",
                    style: GoogleFonts.josefinSans(
                      wordSpacing: -3,
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    moodDashText[Random().nextInt(moodDashText.length)],
                    style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Padding buildQuoteCard(int index, BuildContext context, TextStyle quoteStyle,
      TextStyle authorStyle,
      {@required quote, @required author}) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: quoteCardColors[index % quoteCardColors.length],
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SelectableText(
                    quote,
                    style: quoteStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SelectableText(
                    "- $author",
                    style: authorStyle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
