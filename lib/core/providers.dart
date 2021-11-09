import 'package:crio_meme_sharing_app/bloc/auth_bloc.dart';
import 'package:crio_meme_sharing_app/bloc/meme_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memeBlocProvider = Provider<MemeBloc>((ref) {
  return MemeBloc();
});

final authBlocProvider = Provider<AuthBloc>((ref) {
  return AuthBloc();
});
