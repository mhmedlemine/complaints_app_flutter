import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/core/services/location_service.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/core/widgets/map_location_picker_widget.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
import 'package:complaintsapp/data/sharedpref/constants/preferences.dart';
import 'package:complaintsapp/domain/entity/checkup/picture.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/presentation/shop/entreprise_list.dart';
import 'package:complaintsapp/presentation/shop/search.dart';
import 'package:complaintsapp/presentation/shop/store/shop_store.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/dialogs/dialog_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:complaintsapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class AddEntrepriseScreen extends StatefulWidget {
  @override
  _AddEntrepriseScreenState createState() => _AddEntrepriseScreenState();
}

class _AddEntrepriseScreenState extends State<AddEntrepriseScreen> {
  final LocationService _locationService = LocationService();
  //text controllers:-----------------------------------------------------------
  TextEditingController _codeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _moughataaController = TextEditingController();
  TextEditingController _neighbourhoodController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ownerController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _rgController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final ShopStore _shopStore = getIt<ShopStore>();

  File? _shopPicture;
  bool _clickedOnUpload = false;
  Position? _currentPosition;
  Moughataa? _selectedMoughataa;
  Merchant? _selectedMerchant;
  String? _selectedType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_shopStore.loading) {
      _shopStore.getMoughataas();
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _passwordFocusNode = FocusNode();
  }

  Future<void> _getCurrentLocation() async {
    final position = await _locationService.getCurrentPosition();
    if (position != null) {
      setState(() {
        _currentPosition = position;
        _formStore.setLat(position.latitude);
        _formStore.setLon(position.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('shops_add_shop')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[];
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Center(child: _buildMainContent()),
        Observer(
          builder: (context) {
            return _shopStore.success
                ? navigate(context)
                : _showErrorMessage(_shopStore.errorStore.errorMessage);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _shopStore.loading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              children: [
                Icon(Icons.my_location),
                Text(
                    ' ${AppLocalizations.of(context).translate('shops_current_location')}: '),
                _currentPosition != null
                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                    : CircularProgressIndicator(),
              ],
            ),
            // _currentPosition == null
            //     ? MapLocationPickerLoading()
            //     : MapLocationPicker(
            //         initialPosition: _currentPosition,
            //         onLocationSelected: (location) {
            //           setState(() {
            //             _formStore.setLat(location.latitude);
            //             _formStore.setLon(location.longitude);
            //           });
            //         },
            //       ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('Shop Code: '),
                _formStore.code.isNotEmpty
                    ? Text('${_formStore.code}',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(strokeWidth: 2)),
              ],
            ),
            SizedBox(height: 12),
            _buildMoughataaField(),
            // SizedBox(height: 12),
            // _buildCodeField(),
            SizedBox(height: 12),
            _buildNameField(),
            SizedBox(height: 12),
            _buildNeighbourhoodField(),
            SizedBox(height: 12),
            _buildContactField(),
            SizedBox(height: 12),
            _buildAddressField(),
            SizedBox(height: 12),
            _buildOwnerrField(),
            SizedBox(height: 12),
            _buildTypeField(),
            SizedBox(height: 12),
            _buildRGField(),
            SizedBox(height: 12),
            _buildNotesField(),
            SizedBox(height: 12),
            _buildImageField(),
            SizedBox(height: 8),
            if (_clickedOnUpload && _shopPicture == null)
              Text('Please Upload profile picture',
                  style: TextStyle(color: Colors.red)),
            SizedBox(height: 12),
            _buildSaveButton(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_code'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          enabled: false,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _codeController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setCode(_codeController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.code,
        );
      },
    );
  }

  Widget _buildNameField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_name'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setName(_nameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.name,
        );
      },
    );
  }

  Widget _buildMoughataaField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            final res = await DialogUtils.buildSelectMoughataaDialog(
              context: context,
              title: AppLocalizations.of(context)
                  .translate('shops_select_moughataa'),
              items: _shopStore.moughataaList!.moughataas!,
              selected: _selectedMoughataa?.id ?? 0,
            );
            if (res != null) {
              _selectedMoughataa = res;
              _moughataaController.text = res.name;
              _formStore.setMoughataaId(_selectedMoughataa?.id ?? 0);
              final code = await _shopStore.getEntrepriseCode(res.code);
              setState(() {
                _codeController.text = code;
              });

              _formStore.setCode(_shopStore.entrepriseCode);
            }
          },
          child: TextFieldRoundedWidget(
            hint: AppLocalizations.of(context)
                .translate('shops_select_moughataa'),
            inputType: TextInputType.text,
            //icon: Icons.person,
            iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
            textController: _moughataaController,
            inputAction: TextInputAction.next,
            enabled: false,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setMoughataaId(_selectedMoughataa?.id ?? 0);
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: _formStore.formErrorStore.moughataa_id,
          ),
        );
      },
    );
  }

  Widget _buildNeighbourhoodField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context)
              .translate('shops_enter_neighbourhood'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _neighbourhoodController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setNeighbourhood(_neighbourhoodController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.neighbourhood,
        );
      },
    );
  }

  Widget _buildAddressField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_address'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _addressController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setAddress(_addressController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.address,
        );
      },
    );
  }

  Widget _buildOwnerrField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            final Merchant? res = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => SearchScreen(
                        hintTxt: AppLocalizations.of(context)
                            .translate('shops_enter_merchant_number'))));

            if (res != null) {
              _selectedMerchant = res;
              _ownerController.text = '${res.fname} ${res.lname}';
              _formStore.setOwnerId(_selectedMerchant?.id ?? 0);
            }
          },
          child: TextFieldRoundedWidget(
            hint: AppLocalizations.of(context).translate('shops_select_owner'),
            inputType: TextInputType.text,
            //icon: Icons.person,
            iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
            textController: _ownerController,
            inputAction: TextInputAction.next,
            enabled: false,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setOwnerId(_selectedMerchant?.id ?? 0);
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: _formStore.formErrorStore.owner_id,
          ),
        );
      },
    );
  }

  Widget _buildTypeField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            final res = await DialogUtils.buildSelectItemsDialog(
              context: context,
              title:
                  AppLocalizations.of(context).translate('shops_select_type'),
              items: [
                "Fournisseur ou grossiste",
                "Distributeur ou semi-grossiste",
                "Complexe commercial",
                "Épicerie",
                "Magasin de détail",
                "Boucherie",
                "Pêcherie"
              ],
              selected: _selectedType,
            );
            if (res != null) {
              _selectedType = res;
              _typeController.text = res;
              _formStore.setType(res);
            }
          },
          child: TextFieldRoundedWidget(
            hint: AppLocalizations.of(context).translate('shops_select_type'),
            inputType: TextInputType.text,
            //icon: Icons.person,
            iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
            textController: _typeController,
            inputAction: TextInputAction.next,
            enabled: false,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setType(_typeController.text);
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: _formStore.formErrorStore.type,
          ),
        );
      },
    );
  }

  Widget _buildRGField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_rg'),
          inputType: TextInputType.number,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _rgController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setRg(_rgController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.rg,
        );
      },
    );
  }

  Widget _buildContactField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'Enter Contact Number',
          inputType: TextInputType.phone,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _contactController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_contactController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildNotesField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_notes'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _notesController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setNotes(_notesController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.notes,
        );
      },
    );
  }

  Future<File?> compressImage(File file) async {
    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, lastIndex);
    final outPath = "${splitted}_compressed.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 70,
      minWidth: 1024,
      minHeight: 1024,
    );

    if (result != null) {
      return File(result.path);
    }
    return null;
  }

  Widget _buildImageField() {
    return Observer(
      builder: (context) {
        return ElevatedButton.icon(
          icon: Icon(Icons.add_a_photo),
          label: Text('Shop Picture'),
          onPressed: () async {
            final file = await ImagePicker().pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: CameraDevice.rear,
              // maxWidth: 1080,
              // maxHeight: 1080,
              // imageQuality: 70,
            );
            if (file != null) {
              // final compFile = await compressImage(File(file.path));
              setState(() {
                _shopPicture = File(file.path);
              });
            }
          },
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return RoundedButtonWidget(
      buttonText: _currentPosition == null
          ? '...'
          : AppLocalizations.of(context).translate('shops_add'),
      buttonColor: _currentPosition == null ? Colors.grey : Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () async {
        if (_currentPosition == null) {
          _showErrorMessage(
              AppLocalizations.of(context).translate('shops_location_not_set'));
          return;
        }
        if (_shopPicture == null) {
          setState(() {
            _clickedOnUpload = true;
          });
          _showErrorMessage('Please upload the shop picture');
          return;
        }
        _formStore.validateAll();
        if (_formStore.canSaveEntreprise) {
          DeviceUtils.hideKeyboard(context);
          final entreprise = Entreprise(
            code: _formStore.code,
            name: _formStore.name,
            contact_number: _formStore.phoneNumber,
            moughataa_id: _formStore.moughataa_id,
            owner_id: _formStore.owner_id,
            type: _formStore.type,
            lat: _formStore.lat,
            lon: _formStore.lon,
            rg: _formStore.rg,
            notes: _formStore.notes,
            address: _formStore.address,
            neighbourhood: _formStore.neighbourhood,
            picture_file: _shopPicture,
          );
          try {
            await _shopStore.addEntreprise(entreprise).then((res) {
              _shopStore.getMyEntreprises();
              Navigator.of(context).pop();
            }).catchError((error) {});
          } catch (e) {}
        } else {
          _showErrorMessage(
              AppLocalizations.of(context).translate('shops_data_incomplete'));
        }
      },
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EntrepriseListScreen()));
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('general_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _neighbourhoodController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
