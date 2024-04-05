// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ques_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionHistoryCollection on Isar {
  IsarCollection<QuestionHistory> get questionHistorys => this.collection();
}

const QuestionHistorySchema = CollectionSchema(
  name: r'QuestionHistory',
  id: -3974275998434714466,
  properties: {
    r'imgPath': PropertySchema(
      id: 0,
      name: r'imgPath',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 1,
      name: r'time',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 2,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _questionHistoryEstimateSize,
  serialize: _questionHistorySerialize,
  deserialize: _questionHistoryDeserialize,
  deserializeProp: _questionHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'imgPath': IndexSchema(
      id: -4414049710633896366,
      name: r'imgPath',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'imgPath',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'time': IndexSchema(
      id: -2250472054110640942,
      name: r'time',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'time',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _questionHistoryGetId,
  getLinks: _questionHistoryGetLinks,
  attach: _questionHistoryAttach,
  version: '3.1.0+1',
);

int _questionHistoryEstimateSize(
  QuestionHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.imgPath.length * 3;
  return bytesCount;
}

void _questionHistorySerialize(
  QuestionHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imgPath);
  writer.writeDateTime(offsets[1], object.time);
  writer.writeLong(offsets[2], object.userId);
}

QuestionHistory _questionHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionHistory(
    imgPath: reader.readString(offsets[0]),
    time: reader.readDateTime(offsets[1]),
    userId: reader.readLong(offsets[2]),
  );
  object.id = id;
  return object;
}

P _questionHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionHistoryGetId(QuestionHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionHistoryGetLinks(QuestionHistory object) {
  return [];
}

void _questionHistoryAttach(
    IsarCollection<dynamic> col, Id id, QuestionHistory object) {
  object.id = id;
}

extension QuestionHistoryByIndex on IsarCollection<QuestionHistory> {
  Future<QuestionHistory?> getByImgPath(String imgPath) {
    return getByIndex(r'imgPath', [imgPath]);
  }

  QuestionHistory? getByImgPathSync(String imgPath) {
    return getByIndexSync(r'imgPath', [imgPath]);
  }

  Future<bool> deleteByImgPath(String imgPath) {
    return deleteByIndex(r'imgPath', [imgPath]);
  }

  bool deleteByImgPathSync(String imgPath) {
    return deleteByIndexSync(r'imgPath', [imgPath]);
  }

  Future<List<QuestionHistory?>> getAllByImgPath(List<String> imgPathValues) {
    final values = imgPathValues.map((e) => [e]).toList();
    return getAllByIndex(r'imgPath', values);
  }

  List<QuestionHistory?> getAllByImgPathSync(List<String> imgPathValues) {
    final values = imgPathValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'imgPath', values);
  }

  Future<int> deleteAllByImgPath(List<String> imgPathValues) {
    final values = imgPathValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'imgPath', values);
  }

  int deleteAllByImgPathSync(List<String> imgPathValues) {
    final values = imgPathValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'imgPath', values);
  }

  Future<Id> putByImgPath(QuestionHistory object) {
    return putByIndex(r'imgPath', object);
  }

  Id putByImgPathSync(QuestionHistory object, {bool saveLinks = true}) {
    return putByIndexSync(r'imgPath', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByImgPath(List<QuestionHistory> objects) {
    return putAllByIndex(r'imgPath', objects);
  }

  List<Id> putAllByImgPathSync(List<QuestionHistory> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'imgPath', objects, saveLinks: saveLinks);
  }

  Future<QuestionHistory?> getByTime(DateTime time) {
    return getByIndex(r'time', [time]);
  }

  QuestionHistory? getByTimeSync(DateTime time) {
    return getByIndexSync(r'time', [time]);
  }

  Future<bool> deleteByTime(DateTime time) {
    return deleteByIndex(r'time', [time]);
  }

  bool deleteByTimeSync(DateTime time) {
    return deleteByIndexSync(r'time', [time]);
  }

  Future<List<QuestionHistory?>> getAllByTime(List<DateTime> timeValues) {
    final values = timeValues.map((e) => [e]).toList();
    return getAllByIndex(r'time', values);
  }

  List<QuestionHistory?> getAllByTimeSync(List<DateTime> timeValues) {
    final values = timeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'time', values);
  }

  Future<int> deleteAllByTime(List<DateTime> timeValues) {
    final values = timeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'time', values);
  }

  int deleteAllByTimeSync(List<DateTime> timeValues) {
    final values = timeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'time', values);
  }

  Future<Id> putByTime(QuestionHistory object) {
    return putByIndex(r'time', object);
  }

  Id putByTimeSync(QuestionHistory object, {bool saveLinks = true}) {
    return putByIndexSync(r'time', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTime(List<QuestionHistory> objects) {
    return putAllByIndex(r'time', objects);
  }

  List<Id> putAllByTimeSync(List<QuestionHistory> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'time', objects, saveLinks: saveLinks);
  }
}

extension QuestionHistoryQueryWhereSort
    on QueryBuilder<QuestionHistory, QuestionHistory, QWhere> {
  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhere> anyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'time'),
      );
    });
  }
}

extension QuestionHistoryQueryWhere
    on QueryBuilder<QuestionHistory, QuestionHistory, QWhereClause> {
  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      imgPathEqualTo(String imgPath) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'imgPath',
        value: [imgPath],
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      imgPathNotEqualTo(String imgPath) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imgPath',
              lower: [],
              upper: [imgPath],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imgPath',
              lower: [imgPath],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imgPath',
              lower: [imgPath],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imgPath',
              lower: [],
              upper: [imgPath],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause> timeEqualTo(
      DateTime time) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'time',
        value: [time],
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      timeNotEqualTo(DateTime time) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'time',
              lower: [],
              upper: [time],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'time',
              lower: [time],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'time',
              lower: [time],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'time',
              lower: [],
              upper: [time],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      timeGreaterThan(
    DateTime time, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'time',
        lower: [time],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause>
      timeLessThan(
    DateTime time, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'time',
        lower: [],
        upper: [time],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterWhereClause> timeBetween(
    DateTime lowerTime,
    DateTime upperTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'time',
        lower: [lowerTime],
        includeLower: includeLower,
        upper: [upperTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestionHistoryQueryFilter
    on QueryBuilder<QuestionHistory, QuestionHistory, QFilterCondition> {
  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imgPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imgPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imgPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imgPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imgPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imgPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imgPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imgPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imgPath',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      imgPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imgPath',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      timeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      timeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      timeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      timeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      userIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterFilterCondition>
      userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestionHistoryQueryObject
    on QueryBuilder<QuestionHistory, QuestionHistory, QFilterCondition> {}

extension QuestionHistoryQueryLinks
    on QueryBuilder<QuestionHistory, QuestionHistory, QFilterCondition> {}

extension QuestionHistoryQuerySortBy
    on QueryBuilder<QuestionHistory, QuestionHistory, QSortBy> {
  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> sortByImgPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imgPath', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy>
      sortByImgPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imgPath', Sort.desc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy>
      sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension QuestionHistoryQuerySortThenBy
    on QueryBuilder<QuestionHistory, QuestionHistory, QSortThenBy> {
  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> thenByImgPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imgPath', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy>
      thenByImgPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imgPath', Sort.desc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy>
      thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension QuestionHistoryQueryWhereDistinct
    on QueryBuilder<QuestionHistory, QuestionHistory, QDistinct> {
  QueryBuilder<QuestionHistory, QuestionHistory, QDistinct> distinctByImgPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imgPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QDistinct> distinctByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time');
    });
  }

  QueryBuilder<QuestionHistory, QuestionHistory, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension QuestionHistoryQueryProperty
    on QueryBuilder<QuestionHistory, QuestionHistory, QQueryProperty> {
  QueryBuilder<QuestionHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestionHistory, String, QQueryOperations> imgPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imgPath');
    });
  }

  QueryBuilder<QuestionHistory, DateTime, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<QuestionHistory, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
