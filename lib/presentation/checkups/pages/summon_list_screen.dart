import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/presentation/checkups/pages/checkup_details.dart';
import 'package:complaintsapp/presentation/checkups/pages/checkup_form_screen.dart';
import 'package:complaintsapp/presentation/checkups/pages/start_checkup_screen.dart';
import 'package:complaintsapp/presentation/checkups/pages/summon_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/utils/routes/routes.dart';

class SummonListScreen extends StatefulWidget {
  @override
  _SummonListScreenState createState() => _SummonListScreenState();
}

class _SummonListScreenState extends State<SummonListScreen> {
  final CheckupStore _checkupStore = getIt<CheckupStore>();

  @override
  void initState() {
    super.initState();
    _loadSummons();
  }

  Future<void> _loadSummons() async {
    await _checkupStore.getMySummons();
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'fined':
        return Colors.orange;
      case 'appealed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'Completed':
        return 'Completed';
      case 'fined':
        return 'Fined';
      case 'appealed':
        return 'Appealed';
      default:
        return 'Unknown';
    }
  }

  Widget _buildSummonCard(Summon summon) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SummonDetailsScreen(summon: summon)));
        },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(summon.status),
                child: Icon(
                  summon.status == 'clean'
                      ? Icons.check
                      : summon.status == 'with_infractions'
                          ? Icons.warning
                          : summon.status == 'pending'
                              ? Icons.timelapse
                              : Icons.cancel,
                  color: Colors.white,
                ),
              ),
              title: Text(
                summon.entreprise?.name ?? 'Unknown Enterprise',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    summon.entreprise?.address ?? 'No address',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Wrap(
                    children: [
                      Text('Code: '),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          '${summon.code}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _getStatusText(summon.status),
                    style: TextStyle(
                      color: _getStatusColor(summon.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Summons'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadSummons,
        child: Observer(
          builder: (context) {
            if (_checkupStore.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_checkupStore.summonList?.summons == null ||
                _checkupStore.summonList!.summons!.isEmpty) {
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
                      'No summons found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8),
                    TextButton.icon(
                      icon: Icon(Icons.refresh),
                      onPressed: _loadSummons,
                      label: Text('Refresh'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: _checkupStore.summonList!.summons!.length,
              itemBuilder: (context, index) {
                final summon = _checkupStore.summonList!.summons![index];
                return _buildSummonCard(summon);
              },
            );
          },
        ),
      ),
    );
  }
}
