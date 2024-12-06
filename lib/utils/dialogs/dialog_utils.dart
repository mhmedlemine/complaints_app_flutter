import 'package:complaintsapp/core/domain/enums.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';
import 'package:complaintsapp/presentation/home/store/language/language_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:complaintsapp/constants/assets.dart';
import 'package:complaintsapp/constants/strings.dart';
import 'package:complaintsapp/data/sharedpref/constants/preferences.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';

class DialogUtils {
    static Future<ImageSource?> buildImagePickerDialog(BuildContext context) async {
  return showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'dialog_select_image_source',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: ImageSource.values
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(
                    object == ImageSource.camera
                        ? Icons.camera_alt
                        : Icons.picture_in_picture_outlined,
                  ),
                  title: Text(
                    '${Strings.imageSources[object.index]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(object);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
  

  static buildLanguageDialog({
  required BuildContext context,
  required LanguageStore languageStore,
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        AppLocalizations.of(context).translate('general_pick_language'),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16.0,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: languageStore.supportedLanguages
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: SvgPicture.asset(
                    object.flag!,
                    height: object.flag!.contains('mauritania')
                        ? MediaQuery.of(context).size.height * 0.035
                        : MediaQuery.of(context).size.height * 0.05,
                  ),
                  title: Text(
                    object.language!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: languageStore.locale == object.locale
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    languageStore.changeLanguage(object.locale!);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}

  
static Future<String?> buildSelectEnumDialog({
  required BuildContext context,
  required String title,
  required List<dynamic> values,
  String? selected,
}) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: values
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(
                    object.toString().split('.').last == selected
                        ? Icons.check_circle_outline_outlined
                        : Icons.circle_outlined,
                    color: object.toString().split('.').last == selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    AppLocalizations.of(context)
                        .translate(object.toString().split('.').last),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: object.toString().split('.').last == selected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(object.toString().split('.').last);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
  
static Future<int?> buildSelectDialog({
  required BuildContext context,
  required String title,
  required LanguageStore languageStore,
  int? selected,
}) async {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: GenderType.values
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(
                    object.index == selected
                        ? Icons.check_circle_outline_outlined
                        : Icons.circle_outlined,
                    color: object.index == selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    AppLocalizations.of(context)
                        .translate(Strings.genders[object.index]),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: object.index == selected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(object.index);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
  
static Future<int?> buildSelectBirthYearDialog({
  required BuildContext context,
  required String title,
  int startYear = 100,
  int endYear = 18,
  int? selected,
}) async {
  List<int> years = [];
  final currentYear = DateTime.now().year;
  for (int year = currentYear - endYear;
      year > currentYear - startYear;
      year--) {
    years.add(year);
  }

  return showDialog<int>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: years
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(
                    object == selected
                        ? Icons.check_circle_outline_outlined
                        : Icons.circle_outlined,
                    color: object == selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    '$object',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: object == selected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(object);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
  
static Future<String?> buildSelectItemsDialog({
  required BuildContext context,
  required String title,
  required List items,
  String? selected,
}) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: items
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(
                    object == selected
                        ? Icons.check_circle_outline_outlined
                        : Icons.circle_outlined,
                    color: object == selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    '$object',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: object == selected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(object);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
  
static Future<dynamic> buildSelectMoughataaDialog({
  required BuildContext context,
  required String title,
  required List<Moughataa> items,
  int? selected,
}) async {
  return showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: items
              .map(
                (object) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(
                    object.id == selected
                        ? Icons.check_circle_outline_outlined
                        : Icons.circle_outlined,
                    color: object.id == selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    '${object.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: object.id == selected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(object);
                  },
                ),
              )
              .toList(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            AppLocalizations.of(context).translate('general_close'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
  
  static buildLanguageBottomsheet({
    required BuildContext context,
    required LanguageStore languageStore,
    required TickerProvider vsync,
  }) async {
    return await showModalBottomSheet<String?>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      transitionAnimationController: AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: vsync,
      ),
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 8,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: MediaQuery.of(context).size.width * .4,
              ),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.all(const Radius.circular(25)),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).translate('general_pick_language'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: languageStore.supportedLanguages
                    .map(
                      (object) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        trailing: languageStore.locale == object.locale
                            ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : Icon(
                                Icons.circle_outlined,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        leading: SvgPicture.asset(
                          object.flag!,
                          height: object.flag!.contains('mauritania')
                              ? MediaQuery.of(context).size.height * 0.035
                              : MediaQuery.of(context).size.height * 0.05,
                        ),
                        title: Text(
                          object.language!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: languageStore.locale == object.locale
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(object.locale);
                          // change user language based on selected locale
                          languageStore.changeLanguage(object.locale!);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

static Future<bool?> buildSetPasswordDialog({
  required BuildContext context,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        AppLocalizations.instance.translate('dialog_set_password_title'),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              AppLocalizations.instance.translate('dialog_set_password_message'),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.instance.translate('dialog_method_simple'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(AppLocalizations.instance.translate('dialog_reset_pw_step_one')),
            Text(AppLocalizations.instance.translate('dialog_reset_pw_step_two')),
            Text(AppLocalizations.instance.translate('dialog_reset_pw_step_three')),
            Text(AppLocalizations.instance.translate('dialog_reset_pw_step_four')),
            Text(AppLocalizations.instance.translate('dialog_reset_pw_step_five')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.instance.translate('general_ok')),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );
}
  
static Future<bool?> buildNewUserDialog({
  required BuildContext context,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        AppLocalizations.instance.translate('dialog_new_user_title'),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              AppLocalizations.instance.translate('dialog_new_user_message'),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.instance.translate('dialog_reset_pw_step_one'),
            ),
            Text(
              AppLocalizations.instance.translate('dialog_reset_pw_step_two'),
            ),
            Text(AppLocalizations.instance.translate('dialog_reset_pw_step_three')),
            Text(AppLocalizations.instance.translate('dialog_new_user_step_four')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.instance.translate('general_cancel'),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.instance.translate('general_ok')),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );
}
  
static Future<bool?> buildActionDialog({
  required BuildContext context,
  required String confirmBtnText,
  required String cancelBtnText,
  required String title,
  required String msg,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: Text(msg),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelBtnText),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmBtnText),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );
}
  
static Future<bool?> buildForceUpdateDialog({
  required BuildContext context,
  required void Function()? onUpdate,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        '${AppLocalizations.of(context).translate('dialog_new_version_available')}',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: Text(
        '${AppLocalizations.of(context).translate('dialog_required_update_message')}',
      ),
      actions: [
        ElevatedButton(
          onPressed: onUpdate,
          child: Text(
            '${AppLocalizations.of(context).translate('dialog_update_now')}',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );
}
 
static Future<bool?> buildOptionalUpdateDialog({
  required BuildContext context,
  required void Function()? onLater,
  required void Function()? onIgnore,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        '${AppLocalizations.of(context).translate('dialog_new_version_available')}',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: Text(
        '${AppLocalizations.of(context).translate('dialog_optional_update_message')}',
      ),
      actions: [
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, .2),
          child: TextButton(
            onPressed: onIgnore,
            child: Text(
              '${AppLocalizations.of(context).translate('general_ignore')}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, .2),
          child: TextButton(
            onPressed: onLater,
            child: Text(
              '${AppLocalizations.of(context).translate('general_later')}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, .3),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              '${AppLocalizations.of(context).translate('dialog_update_now')}',
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );
}
 
 static Future buildInfoDialog({
  required BuildContext context,
  required String title,
  required String msg,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: Text(msg),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.instance.translate('general_ok')),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );
}

  
  static _showDialog<T>({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  static Future<T?> _showDialogAsync<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => child,
    );
  }
}
