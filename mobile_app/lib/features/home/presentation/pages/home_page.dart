import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotes = QuoteModel.initialList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('InspiraVerse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Quote',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildDailyCard(context, quotes.first),
                  const SizedBox(height: 32),
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildCategories(context),
                  const SizedBox(height: 32),
                  Text(
                    'For You',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final quote = quotes[index % quotes.length];
                  return _buildQuoteListItem(context, quote);
                },
                childCount: quotes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard(BuildContext context, QuoteModel quote) {
    return GestureDetector(
      onTap: () => context.push('/quote/${quote.quoteId}'),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: AppConstants.primaryGradient,
        ),
        child: Column(
          children: [
            const Icon(Icons.format_quote_rounded, color: Colors.white, size: 40),
            const SizedBox(height: 16),
            Text(
              quote.text,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              '- ${quote.author}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.quoteCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = AppConstants.quoteCategories[index];
          final emoji = AppConstants.categoryEmojis[cat];
          return ActionChip(
            label: Text('$emoji $cat'),
            onPressed: () {
              context.push('/category/$cat');
            },
          );
        },
      ),
    );
  }

  Widget _buildQuoteListItem(BuildContext context, QuoteModel quote) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          quote.text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            quote.author,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        onTap: () => context.push('/quote/${quote.quoteId}'),
      ),
    );
  }
}
