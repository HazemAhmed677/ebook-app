import 'package:bookly_app/core/errors/faluire_class.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

abstract class SearchRepo {
  Future<Either<ServerFaluire, List<BookModel>>> fetchNewestBooks(
      {required String title});
}
