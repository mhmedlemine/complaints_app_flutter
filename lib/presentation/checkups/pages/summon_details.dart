import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SummonDetailsScreen extends StatelessWidget {
  final Summon summon;

  const SummonDetailsScreen({Key? key, required this.summon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('summons_summon_details')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: QrImageView(
                          data: summon.code ?? '${AppLocalizations.of(context).translate('summons_no_code')}',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context).translate('summons_summon_code')}: ${summon.code}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              _buildInfoCard(
                context,
                AppLocalizations.of(context).translate('summons_summon_information'),
                [
                  _buildInfoRow(AppLocalizations.of(context).translate('summons_status'), summon.status ?? AppLocalizations.of(context).translate('summons_not_available')),
                  _buildInfoRow(AppLocalizations.of(context).translate('summons_action'), summon.action ?? AppLocalizations.of(context).translate('summons_not_available')),
                  _buildInfoRow(
                    AppLocalizations.of(context).translate('summons_due_date'),
                    summon.dueDate != null
                        ? DateFormat('MMM dd, yyyy').format(summon.dueDate!)
                        : AppLocalizations.of(context).translate('summons_not_available'),
                  ),
                  _buildInfoRow(
                    AppLocalizations.of(context).translate('summons_filled_on'),
                    summon.filledOn != null
                        ? DateFormat('MMM dd, yyyy').format(summon.filledOn!)
                        : AppLocalizations.of(context).translate('summons_not_available'),
                  ),
                ],
              ),

              SizedBox(height: 16),

              if (summon.entreprise != null)
                _buildInfoCard(
                  context,
                  AppLocalizations.of(context).translate('summons_entreprise_information'),
                  [
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_name'), summon.entreprise?.name ?? AppLocalizations.of(context).translate('summons_not_available')),
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_code'), summon.entreprise?.code ?? AppLocalizations.of(context).translate('summons_not_available')),
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_address'), summon.entreprise?.address ?? AppLocalizations.of(context).translate('summons_not_available')),
                  ],
                ),

              // SizedBox(height: 16),

              // if (summon.agent != null)
              //   _buildInfoCard(
              //     context,
              //     AppLocalizations.of(context).translate('summons_agent_information'),
              //     [
              //       _buildInfoRow(AppLocalizations.of(context).translate('summons_name'), summon.agent?.name ?? AppLocalizations.of(context).translate('summons_not_available')),
              //       _buildInfoRow(AppLocalizations.of(context).translate('summons_agent_phone'), summon.agent?.phonenumber ?? AppLocalizations.of(context).translate('summons_not_available')),
              //     ],
              //   ),

              SizedBox(height: 16),

              if (summon.checkup != null)
                _buildInfoCard(
                  context,
                  AppLocalizations.of(context).translate('summons_checkup_information'),
                  [
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_code'), summon.checkup?.code ?? AppLocalizations.of(context).translate('summons_not_available')),
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_type'), summon.checkup?.type ?? AppLocalizations.of(context).translate('summons_not_available')),
                    if (summon.checkup?.complaint != null) _buildInfoRow(AppLocalizations.of(context).translate('summons_complaint'), summon.checkup?.complaint?.code ?? AppLocalizations.of(context).translate('summons_not_available')),
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_status'), summon.checkup?.status ?? AppLocalizations.of(context).translate('summons_not_available')),
                    if (summon.checkup?.status != 'clean') _buildInfoRow(AppLocalizations.of(context).translate('summons_action'), summon.checkup?.action_taken ?? AppLocalizations.of(context).translate('summons_not_available')),
                    _buildInfoRow(AppLocalizations.of(context).translate('summons_date'), DateFormat('MMM dd, yyyy').format(summon.checkup?.started_at ?? DateTime.now())),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _shareSummonDetails();
        },
        icon: Icon(Icons.share),
        label: Text(AppLocalizations.of(context).translate('summons_share')),
      ),
    );
  }
  
  Widget _buildInfoCard(
      BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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

  Future<void> _shareSummonDetails() async {
  try {
    final qrValidationMessage = '${AppLocalizations.instance.translate('summons_summon_code')}: ${summon.code}\n'
        '${AppLocalizations.instance.translate('summons_due_date')}: ${summon.dueDate != null ? DateFormat('dd/MM/yyyy').format(summon.dueDate!) : AppLocalizations.instance.translate('summons_not_available')}\n'
        '${AppLocalizations.instance.translate('summons_entreprise')}: ${summon.entreprise?.name ?? AppLocalizations.instance.translate('summons_not_available')}\n'
        '${AppLocalizations.instance.translate('summons_entreprise_code')}: ${summon.entreprise?.code ?? AppLocalizations.instance.translate('summons_not_available')}';

    await Share.share(qrValidationMessage);
  } catch (e) {
    print('Error sharing summon details: $e');
  }
}
}
