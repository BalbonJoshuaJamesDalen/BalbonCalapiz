import 'package:compound/locator.dart';
import 'package:compound/models/post.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Post _edittingPost;
  bool get _editting => _edittingPost != null;

  Future addPost({@required String title}) async {
    setBusy(true);
    var result;
    if (!_editting) {
      result = await _firestoreService
          .addPost(Post(title: title, userId: currentUser.id));
    } else {
      result = await _firestoreService.updatePost(Post(
          title: title,
          userId: _edittingPost.userId,
          documentId: _edittingPost.documentId));
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create message',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Message Successfully Added',
        description: 'Your message has been created',
      );
    }
    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
