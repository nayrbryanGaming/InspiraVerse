import 'package:flutter/material.dart';
import '../../../../models/quote_model.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for now
    final quotes = QuoteModel.initialList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Quotes'),
      ),
      body: quotes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_outline, size: 64, color: Theme.of(context).disabledColor),
                  const SizedBox(height: 16),
                  Text('No favorites yet', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            )
          : ListView.builder(
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
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),
                      onPressed: () {},
                    ),
                    onTap: () => context.push('/quote/${quote.quoteId}'),
                  ),
                );
              },
            ),
    );
  }
}
