import 'package:compound/models/post.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/views/home_view.dart';
import 'package:compound/ui/views/login_view.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:compound/viewmodels/create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final Post edittingPost;
  CreatePostView({
    Key key,
    this.edittingPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      onModelReady: (model) {
        //update the text in the controller
        titleController.text = edittingPost?.title ?? '';
        model.setEdittingPost(edittingPost);
      },
      builder: (context, model, child) => Scaffold(
          appBar: new AppBar(
            title: Text('Message'),
          ),
          drawer: new Drawer(
              child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title: new Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_back),
                title: new Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
              )
            ],
          )),
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy) {
                model.addPost(title: titleController.text);
              }
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Create Message',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Message',
                  controller: titleController,
                ),
                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}
