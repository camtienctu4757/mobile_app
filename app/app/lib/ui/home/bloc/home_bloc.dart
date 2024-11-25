import 'dart:async';
import 'dart:typed_data';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'home.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._getServicesUseCase, this._searchServiceUseCase,
      this._getImageUseCase)
      : super(HomeState()) {
    on<HomePageInitiated>(
      _onHomePageInitiated,
      transformer: log(),
    );
    on<ServiceLoadMore>(
      _onUserLoadMore,
      transformer: log(),
    );
    on<HomePageRefreshed>(
      _onHomePageRefreshed,
    );
    on<SearchQueryChanged>(_onSearchQueryChanged, transformer: log());
    on<CategorySelected>(_onCategorySelected, transformer: log());
    on<ServiceLoadImage>(_onServiceLoadImage);
    on<CreatAppointMess>(_onCreatAppointMess);
  }

  final GetServicesUseCase _getServicesUseCase;
  final SearchServiceUseCase _searchServiceUseCase;
  final GetImageUseCase _getImageUseCase;

  FutureOr<void> _onHomePageInitiated(
      HomePageInitiated event, Emitter<HomeState> emit) async {
    await _getService(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async =>
          emit(state.copyWith(isShimmerLoading: false)),
    );
  }

  FutureOr<void> _onUserLoadMore(
      ServiceLoadMore event, Emitter<HomeState> emit) async {
    await _getService(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onHomePageRefreshed(
      HomePageRefreshed event, Emitter<HomeState> emit) async {
    await _getService(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async {
        emit(state.copyWith(isShimmerLoading: false));
        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
        // return completer.future;
      },
    );
  }

  Future<void> _onServiceLoadImage(
      ServiceLoadImage event, Emitter<HomeState> emit) async {
    try {
      final imageData = await _getImageUseCase.execute(GetImageInput(
          path: event.path, queryParameters: event.queryParameters));
      // print(imageData.image);
      if (imageData.image != null && imageData.image!.isNotEmpty) {
        emit(state.copyWith(
          imageData: imageData.image,
          isShimmerLoading: false,
        ));
      } else {
        emit(state.copyWith(
          imageData: Uint8List.fromList([]),
        ));
      }
    } catch (error) {
      logD("Error loading image: $error");
    }
  }

  Future<void> _getService({
    required Emitter<HomeState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getServicesUseCase.execute(
            const GetServiceInput(), isInitialLoad);
        emit(state.copyWith(services: output));
      },
      doOnError: (e) async {
        emit(state.copyWith(loadUsersException: e));
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      maxRetries: 3,
    );
  }

  Future<void> _searchService({
    required Emitter<HomeState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    required String q,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _searchServiceUseCase.execute(
            SearchServiceInput(query: q), isInitialLoad);
        emit(state.copyWith(services: output));
      },
      doOnError: (e) async {
        emit(state.copyWith(loadUsersException: e));
      },
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async {
        emit(state.copyWith(isShimmerLoading: false));
      },
      handleLoading: false,
      maxRetries: 3,
    );
  }

  FutureOr<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<HomeState> emit) async {
    if (event.query.isNotEmpty) {
      print(event.query);
      await _searchService(
        q: event.query,
        emit: emit,
        isInitialLoad: true,
        doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
        doOnSuccessOrError: () async {
          emit(state.copyWith(isShimmerLoading: false));
        },
      );
    }
    // // final query = event.query.trim().toLowerCase();
    // final query = '';

    // if (query.isEmpty) {
    //   // Nếu người dùng xóa hết từ khóa tìm kiếm, trả về danh sách gốc
    //   emit(state.copyWith(searchResults: state.services.data));
    // } else {
    //   // Lọc danh sách dịch vụ theo từ khóa
    //   final filteredResults = state.services.data.where((service) {
    //     return service.name.toLowerCase().contains(query);
    //   }).toList();

    // emit(state.copyWith(searchResults: filteredResults));
    // }
  }

  FutureOr<void> _onCategorySelected(
      CategorySelected event, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedCategory: event.category));

    // Gọi API hoặc lấy dữ liệu sản phẩm liên quan đến danh mục
    // final products = await _getProductsByCategoryUseCase.execute(event.category);
    // Cập nhật state với sản phẩm đã lấy
    // emit(state.copyWith(categoryProducts: products));
  }

  FutureOr<void> _onCreatAppointMess(
      CreatAppointMess event, Emitter<HomeState> emit) async {
    emit(state.copyWith(createbookingMeassage: event.mess));

    // Gọi API hoặc lấy dữ liệu sản phẩm liên quan đến danh mục
    // final products = await _getProductsByCategoryUseCase.execute(event.category);
    // Cập nhật state với sản phẩm đã lấy
    // emit(state.copyWith(categoryProducts: products));
  }
}
