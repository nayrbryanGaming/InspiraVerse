import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/constants/app_constants.dart';

class QuoteDetailPage extends StatelessWidget {
  final String quoteId;

  const QuoteDetailPage({super.key, required this.quoteId});

  @override
  Widget build(BuildContext context) {
    // Look up quote locally
    final quote = QuoteModel.initialList.firstWhere(
      (q) => q.quoteId == quoteId,
      orElse: () => QuoteModel.initialList.first,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              context.push('/share/$quoteId');
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppConstants.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.format_quote_rounded, size: 80, color: Colors.white54),
                const SizedBox(height: 32),
                Text(
                  quote.text,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        height: 1.3,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Text(
                  '- ${quote.author}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white70,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Chip(
                    label: Text(quote.category),
                    backgroundColor: Colors.white24,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to Favorites')),
          );
        },
        child: const Icon(Icons.favorite_border),
      ),
    );
  }
}
