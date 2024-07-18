import 'package:bookly_app/core/errors/faluire_class.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<ServerFaluire, List<BookModel>>> bestSellerBooks() async {
    List<BookModel> books = [];
    try {
      var responseBody = await ApiService(dio: Dio()).get(
          endpoint:
              'https://www.googleapis.com/books/v1/volumes?q=programming');
      for (var element in responseBody['items']) {
        books.add(BookModel.fromJson(element));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaluire.FromDioException(
            dioExecption: e.type,
            response: e.response,
            statusCode: e.response?.statusCode));
      } else {
        return left(ServerFaluire('Oops, there somthing wrong'));
      }
    }
  }

  @override
  Future<Either<ServerFaluire, List<BookModel>>> fetchFeaturedBooks() {
    throw UnimplementedError();
  }
}
