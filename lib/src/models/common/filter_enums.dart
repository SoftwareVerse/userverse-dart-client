enum MatchType {
  partial,
  exact,
  startsWith; // Dart enums use camelCase for values if they are identifiers

  factory MatchType.fromJson(String value) {
    switch (value) {
      case 'partial':
        return MatchType.partial;
      case 'exact':
        return MatchType.exact;
      case 'starts_with':
        return MatchType.startsWith;
      default:
        // Or throw an error, or return a default
        return MatchType.partial; 
    }
  }

  String toJson() {
    switch (this) {
      case MatchType.partial:
        return 'partial';
      case MatchType.exact:
        return 'exact';
      case MatchType.startsWith:
        return 'starts_with';
    }
  }
}


enum FilterLogic {
  or,
  and;

  factory FilterLogic.fromJson(String value) {
    switch (value) {
      case 'or':
        return FilterLogic.or;
      case 'and':
        return FilterLogic.and;
      default:
        return FilterLogic.or; // Or throw
    }
  }

  String toJson() {
    switch (this) {
      case FilterLogic.or:
        return 'or';
      case FilterLogic.and:
        return 'and';
    }
  }
}