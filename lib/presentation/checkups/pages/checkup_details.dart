import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/presentation/checkups/pages/summon_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckupDetailsScreen extends StatelessWidget {
  final Checkup checkup;

  const CheckupDetailsScreen({Key? key, required this.checkup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkup Details'),
        actions: [
          if (checkup.status == 'with_infractions' && checkup.summon != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SummonDetailsScreen(summon: checkup.summon!)));
              },
              child: Text('Show Summon'),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Badge
              _buildStatusBadge(context),
              SizedBox(height: 16),

              // Basic Information Card
              _buildInfoCard(
                context,
                'Checkup Information',
                [
                  _buildInfoRow('Code', checkup.code ?? 'N/A'),
                  _buildInfoRow(
                    'Stared at',
                    checkup.started_at != null
                        ? DateFormat('MMM dd, yyyy HH:mm').format(checkup.started_at!)
                        : 'N/A',
                  ),
                  checkup.status == 'canceled' ?
                  _buildInfoRow(
                    'Canceled at',
                    checkup.canceled_at != null
                        ? DateFormat('MMM dd, yyyy HH:mm').format(checkup.canceled_at!)
                        : 'N/A',
                  ) :
                  _buildInfoRow(
                    'Completed',
                    checkup.completed_at != null
                        ? DateFormat('MMM dd, yyyy HH:mm').format(checkup.completed_at!)
                        : 'N/A',
                  ),
                  _buildInfoRow('Type', _formatCheckupType(checkup.type)),
                  _buildInfoRow('Status', _formatStatus(checkup.status)),
                  if (checkup.status != 'clean' || checkup.action_taken != 'none') _buildInfoRow('Action Taken', _formatActionTaken(checkup.action_taken)),
                ],
              ),

              SizedBox(height: 16),

              // Enterprise Information
              if (checkup.entreprise != null)
                _buildInfoCard(
                  context,
                  'Enterprise Information',
                  [
                    _buildInfoRow('Name', checkup.entreprise?.name ?? 'N/A'),
                    _buildInfoRow('Code', checkup.entreprise?.code ?? 'N/A'),
                    _buildInfoRow('Address', checkup.entreprise?.address ?? 'N/A'),
                  ],
                ),

              SizedBox(height: 16),

              // Agent Information
              if (checkup.agent != null)
                _buildInfoCard(
                  context,
                  'Agent Information',
                  [
                    _buildInfoRow('Name', checkup.agent?.name ?? 'N/A'),
                    _buildInfoRow('Phone', checkup.agent?.phonenumber ?? 'N/A'),
                  ],
                ),

              SizedBox(height: 16),

              // Complaint Information (if exists)
              if (checkup.complaint != null)
                _buildInfoCard(
                  context,
                  'Related Complaint',
                  [
                    _buildInfoRow('Complaint Code', '${checkup.complaint?.code}'),
                    _buildInfoRow('Status', checkup.complaint?.status ?? 'N/A'),
                    if (checkup.complaint?.description != null)
                      _buildInfoRow('Description', checkup.complaint!.description!),
                  ],
                ),

              SizedBox(height: 16),

              // Infractions Section
              if (checkup.checkupInfractions?.checkup_infractions?.isNotEmpty ?? false)
                _buildInfractionsCard(context),

              SizedBox(height: 16),

              // Notes Section
              if (checkup.notes?.isNotEmpty ?? false)
                _buildInfoCard(
                  context,
                  'Notes',
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(checkup.notes!),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color backgroundColor;
    IconData icon;
    String text;

    switch (checkup.status) {
      case 'clean':
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        text = 'Clean';
        break;
      case 'with_infractions':
        backgroundColor = Colors.red;
        icon = Icons.warning;
        text = 'Infractions Found';
        break;
      case 'pending':
        backgroundColor = Colors.orange;
        icon = Icons.pending;
        text = 'Pending';
        break;
      default:
        backgroundColor = Colors.grey;
        icon = Icons.help;
        text = 'Unknown';
    }

    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfractionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Infractions Found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: checkup.checkupInfractions?.checkup_infractions?.length ?? 0,
              itemBuilder: (context, index) {
                final infraction = checkup.checkupInfractions!.checkup_infractions![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(
                      infraction.infraction?.label ?? infraction.custom_infraction_text ?? 'No Label',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: infraction.notes?.isNotEmpty ?? false
                        ? Text(infraction.notes!)
                        : null,
                    leading: Icon(Icons.warning, color: Colors.red),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCheckupType(String? type) {
    if (type == null) return 'N/A';
    return type.substring(0, 1).toUpperCase() + type.substring(1);
  }

  String _formatStatus(String? status) {
    if (status == null) return 'N/A';
    return status.replaceAll('_', ' ').toUpperCase();
  }

  String _formatActionTaken(String? action) {
    if (action == null) return 'N/A';
    return action;
  }
}