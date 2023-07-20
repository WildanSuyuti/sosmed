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
import 'package:logique_test/core/di/register_module.dart' as _i27;
import 'package:logique_test/core/local/local_data.dart' as _i6;
import 'package:logique_test/core/network/api_service.dart' as _i8;
import 'package:logique_test/core/network/dio_client.dart' as _i5;
import 'package:logique_test/features/comment/data/data_sources/comment_remote_data_source.dart'
    as _i9;
import 'package:logique_test/features/comment/data/repositories/comment_repository_impl.dart'
    as _i11;
import 'package:logique_test/features/comment/domain/repositories/comment_repository.dart'
    as _i10;
import 'package:logique_test/features/comment/domain/use_cases/create_comment_use_case.dart'
    as _i12;
import 'package:logique_test/features/comment/domain/use_cases/get_all_comment_use_case.dart'
    as _i13;
import 'package:logique_test/features/comment/presentation/manager/comment_cubit.dart'
    as _i20;
import 'package:logique_test/features/post/data/data_sources/post_remote_data_source.dart'
    as _i14;
import 'package:logique_test/features/post/data/repositories/post_repository_impl.dart'
    as _i16;
import 'package:logique_test/features/post/domain/repositories/post_repository.dart'
    as _i15;
import 'package:logique_test/features/post/domain/use_cases/get_all_post_usecase.dart'
    as _i21;
import 'package:logique_test/features/post/presentation/manager/post_list_cubit.dart'
    as _i24;
import 'package:logique_test/features/user/data/data_sources/user_remote_data_source.dart'
    as _i17;
import 'package:logique_test/features/user/data/repositories/user_repository_impl.dart'
    as _i19;
import 'package:logique_test/features/user/domain/repositories/user_repository.dart'
    as _i18;
import 'package:logique_test/features/user/domain/use_cases/get_all_user_usecase.dart'
    as _i22;
import 'package:logique_test/features/user/domain/use_cases/get_user_detail_usecase.dart'
    as _i23;
import 'package:logique_test/features/user/presentation/manager/user_detail_cubit.dart'
    as _i25;
import 'package:logique_test/features/user/presentation/manager/user_list_cubit.dart'
    as _i26;
import 'package:m_toast/m_toast.dart' as _i7;

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
    gh.lazySingleton<_i7.ShowMToast>(() => registerModule.toast);
    gh.lazySingleton<_i8.ApiService>(() => _i8.ApiService(gh<_i5.DioClient>()));
    gh.lazySingleton<_i9.CommentRemoteDataSource>(
        () => _i9.CommentRemoteDataSourceImpl(gh<_i8.ApiService>()));
    gh.lazySingleton<_i10.CommentRepository>(
        () => _i11.CommentRepositoryImpl(gh<_i9.CommentRemoteDataSource>()));
    gh.factory<_i12.CreateCommentUseCase>(
        () => _i12.CreateCommentUseCase(gh<_i10.CommentRepository>()));
    gh.factory<_i13.GetAllCommentUseCase>(
        () => _i13.GetAllCommentUseCase(gh<_i10.CommentRepository>()));
    gh.lazySingleton<_i14.PostRemoteDataSource>(
        () => _i14.PostRemoteDataSourceImpl(gh<_i8.ApiService>()));
    gh.lazySingleton<_i15.PostRepository>(
        () => _i16.PostRepositoryImpl(gh<_i14.PostRemoteDataSource>()));
    gh.lazySingleton<_i17.UserRemoteDataSource>(
        () => _i17.UserRemoteDataSourceImpl(gh<_i8.ApiService>()));
    gh.lazySingleton<_i18.UserRepository>(
        () => _i19.UserRepositoryImpl(gh<_i17.UserRemoteDataSource>()));
    gh.factory<_i20.CommentCubit>(() => _i20.CommentCubit(
          gh<_i13.GetAllCommentUseCase>(),
          gh<_i12.CreateCommentUseCase>(),
        ));
    gh.factory<_i21.GetAllPostUseCase>(
        () => _i21.GetAllPostUseCase(gh<_i15.PostRepository>()));
    gh.factory<_i22.GetAllUserUseCase>(
        () => _i22.GetAllUserUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i23.GetUserDetailUseCase>(
        () => _i23.GetUserDetailUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i24.PostListCubit>(
        () => _i24.PostListCubit(gh<_i21.GetAllPostUseCase>()));
    gh.factory<_i25.UserDetailCubit>(
        () => _i25.UserDetailCubit(gh<_i23.GetUserDetailUseCase>()));
    gh.factory<_i26.UserListCubit>(
        () => _i26.UserListCubit(gh<_i22.GetAllUserUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i27.RegisterModule {}
