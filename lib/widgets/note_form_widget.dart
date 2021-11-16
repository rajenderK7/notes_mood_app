import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const Divider(
                height: 2,
                thickness: 1,
                color: Colors.black54,
              ),
              // const SizedBox(height: 4),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: GoogleFonts.openSans(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.black54),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => SingleChildScrollView(
        child: TextFormField(
          maxLines: null, // Grow automatically
          initialValue: description,
          style: GoogleFonts.lato(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Type something...',
            hintStyle: GoogleFonts.lato(color: Colors.black54),
          ),
          validator: (title) => title != null && title.isEmpty
              ? 'The description cannot be empty'
              : null,
          onChanged: onChangedDescription,
        ),
      );
}
