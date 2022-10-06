import 'package:get_it/get_it.dart';
import 'package:mylibraryapp/features/data/datasource/book_datasource.dart';
import 'package:mylibraryapp/features/data/repository/book_repository_impl.dart';
import 'package:mylibraryapp/features/domain/repositories/book_repository.dart';
import 'package:mylibraryapp/features/domain/usecases/book/create_book.dart';
import 'package:mylibraryapp/features/domain/usecases/book/delete_book.dart';
import 'package:mylibraryapp/features/domain/usecases/book/get_books_by_uid.dart';
import 'package:mylibraryapp/features/domain/usecases/book/update_book.dart';
import 'package:mylibraryapp/features/presentation/add_book/cubit/add_book_cubit.dart';
import 'package:mylibraryapp/features/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:mylibraryapp/features/presentation/home/cubit/home_cubit.dart';
import 'package:mylibraryapp/features/presentation/login/cubit/login_cubit.dart';
import 'package:mylibraryapp/features/presentation/reading_books/cubit/reading_books_cubit.dart';

import 'features/data/datasource/user_datasource.dart';
import 'features/data/repository/user_repository_impl.dart';
import 'features/domain/repositories/user_repository.dart';
import 'features/domain/usecases/user/create_user.dart';
import 'features/domain/usecases/user/get_user.dart';
import 'features/domain/usecases/user/get_users.dart';
import 'features/domain/usecases/user/update_user.dart';
import 'features/presentation/readed_books/cubit/readed_book_cubit.dart';

GetIt getIt = GetIt.instance;
void locator() {
  getIt.registerFactory(() => LoginCubit(createUser: getIt()));
  getIt.registerFactory(() => AddBookCubit(createBook: getIt()));
  getIt.registerFactory(() => HomeCubit(getBooksByUId: getIt()));
  getIt.registerFactory(() => ReadingBooksCubit(getBooksByUId: getIt()));
  getIt.registerFactory(() => ReadedBooksCubit(getBooksByUId: getIt()));
  getIt.registerFactory(
      () => BookDetailCubit(deleteBook: getIt(), updateBook: getIt()));

  getIt.registerLazySingleton(() => GetUsersUseCase(userRepository: getIt()));
  getIt.registerLazySingleton(() => GetUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton(() => CreateUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton(() => UpdateUserUseCase(userRepository: getIt()));

  getIt.registerLazySingleton(
      () => GetBooksByUIdUseCase(bookRepository: getIt()));
  getIt.registerLazySingleton(() => CreateBookUseCase(bookRepository: getIt()));
  getIt.registerLazySingleton(() => DeleteBookUseCase(bookRepository: getIt()));
  getIt.registerLazySingleton(() => UpdateBookUseCase(bookRepository: getIt()));

  getIt
      .registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt()));
  getIt.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());

  getIt
      .registerLazySingleton<BookRepository>(() => BookRepositoryImpl(getIt()));
  getIt.registerLazySingleton<BookDataSource>(() => BookDataSourceImpl());
}
