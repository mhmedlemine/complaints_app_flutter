// import 'package:another_flushbar/flushbar_helper.dart';
// import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
// import 'package:complaintsapp/di/service_locator.dart';
// import 'package:complaintsapp/presentation/complaints/add_complaint.dart';
// import 'package:complaintsapp/presentation/post/store/post_store.dart';
// import 'package:complaintsapp/utils/locale/app_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';

// class ComplaintListScreen extends StatefulWidget {
//   @override
//   _ComplaintListScreenState createState() => _ComplaintListScreenState();
// }

// class _ComplaintListScreenState extends State<ComplaintListScreen> {

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // check to see if already called api
//     // if (!_postStore.loading) {
//     //   _postStore.getPosts();
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   // app bar methods:-----------------------------------------------------------
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       title: Text('Mes Plaintes'),
//       actions: _buildActions(context),
//     );
//   }

//   List<Widget> _buildActions(BuildContext context) {
//     return <Widget>[
//       _buildAddButton(),
//     ];
//   }

//   Widget _buildAddButton() {
//     return Observer(
//       builder: (context) {
//         return TextButton.icon(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddComplaintScreen()));
//           },
//           label: Text('Ajouter'),
//           icon: Icon(Icons.add),
//         );
//       },
//     );
//   }

//   // body methods:--------------------------------------------------------------
//   Widget _buildBody() {
//     return Stack(
//       children: <Widget>[
//         _handleErrorMessage(),
//         _buildMainContent(),
//       ],
//     );
//   }

//   Widget _buildMainContent() {
//     return Observer(
//       builder: (context) {
//         return _postStore.loading
//             ? CustomProgressIndicatorWidget()
//             : _buildListView();
//       },
//     );
//   }

//   Widget _buildListView() {
//     return _postStore.postList != null
//         ? ListView.separated(
//             itemCount: _postStore.postList!.posts!.length,
//             separatorBuilder: (context, position) {
//               return Divider();
//             },
//             itemBuilder: (context, position) {
//               return _buildListItem(position);
//             },
//           )
//         : Center(
//             child: Text(
//               AppLocalizations.of(context).translate('home_tv_no_post_found'),
//             ),
//           );
//   }

//   Widget _buildListItem(int position) {
//     return ListTile(
//       dense: true,
//       leading: Icon(Icons.cloud_circle),
//       title: Text(
//         '${_postStore.postList?.posts?[position].title}',
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         softWrap: false,
//         style: Theme.of(context).textTheme.titleMedium,
//       ),
//       subtitle: Text(
//         '${_postStore.postList?.posts?[position].body}',
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         softWrap: false,
//       ),
//     );
//   }

//   Widget _handleErrorMessage() {
//     return Observer(
//       builder: (context) {
//         if (_postStore.errorStore.errorMessage.isNotEmpty) {
//           return _showErrorMessage(_postStore.errorStore.errorMessage);
//         }

//         return SizedBox.shrink();
//       },
//     );
//   }

//   // General Methods:-----------------------------------------------------------
//   _showErrorMessage(String message) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       if (message.isNotEmpty) {
//         FlushbarHelper.createError(
//           message: message,
//           title: AppLocalizations.of(context).translate('home_tv_error'),
//           duration: Duration(seconds: 3),
//         )..show(context);
//       }
//     });

//     return SizedBox.shrink();
//   }
// }
