import 'package:complaintsapp/core/widgets/status_badge_widget.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckupListItem extends StatelessWidget {
  final Checkup checkup;
  final VoidCallback onTap;

  const CheckupListItem({
    Key? key,
    required this.checkup,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (checkup.status?.toLowerCase()) {
      case 'in_progress':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade900;
        displayText = 'In Progress';
        break;
      case 'clean':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade900;
        displayText = 'Clean';
        break;
      case 'with_infractions':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade900;
        displayText = 'With Infractions';
        break;
      case 'canceled':
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade900;
        displayText = 'Canceled';
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade900;
        displayText = '${checkup.status}';
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context).translate('checkups_code')}: ${checkup.code}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  StatusBadge(
                    status: '${checkup.status}',
                    backgroundColor: backgroundColor,
                    textColor: textColor,
                    displayText: displayText,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.business, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${checkup.entreprise?.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  if (checkup.started_at != null) 
                  Text(
                    DateFormat('dd/MM/yyyy').format(checkup.started_at!),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              if (checkup.notes != null && checkup.notes!.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  checkup.notes!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
