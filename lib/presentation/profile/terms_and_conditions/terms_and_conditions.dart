import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _loadMarkdownFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data!);
            }
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          },
        ),
      ),
    );
  }

  Future<String> _loadMarkdownFile() async {
    return await rootBundle.loadString('assets/terms.md');
  }
}
