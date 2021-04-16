import 'package:share/share.dart';

class ShareService {
  Future<void> share(String content) {
    return Share.share(content, subject: 'Compartilhe com o seu parceiro');
  }
}