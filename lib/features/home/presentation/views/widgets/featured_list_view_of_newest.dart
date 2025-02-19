import 'package:bookly_app/core/widgets/shimmer_loading.dart';
import 'package:bookly_app/features/home/presentation/manager/fetch_newest_books.dart/fetch_newest_books_cubit_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/newest_book_item.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class NewestBooksListView extends StatefulWidget {
  const NewestBooksListView({
    super.key,
  });

  @override
  State<NewestBooksListView> createState() => _NewestBooksListViewState();
}

class _NewestBooksListViewState extends State<NewestBooksListView> {
  bool isPushing = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNewestBooksCubitCubit, FetchNewestBooksCubitState>(
      builder: (context, state) {
        if (state is FetchNewestBooksCubitLoading) {
          return const SliverFillRemaining(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ShimmerLoadingForVertical(
              widthArea: 0.1,
              hightArea: 0.2,
            ),
          ));
        } else if (state is FetchNewestBooksCubitSuccess) {
          return SliverPadding(
            padding: const EdgeInsets.only(
              left: 30.0,
            ),
            sliver: SliverList.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  right: 14,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    if (isPushing) {
                      return;
                    }
                    setState(() {
                      isPushing = true;
                    });

                    await GoRouter.of(context)
                        .push('/bookDetails', extra: state.books[index]);
                    setState(() {
                      isPushing = false;
                    });
                  },
                  child: NewestItem(
                    bookModel: state.books[index],
                  ),
                ),
              ),
            ),
          );
        } else if (state is FetchNewestBooksCubitFailuire) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 30),
            child: SliverToBoxAdapter(
              child: Text(state.errorMsg),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Text(''),
          );
        }
      },
    );
  }
}
