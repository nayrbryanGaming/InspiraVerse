import 'package:flutter/material.dart';
import '../../../../models/quote_model.dart';
import 'package:go_router/go_router.dart';

class CategoryQuotesPage extends StatelessWidget {
  final String category;

  const CategoryQuotesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Filter quotes natively for demo
    final quotes = QuoteModel.initialList
        .where((q) => category == 'All' || q.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Quotes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          final quote = quotes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(quote.text),
              subtitle: Text(quote.author),
              onTap: () => context.push('/quote/${quote.quoteId}'),
            ),
          );
        },
      ),
    );
  }
}
