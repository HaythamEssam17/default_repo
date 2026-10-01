#!/bin/bash

# Exit on error
set -e

# Check for feature name
if [ -z "$1" ]; then
  echo "❌ Error: You must provide a feature name"
  echo "Usage: sh generate_feature.sh feature_name"
  exit 1
fi

FEATURE_RAW="$1"

# normalize to lowercase for folder names
FEATURE=$(echo "$FEATURE_RAW" | tr '[:upper:]' '[:lower:]')

# FEATURE_DIR: path used for filesystem (e.g., auth/splash)
FEATURE_DIR="$FEATURE"

# FEATURE_NAME: last segment (e.g., splash)
FEATURE_NAME="${FEATURE_DIR##*/}"

# CAP_FEATURE: PascalCase merged from all segments (e.g., AuthSplash)
# replace separators with space, capitalize each word, then remove spaces
CAP_FEATURE=$(echo "$FEATURE_DIR" | sed 's/[\/_-]/ /g' | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1' OFS='' )

echo "FEATURE RAW: [$FEATURE_RAW]"
echo "FEATURE NORMALIZED: [$FEATURE_DIR]"
echo "FEATURE NAME (file base): [$FEATURE_NAME]"
echo "CAP_FEATURE: [${CAP_FEATURE}Model]"

FEATURE_ROOT="lib/features/$FEATURE_DIR"

echo "🚀 Creating feature: $FEATURE_DIR"

# Data layer directories
mkdir -p "$FEATURE_ROOT/data/models"
mkdir -p "$FEATURE_ROOT/data/repositories"
mkdir -p "$FEATURE_ROOT/data/ds"
mkdir -p "$FEATURE_ROOT/data/ds/remote"

# Domain layer
mkdir -p "$FEATURE_ROOT/domain/entities"
mkdir -p "$FEATURE_ROOT/domain/repositories"
mkdir -p "$FEATURE_ROOT/domain/usecases"

# Presentation layer
mkdir -p "$FEATURE_ROOT/presentation/bloc"
mkdir -p "$FEATURE_ROOT/presentation/pages"
mkdir -p "$FEATURE_ROOT/presentation/widgets"

# DI Layer
mkdir -p "$FEATURE_ROOT/di"

# Create files (use FEATURE_NAME for filenames so we don't embed slashes)
touch "$FEATURE_ROOT/data/ds/remote/${FEATURE_NAME}_remote_ds.dart"
touch "$FEATURE_ROOT/data/ds/remote/${FEATURE_NAME}_remote_ds_impl.dart"
touch "$FEATURE_ROOT/data/models/${FEATURE_NAME}_model.dart"
touch "$FEATURE_ROOT/data/repositories/${FEATURE_NAME}_repo_impl.dart"
touch "$FEATURE_ROOT/domain/entities/${FEATURE_NAME}_entity.dart"
touch "$FEATURE_ROOT/domain/repositories/${FEATURE_NAME}_repository.dart"
touch "$FEATURE_ROOT/domain/usecases/${FEATURE_NAME}_usecase.dart"
touch "$FEATURE_ROOT/presentation/bloc/${FEATURE_NAME}_cubit.dart"
touch "$FEATURE_ROOT/presentation/bloc/${FEATURE_NAME}_states.dart"
touch "$FEATURE_ROOT/presentation/pages/${FEATURE_NAME}_home_page.dart"
touch "$FEATURE_ROOT/di/${FEATURE_NAME}_module.dart"

######################################
# data layer templates
######################################

cat <<EOF > "$FEATURE_ROOT/data/models/${FEATURE_NAME}_model.dart"
import '../../domain/entities/${FEATURE_NAME}_entity.dart';

class ${CAP_FEATURE}Model extends ${CAP_FEATURE}Entity {
  const ${CAP_FEATURE}Model();

  factory ${CAP_FEATURE}Model.fromJson(Map<String, dynamic> json) {
    return ${CAP_FEATURE}Model();
  }

  Map<String, dynamic> toJson() => {};
}
EOF

cat <<EOF > "$FEATURE_ROOT/data/ds/remote/${FEATURE_NAME}_remote_ds.dart"
abstract class ${CAP_FEATURE}RemoteDataSource {
  Future<void> fetchData();
}
EOF

cat <<EOF > "$FEATURE_ROOT/data/ds/remote/${FEATURE_NAME}_remote_ds_impl.dart"
import '${FEATURE_NAME}_remote_ds.dart';

class ${CAP_FEATURE}RemoteDataSourceImpl implements ${CAP_FEATURE}RemoteDataSource {
  @override
  Future<void> fetchData() async {
    // TODO: implement remote logic
  }
}
EOF

# cat <<EOF > "$FEATURE_ROOT/data/ds/local/local_${FEATURE_NAME}_ds.dart"
# abstract class Local${CAP_FEATURE}DataSource {
#   Future<void> cacheData();
# }
# EOF

# cat <<EOF > "$FEATURE_ROOT/data/ds/local/local_${FEATURE_NAME}_ds_impl.dart"
# import 'local_${FEATURE_NAME}_ds.dart';

# class Local${CAP_FEATURE}DataSourceImpl implements Local${CAP_FEATURE}DataSource {
#   @override
#   Future<void> cacheData() async {
#     // TODO: implement local caching
#   }
# }
# EOF

cat <<EOF > "$FEATURE_ROOT/data/repositories/${FEATURE_NAME}_repo_impl.dart"
import '../../domain/repositories/${FEATURE_NAME}_repository.dart';
import '../ds/remote/${FEATURE_NAME}_remote_ds.dart';

class ${CAP_FEATURE}RepositoryImpl implements ${CAP_FEATURE}Repository {
  final ${CAP_FEATURE}RemoteDataSource remote;

  ${CAP_FEATURE}RepositoryImpl(this.remote);

  @override
  Future<void> doSomething() async {
    await remote.fetchData();
  }
}
EOF

######################################
# domain layer templates
######################################

cat <<EOF > "$FEATURE_ROOT/domain/entities/${FEATURE_NAME}_entity.dart"
class ${CAP_FEATURE}Entity {
  const ${CAP_FEATURE}Entity();
}
EOF

cat <<EOF > "$FEATURE_ROOT/domain/repositories/${FEATURE_NAME}_repository.dart"
abstract class ${CAP_FEATURE}Repository {
  Future<void> doSomething();
}
EOF

cat <<EOF > "$FEATURE_ROOT/domain/usecases/${FEATURE_NAME}_usecase.dart"
import '../repositories/${FEATURE_NAME}_repository.dart';

class ${CAP_FEATURE}UseCase {
  final ${CAP_FEATURE}Repository repository;

  ${CAP_FEATURE}UseCase(this.repository);

  Future<void> doSomething() async {
    return repository.doSomething();
  }
}
EOF

######################################
# presentation layer templates
######################################

cat <<EOF > "$FEATURE_ROOT/presentation/bloc/${FEATURE_NAME}_states.dart"
abstract class ${CAP_FEATURE}State {}

class ${CAP_FEATURE}Initial extends ${CAP_FEATURE}State {}

class ${CAP_FEATURE}Loading extends ${CAP_FEATURE}State {}

class ${CAP_FEATURE}Success extends ${CAP_FEATURE}State {}

class ${CAP_FEATURE}Error extends ${CAP_FEATURE}State {
  final String message;
  ${CAP_FEATURE}Error(this.message);
}
EOF

cat <<EOF > "$FEATURE_ROOT/presentation/bloc/${FEATURE_NAME}_cubit.dart"
import 'package:flutter_bloc/flutter_bloc.dart';
import '${FEATURE_NAME}_states.dart';
import '../../domain/usecases/${FEATURE_NAME}_usecase.dart';

class ${CAP_FEATURE}Cubit extends Cubit<${CAP_FEATURE}State> {
  final ${CAP_FEATURE}UseCase useCase;

  ${CAP_FEATURE}Cubit(this.useCase) : super(${CAP_FEATURE}Initial());
}
EOF

cat <<EOF > "$FEATURE_ROOT/presentation/pages/${FEATURE_NAME}_home_page.dart"
import 'package:flutter/material.dart';

class ${CAP_FEATURE}HomePage extends StatelessWidget {
  const ${CAP_FEATURE}HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome to ${CAP_FEATURE} feature"),
      ),
    );
  }
}
EOF


cat <<EOF > "$FEATURE_ROOT/di/${FEATURE_NAME}_module.dart"
import 'package:get_it/get_it.dart';

import '../domain/repositories/${FEATURE_NAME}_repository.dart';
import '../data/repositories/${FEATURE_NAME}_repo_impl.dart';
import '../data/ds/remote/${FEATURE_NAME}_remote_ds.dart';
import '../data/ds/remote/${FEATURE_NAME}_remote_ds_impl.dart';
import '../domain/usecases/${FEATURE_NAME}_usecase.dart';
import '../presentation/bloc/${FEATURE_NAME}_cubit.dart';

void ${FEATURE_NAME}Module(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<${CAP_FEATURE}RemoteDataSource>(
    () => ${CAP_FEATURE}RemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<${CAP_FEATURE}Repository>(
    () => ${CAP_FEATURE}RepositoryImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => ${CAP_FEATURE}UseCase(sl()));

  // Bloc
  sl.registerLazySingleton(
    () => ${CAP_FEATURE}Cubit(sl()),
  );
}
EOF

echo "🎉 Feature '$FEATURE_DIR' generated successfully!"