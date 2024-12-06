import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/checkups/pages/checkup_details.dart';
import 'package:complaintsapp/presentation/checkups/pages/checkup_form_screen.dart';
import 'package:complaintsapp/presentation/checkups/pages/start_checkup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/utils/routes/routes.dart';

class CheckupListScreen extends StatefulWidget {
  @override
  _CheckupListScreenState createState() => _CheckupListScreenState();
}

class _CheckupListScreenState extends State<CheckupListScreen> {
  final CheckupStore _checkupStore = getIt<CheckupStore>();

  @override
  void initState() {
    super.initState();
    _loadCheckups();
  }

  Future<void> _loadCheckups() async {
    await _checkupStore.getMyCheckups();
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'in_progress':
        return Colors.blue;
      case 'clean':
        return Colors.green;
      case 'with_infractions':
        return Colors.red;
      case 'canceled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'in_progress':
        return 'In Progress';
      case 'clean':
        return 'Clean';
      case 'with_infractions':
        return 'With Infractions';
      case 'canceled':
        return 'Canceled';
      default:
        return 'Unknown';
    }
  }

  Widget _buildCheckupCard(Checkup checkup) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          if (checkup.status == 'in_progress') {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CheckupFormScreen(checkup: checkup)));
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CheckupDetailsScreen(checkup: checkup)));
          }
        },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(checkup.status),
                child: Icon(
                  checkup.status == 'clean' ? Icons.check :
                  checkup.status == 'with_infractions' ? Icons.warning :
                  checkup.status == 'in_progress' ? Icons.timelapse :
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
              title: Text(
                checkup.entreprise?.name ?? 'Unknown Enterprise',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                checkup.entreprise?.address ?? 'No address',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _getStatusText(checkup.status),
                    style: TextStyle(
                      color: _getStatusColor(checkup.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: Text(
                      checkup.code ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (checkup.status == 'with_infractions' && 
                checkup.checkupInfractions?.checkup_infractions != null)...[
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.grey[300], ),
                    Text(
                      'Infractions: ${checkup.checkupInfractions!.checkup_infractions!.length}',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (checkup.summon != null)
                      Text(
                        'Summon: ${checkup.summon!.code}',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Checkups'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {

            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadCheckups,
        child: Observer(
          builder: (context) {
            if (_checkupStore.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_checkupStore.checkupList?.checkups == null || 
                _checkupStore.checkupList!.checkups!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No checkups found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start a new checkup to see it here',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: _checkupStore.checkupList!.checkups!.length,
              itemBuilder: (context, index) {
                final checkup = _checkupStore.checkupList!.checkups![index];
                return _buildCheckupCard(checkup);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
        tooltip: 'Start New Checkup',
      ),
    );
  }
}