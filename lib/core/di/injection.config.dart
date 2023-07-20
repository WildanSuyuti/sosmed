// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logique_test/core/di/register_module.dart' as _i26;
import 'package:logique_test/core/local/local_data.dart' as _i6;
import 'package:logique_test/core/network/api_service.dart' as _i7;
import 'package:logique_test/core/network/dio_client.dart' as _i5;
import 'package:logique_test/features/comment/data/data_sources/comment_remote_data_source.dart'
    as _i8;
import 'package:logique_test/features/comment/data/repositories/comment_repository_impl.dart'
    as _i10;
import 'package:logique_test/features/comment/domain/repositories/comment_repository.dart'
    as _i9;
import 'package:logique_test/features/comment/domain/use_cases/create_comment_use_case.dart'
    as _i11;
import 'package:logique_test/features/comment/domain/use_cases/get_all_comment_use_case.dart'
    as _i12;
import 'package:logique_test/features/comment/presentation/manager/comment_cubit.dart'
    as _i19;
import 'package:logique_test/features/post/data/data_sources/post_remote_data_source.dart'
    as _i13;
import 'package:logique_test/features/post/data/repositories/post_repository_impl.dart'
    as _i15;
import 'package:logique_test/features/post/domain/repositories/post_repository.dart'
    as _i14;
import 'package:logique_test/features/post/domain/use_cases/get_all_post_usecase.dart'
    as _i20;
import 'package:logique_test/features/post/presentation/manager/post_list_cubit.dart'
    as _i23;
import 'package:logique_test/features/user/data/data_sources/user_remote_data_source.dart'
    as _i16;
import 'package:logique_test/features/user/data/repositories/user_repository_impl.dart'
    as _i18;
import 'package:logique_test/features/user/domain/repositories/user_repository.dart'
    as _i17;
import 'package:logique_test/features/user/domain/use_cases/get_all_user_usecase.dart'
    as _i21;
import 'package:logique_test/features/user/domain/use_cases/get_user_detail_usecase.dart'
    as _i22;
import 'package:logique_test/features/user/presentation/manager/user_detail_cubit.dart'
    as _i24;
import 'package:logique_test/features/user/presentation/manager/user_list_cubit.dart'
    as _i25;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.lazySingletonAsync<_i3.Box<dynamic>>(
      () => registerModule.openBox,
      preResolve: true,
    );
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i5.DioClient>(() => registerModule.client);
    gh.lazySingleton<_i6.LocalData>(() => registerModule.localData);
    gh.lazySingleton<_i7.ApiService>(() => _i7.ApiService(gh<_i5.DioClient>()));
    gh.lazySingleton<_i8.CommentRemoteDataSource>(
        () => _i8.CommentRemoteDataSourceImpl(gh<_i7.ApiService>()));
    gh.lazySingleton<_i9.CommentRepository>(
        () => _i10.CommentRepositoryImpl(gh<_i8.CommentRemoteDataSource>()));
    gh.factory<_i11.CreateCommentUseCase>(
        () => _i11.CreateCommentUseCase(gh<_i9.CommentRepository>()));
    gh.factory<_i12.GetAllCommentUseCase>(
        () => _i12.GetAllCommentUseCase(gh<_i9.CommentRepository>()));
    gh.lazySingleton<_i13.PostRemoteDataSource>(
        () => _i13.PostRemoteDataSourceImpl(gh<_i7.ApiService>()));
    gh.lazySingleton<_i14.PostRepository>(
        () => _i15.PostRepositoryImpl(gh<_i13.PostRemoteDataSource>()));
    gh.lazySingleton<_i16.UserRemoteDataSource>(
        () => _i16.UserRemoteDataSourceImpl(gh<_i7.ApiService>()));
    gh.lazySingleton<_i17.UserRepository>(
        () => _i18.UserRepositoryImpl(gh<_i16.UserRemoteDataSource>()));
    gh.factory<_i19.CommentCubit>(() => _i19.CommentCubit(
          gh<_i12.GetAllCommentUseCase>(),
          gh<_i11.CreateCommentUseCase>(),
        ));
    gh.factory<_i20.GetAllPostUseCase>(
        () => _i20.GetAllPostUseCase(gh<_i14.PostRepository>()));
    gh.factory<_i21.GetAllUserUseCase>(
        () => _i21.GetAllUserUseCase(gh<_i17.UserRepository>()));
    gh.factory<_i22.GetUserDetailUseCase>(
        () => _i22.GetUserDetailUseCase(gh<_i17.UserRepository>()));
    gh.factory<_i23.PostListCubit>(
        () => _i23.PostListCubit(gh<_i20.GetAllPostUseCase>()));
    gh.factory<_i24.UserDetailCubit>(
        () => _i24.UserDetailCubit(gh<_i22.GetUserDetailUseCase>()));
    gh.factory<_i25.UserListCubit>(
        () => _i25.UserListCubit(gh<_i21.GetAllUserUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i26.RegisterModule {}
