abstract class Failure {
  final String message;
  final Object? exception;

  const Failure({required this.message, this.exception});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.exception});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection.',
    super.exception,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.exception});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.exception});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized request.',
    super.exception,
  });
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message = 'Access denied.', super.exception});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found.',
    super.exception,
  });
}

class LocationFailure extends Failure {
  const LocationFailure({required super.message, super.exception});
}

class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.exception});
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred.',
    super.exception,
  });
}
