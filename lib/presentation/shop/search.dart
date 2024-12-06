import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/presentation/shop/add_merchant.dart';
import 'package:complaintsapp/presentation/shop/store/shop_store.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchScreen extends StatefulWidget {
  final String? hintTxt;

  const SearchScreen({
    Key? key,
    this.hintTxt,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ShopStore _shopStore = getIt<ShopStore>();

  late TextEditingController _queryTextController;
  AutocompleteResponse? _response;
  String? _error;
  bool _searching = false;
  Timer? _debounce;
  final _queryBehavior = BehaviorSubject<String>.seeded('');

  @override
  void initState() {
    super.initState();
    _queryTextController = TextEditingController();
    _queryTextController.addListener(_onQueryChange);
    _queryBehavior.stream.listen(doSearch);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      toolbarHeight: MediaQuery.of(context).size.height * .1,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      elevation: 0,
      leadingWidth: MediaQuery.of(context).size.width * 0,
      leading: SizedBox.shrink(),
      title: Container(
        height: MediaQuery.of(context).size.height * .07,
        margin: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _response = null;
                  _error = null;
                  _queryTextController.text = '';
                });
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.chevron_left_outlined,
                size: MediaQuery.of(context).size.width * .1,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .72,
              child: TextFormField(
                controller: _queryTextController,
                autofocus: true,
                keyboardType: TextInputType.phone,
                maxLength: 8,
                decoration: InputDecoration(
                  hintText: widget.hintTxt ??
                      AppLocalizations.of(context).translate('shops_enter_merchant_phone_number'),
                  errorText: null,
                  counterText: '',
                  border: InputBorder.none,
                ),
                onChanged: (String value) {
                  if (value.trim().isEmpty) {
                    setState(() {
                      _queryTextController.text = value;
                      _response = null;
                    });
                  }
                },
              ),
            ),
            if (_queryTextController.text.isNotEmpty)
              InkWell(
                onTap: () {
                  _queryTextController.clear();
                  setState(() {
                    _response = null;
                  });
                },
                child: Icon(
                  Icons.close,
                  size: MediaQuery.of(context).size.width * .06,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_response == null && _error != null) {
      return _showErrorMessage(_error ?? '');
    } else if (_queryTextController.text.isEmpty || _response == null) {
      final children = <Widget>[];
      if (_searching) {
        children.add(
          LinearProgressIndicator(backgroundColor: Colors.grey[100]),
        );
      }
      return Stack(children: children);
    } else if (_queryTextController.text.isNotEmpty &&
        _response!.suggestions.isEmpty) {
      return Stack(
        children: [
          if (_queryTextController.text.length == 8) ... [
            ListTile(
              onTap: () async {
                final phoneNumber = _queryTextController.text;
                setState(() {
                  _queryTextController.text = '';
                  _response = null;
                  _error = null;
                });
                final res = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddMerchantScreen(phoneNumber: phoneNumber)));
                if (res != null) {
                  Navigator.of(context).pop(res);
                }
              },
              minLeadingWidth: 8,
              leading: Icon(Icons.person),
              title: Text('${_queryTextController.text}'),
              subtitle: Text(AppLocalizations.of(context).translate('shops_merchant_does_not_exist'), style: TextStyle(color: Colors.red),),
              trailing: Icon(Icons.add),
            ),
          ] else ... [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_off,
                    size: MediaQuery.of(context).size.width * .2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_queryTextController.text} ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //SizedBox(width: 4),
                      Text(AppLocalizations.of(context).translate('shops_not_found')),
                    ],
                  ),
                ],
              ),
            ),
          ],
          if (_searching) ...[
            LinearProgressIndicator(backgroundColor: Colors.grey[100]),
          ],
        ],
      );
    }
    return Stack(
      children: [
        ListView.builder(
          itemCount: _response!.suggestions.length > 5
              ? 5
              : _response!.suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = _response?.suggestions[index];
            return Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    _queryTextController.text = '';
                    _response = null;
                    _error = null;
                  });
                  Navigator.of(context).pop(suggestion);
                },
                minLeadingWidth: 8,
                leading: Icon(Icons.person),
                title: Text('${suggestion?.fname} ${suggestion?.lname}'),
                subtitle: Text('${suggestion?.phoneNumber}'),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            );
          },
        ),
        if (_searching)
          LinearProgressIndicator(backgroundColor: Colors.grey[100]),
      ],
    );
  }

  Widget _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('general_error'),
            duration: Duration(seconds: 3),
          )..show(context);
          setState(() {
            _error = null;
          });
        }
      });
    }

    return SizedBox.shrink();
  }

  Future<void> doSearch(String value) async {
    if (mounted && value.length > 1) {
      setState(() {
        _searching = true;
      });

      final merchants = await _shopStore.getMerchant(value);

      final response = AutocompleteResponse(
        error: _shopStore.errorStore.errorMessage,
        errorDescription: _shopStore.errorStore.errorMessage,
        suggestions: merchants ?? [],
      );

      if (response.error?.isNotEmpty == true) {
        onResponseError(response);
      } else {
        onResponse(response);
      }
    }
  }

  @mustCallSuper
  void onResponseError(AutocompleteResponse res) {
    if (!mounted) return;

    setState(() {
      _response = null;
      _searching = false;
      _error = res.error;
    });
  }

  @mustCallSuper
  void onResponse(res) {
    if (!mounted) return;

    setState(() {
      _response = res;
      _searching = false;
      _error = null;
    });
  }

  void _onQueryChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () {
      try {
        _queryBehavior.add(_queryTextController.text);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _queryBehavior.close();
    _queryTextController.removeListener(_onQueryChange);
  }
}

class AutocompleteResponse {
  final String? error;
  final String? errorDescription;
  final List<Merchant> suggestions;

  AutocompleteResponse({
    this.error,
    this.errorDescription,
    required this.suggestions,
  });

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) {
    final suggestionsJson = json['suggestions'] as List;
    final suggestions = <Merchant>[];
    suggestionsJson.asMap().forEach((key, value) {
      suggestions.add(value);
    });

    return AutocompleteResponse(
      error: json['error'] as String,
      errorDescription: json['error_description'] as String,
      suggestions: suggestions,
    );
  }
}
