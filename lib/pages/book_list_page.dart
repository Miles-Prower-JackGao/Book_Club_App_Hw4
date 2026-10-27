import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/books.dart';

class BookListPage extends StatelessWidget {
  final SortType sortType;
  const BookListPage({super.key, required this.sortType});

  @override
  Widget build(BuildContext context) {
    final books = sortedBooks(sortType);
    final isAuthor = sortType == SortType.author;
    final detailRoute = isAuthor ? 'byAuthorDetail' : 'byTitleDetail';
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 16, 16),
          child: Text(
            isAuthor ? 'Sorted by Author' : 'Sorted by Title',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final book = books[index];
              return Material(
                color: colorScheme.surfaceContainerLow,
                child: InkWell(
                  onTap: () => context.goNamed(detailRoute, extra: book),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.title,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          book.author,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}