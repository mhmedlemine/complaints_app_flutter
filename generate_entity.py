import os
import sys
from pathlib import Path

def create_file(path, content):
  os.makedirs(os.path.dirname(path), exist_ok=True)
  with open(path, 'w') as f:
      f.write(content)
  print(f"Created: {path}")

def append_to_file(path, content):
  with open(path, 'a') as f:
      f.write(content)
  print(f"Updated: {path}")

def generate_entity(feature_name):
  feature_name_lower = feature_name.lower()
  base_dir = "lib"
  # 1. Generate Entity
  entity_content = f'''class {feature_name} {{
  final String id;
  final String name;

  {feature_name}({{
      required this.id,
      required this.name,
  }});

  factory {feature_name}.fromJson(Map<String, dynamic> json) {{
      return {feature_name}(
          id: json['id'] as String,
          name: json['name'] as String,
      );
  }}

  Map<String, dynamic> toJson() {{
      return {{
          'id': id,
          'name': name,
      }};
  }}
}}
'''

def generate_feature(feature_name):
  feature_name_lower = feature_name.lower()
  base_dir = "lib"

  # 1. Generate Entity
  entity_content = f'''class {feature_name} {{
  final String id;
  final String name;

  {feature_name}({{
      required this.id,
      required this.name,
  }});

  factory {feature_name}.fromJson(Map<String, dynamic> json) {{
      return {feature_name}(
          id: json['id'] as String,
          name: json['name'] as String,
      );
  }}

  Map<String, dynamic> toJson() {{
      return {{
          'id': id,
          'name': name,
      }};
  }}
}}
'''

  # 2. Generate Repository Interface
  repository_interface_content = f'''import '../entity/{feature_name_lower}.dart';

abstract class {feature_name}Repository {{
  Future<List<{feature_name}>> getAll();
  Future<{feature_name}> getById(String id);
  Future<void> create({feature_name} {feature_name_lower});
  Future<void> update({feature_name} {feature_name_lower});
  Future<void> delete(String id);
}}
'''

  # 3. Generate API
  api_content = f'''import '../dio_client.dart';

class {feature_name}Api {{
  final DioClient _dioClient;

  {feature_name}Api(this._dioClient);

  Future<List<Map<String, dynamic>>> getAll() async {{
      final response = await _dioClient.get('/{feature_name_lower}s');
      return List<Map<String, dynamic>>.from(response.data);
  }}

  Future<Map<String, dynamic>> getById(String id) async {{
      final response = await _dioClient.get('/{feature_name_lower}s/$id');
      return response.data;
  }}

  Future<void> create(Map<String, dynamic> data) async {{
      await _dioClient.post('/{feature_name_lower}s', data: data);
  }}

  Future<void> update(Map<String, dynamic> data) async {{
      await _dioClient.put('/{feature_name_lower}s/${{data['id']}}', data: data);
  }}

  Future<void> delete(String id) async {{
      await _dioClient.delete('/{feature_name_lower}s/$id');
  }}
}}
'''

  # 4. Network Module Registration
  network_module_registration = f'''
static {feature_name}Api provide{feature_name}Api() {{
  return {feature_name}Api(provideDioClient());
}}'''

  # 5. Generate Repository Implementation
  repository_impl_content = f'''import '../../domain/entity/{feature_name_lower}.dart';
import '../../domain/repository/{feature_name_lower}_repository.dart';
import '../network/apis/{feature_name_lower}_api.dart';

class {feature_name}RepositoryImpl implements {feature_name}Repository {{
  final {feature_name}Api _{feature_name_lower}Api;

  {feature_name}RepositoryImpl(this._{feature_name_lower}Api);

  @override
  Future<List<{feature_name}>> getAll() async {{
      final response = await _{feature_name_lower}Api.getAll();
      return response.map((json) => {feature_name}.fromJson(json)).toList();
  }}

  @override
  Future<{feature_name}> getById(String id) async {{
      final response = await _{feature_name_lower}Api.getById(id);
      return {feature_name}.fromJson(response);
  }}

  @override
  Future<void> create({feature_name} {feature_name_lower}) async {{
      await _{feature_name_lower}Api.create({feature_name_lower}.toJson());
  }}

  @override
  Future<void> update({feature_name} {feature_name_lower}) async {{
      await _{feature_name_lower}Api.update({feature_name_lower}.toJson());
  }}

  @override
  Future<void> delete(String id) async {{
      await _{feature_name_lower}Api.delete(id);
  }}
}}
'''

  # 6. Repository Module Registration
  repository_module_registration = f'''
static {feature_name}Repository provide{feature_name}Repository() {{
  return {feature_name}RepositoryImpl(NetworkModule.provide{feature_name}Api());
}}'''

  # 7. Generate Use Cases
  usecase_content = f'''import '../../entity/{feature_name_lower}.dart';
import '../../repository/{feature_name_lower}_repository.dart';
import '../use_case.dart';

class Get{feature_name}UseCase implements UseCase<List<{feature_name}>, void> {{
  final {feature_name}Repository _{feature_name_lower}Repository;

  Get{feature_name}UseCase(this._{feature_name_lower}Repository);

  @override
  Future<List<{feature_name}>> call([void params]) {{
      return _{feature_name_lower}Repository.getAll();
  }}
}}
'''

  # 8. Use Case Module Registration
  usecase_module_registration = f'''
static Get{feature_name}UseCase provideGet{feature_name}UseCase() {{
  return Get{feature_name}UseCase(RepositoryModule.provide{feature_name}Repository());
}}'''

  # 9. Generate Store
  store_content = f'''import 'package:mobx/mobx.dart';

import '../../../domain/entity/{feature_name_lower}.dart';
import '../../../domain/usecase/{feature_name_lower}/get_{feature_name_lower}_usecase.dart';

part '{feature_name_lower}_store.g.dart';

class {feature_name}Store = _{feature_name}Store with _${feature_name}Store;

abstract class _{feature_name}Store with Store {{
  final Get{feature_name}UseCase _get{feature_name}UseCase;

  _{feature_name}Store(this._get{feature_name}UseCase);

  @observable
  ObservableList<{feature_name}> items = ObservableList<{feature_name}>();

  @observable
  bool isLoading = false;

  @action
  Future<void> getAll() async {{
      isLoading = true;
      try {{
          final result = await _get{feature_name}UseCase();
          items = ObservableList.of(result);
      }} finally {{
          isLoading = false;
      }}
  }}
}}
'''

  # 10. Generate Screen
  screen_content = f'''import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/{feature_name_lower}_store.dart';

class {feature_name}ListScreen extends StatefulWidget {{
  @override
  _${feature_name}ListScreenState createState() => _${feature_name}ListScreenState();
}}

class _${feature_name}ListScreenState extends State<{feature_name}ListScreen> {{
  final {feature_name}Store _store = {feature_name}Store(/* inject dependencies */);

  @override
  void initState() {{
      super.initState();
      _store.getAll();
  }}

  @override
  Widget build(BuildContext context) {{
      return Scaffold(
          appBar: AppBar(
              title: Text('{feature_name} List'),
          ),
          body: Observer(
              builder: (_) {{
                  if (_store.isLoading) {{
                      return Center(child: CircularProgressIndicator());
                  }}

                  return ListView.builder(
                      itemCount: _store.items.length,
                      itemBuilder: (context, index) {{
                          final item = _store.items[index];
                          return ListTile(
                              title: Text(item.name),
                          );
                      }},
                  );
              }},
          ),
      );
  }}
}}
'''

  # Create all the necessary files
  files_to_create = {
      f"{base_dir}/domain/entity/{feature_name_lower}.dart": entity_content,
      f"{base_dir}/domain/repository/{feature_name_lower}_repository.dart": repository_interface_content,
      f"{base_dir}/data/network/apis/{feature_name_lower}_api.dart": api_content,
      f"{base_dir}/data/repository/{feature_name_lower}_repository_impl.dart": repository_impl_content,
      f"{base_dir}/domain/usecase/{feature_name_lower}/get_{feature_name_lower}_usecase.dart": usecase_content,
      f"{base_dir}/presentation/{feature_name_lower}/store/{feature_name_lower}_store.dart": store_content,
      f"{base_dir}/presentation/{feature_name_lower}/pages/{feature_name_lower}_list_screen.dart": screen_content,
  }

  # Create files
  for path, content in files_to_create.items():
      create_file(path, content)

  # Update module files
  module_updates = {
      f"{base_dir}/data/di/module/network_module.dart": network_module_registration,
      f"{base_dir}/data/di/module/repository_module.dart": repository_module_registration,
      f"{base_dir}/domain/di/module/usecase_module.dart": usecase_module_registration,
  }

  for path, content in module_updates.items():
      append_to_file(path, content)

if __name__ == "__main__":
  if len(sys.argv) != 2:
      print("Usage: python generate_feature.py FeatureName")
      sys.exit(1)

  feature_name = sys.argv[1]
  generate_feature(feature_name)

# Created/Modified files during execution:
print("\nThe following files were created/modified:")
for file in [
  f"lib/domain/entity/{sys.argv[1].lower()}.dart",
  f"lib/domain/repository/{sys.argv[1].lower()}_repository.dart",
  f"lib/data/network/apis/{sys.argv[1].lower()}_api.dart",
  f"lib/data/repository/{sys.argv[1].lower()}_repository_impl.dart",
  f"lib/domain/usecase/{sys.argv[1].lower()}/get_{sys.argv[1].lower()}_usecase.dart",
  f"lib/presentation/{sys.argv[1].lower()}/store/{sys.argv[1].lower()}_store.dart",
  f"lib/presentation/{sys.argv[1].lower()}/pages/{sys.argv[1].lower()}_list_screen.dart",
  "lib/data/di/module/network_module.dart",
  "lib/data/di/module/repository_module.dart",
  "lib/domain/di/module/usecase_module.dart"
]:
  print(file)