import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/resources/meme_repository.dart';
import 'package:rxdart/rxdart.dart';

class MemeBloc {
  //observable
  final _memestream = BehaviorSubject<List<Memes>>();

  //getter
  Stream<List<Memes>> get memes => _memestream.stream;

  MemeRepository _repository = MemeRepository();

  void getMemes() async {
    final event = await _repository.getMeme();
    if (event != null) _memestream.sink.add(event);
  }

  Future<bool> postMeme(Memes meme) async {
    final bool event = await _repository.postMeme(meme);
    if (event) {
      getMemes();
    }
    return event;
    // _memestream.sink.add(event);
  }

  Future<bool> editMeme(Memes meme) async {
    final event = await _repository.editMeme(meme);
    if (event) {
      getMemes();
    }
    return event;
  }

  void dispose() {
    _memestream.close();
  }
}
