// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pixiv_web_models.dart';

class WebTitleCaptionTranslationMapper
    extends ClassMapperBase<WebTitleCaptionTranslation> {
  WebTitleCaptionTranslationMapper._();

  static WebTitleCaptionTranslationMapper? _instance;
  static WebTitleCaptionTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebTitleCaptionTranslationMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'WebTitleCaptionTranslation';

  static String? _$workTitle(WebTitleCaptionTranslation v) => v.workTitle;
  static const Field<WebTitleCaptionTranslation, String> _f$workTitle = Field(
    'workTitle',
    _$workTitle,
    opt: true,
  );
  static String? _$workCaption(WebTitleCaptionTranslation v) => v.workCaption;
  static const Field<WebTitleCaptionTranslation, String> _f$workCaption = Field(
    'workCaption',
    _$workCaption,
    opt: true,
  );

  @override
  final MappableFields<WebTitleCaptionTranslation> fields = const {
    #workTitle: _f$workTitle,
    #workCaption: _f$workCaption,
  };

  static WebTitleCaptionTranslation _instantiate(DecodingData data) {
    return WebTitleCaptionTranslation(
      workTitle: data.dec(_f$workTitle),
      workCaption: data.dec(_f$workCaption),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebTitleCaptionTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebTitleCaptionTranslation>(map);
  }

  static WebTitleCaptionTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<WebTitleCaptionTranslation>(json);
  }
}

mixin WebTitleCaptionTranslationMappable {
  String toJson() {
    return WebTitleCaptionTranslationMapper.ensureInitialized()
        .encodeJson<WebTitleCaptionTranslation>(
          this as WebTitleCaptionTranslation,
        );
  }

  Map<String, dynamic> toMap() {
    return WebTitleCaptionTranslationMapper.ensureInitialized()
        .encodeMap<WebTitleCaptionTranslation>(
          this as WebTitleCaptionTranslation,
        );
  }

  WebTitleCaptionTranslationCopyWith<
    WebTitleCaptionTranslation,
    WebTitleCaptionTranslation,
    WebTitleCaptionTranslation
  >
  get copyWith =>
      _WebTitleCaptionTranslationCopyWithImpl<
        WebTitleCaptionTranslation,
        WebTitleCaptionTranslation
      >(this as WebTitleCaptionTranslation, $identity, $identity);
  @override
  String toString() {
    return WebTitleCaptionTranslationMapper.ensureInitialized().stringifyValue(
      this as WebTitleCaptionTranslation,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebTitleCaptionTranslationMapper.ensureInitialized().equalsValue(
      this as WebTitleCaptionTranslation,
      other,
    );
  }

  @override
  int get hashCode {
    return WebTitleCaptionTranslationMapper.ensureInitialized().hashValue(
      this as WebTitleCaptionTranslation,
    );
  }
}

extension WebTitleCaptionTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebTitleCaptionTranslation, $Out> {
  WebTitleCaptionTranslationCopyWith<$R, WebTitleCaptionTranslation, $Out>
  get $asWebTitleCaptionTranslation => $base.as(
    (v, t, t2) => _WebTitleCaptionTranslationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebTitleCaptionTranslationCopyWith<
  $R,
  $In extends WebTitleCaptionTranslation,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? workTitle, String? workCaption});
  WebTitleCaptionTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebTitleCaptionTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebTitleCaptionTranslation, $Out>
    implements
        WebTitleCaptionTranslationCopyWith<
          $R,
          WebTitleCaptionTranslation,
          $Out
        > {
  _WebTitleCaptionTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebTitleCaptionTranslation> $mapper =
      WebTitleCaptionTranslationMapper.ensureInitialized();
  @override
  $R call({Object? workTitle = $none, Object? workCaption = $none}) => $apply(
    FieldCopyWithData({
      if (workTitle != $none) #workTitle: workTitle,
      if (workCaption != $none) #workCaption: workCaption,
    }),
  );
  @override
  WebTitleCaptionTranslation $make(CopyWithData data) =>
      WebTitleCaptionTranslation(
        workTitle: data.get(#workTitle, or: $value.workTitle),
        workCaption: data.get(#workCaption, or: $value.workCaption),
      );

  @override
  WebTitleCaptionTranslationCopyWith<$R2, WebTitleCaptionTranslation, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebTitleCaptionTranslationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDiscoveryIllustMapper extends ClassMapperBase<WebDiscoveryIllust> {
  WebDiscoveryIllustMapper._();

  static WebDiscoveryIllustMapper? _instance;
  static WebDiscoveryIllustMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDiscoveryIllustMapper._());
      WebTitleCaptionTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebDiscoveryIllust';

  static String _$id(WebDiscoveryIllust v) => v.id;
  static const Field<WebDiscoveryIllust, String> _f$id = Field('id', _$id);
  static String _$title(WebDiscoveryIllust v) => v.title;
  static const Field<WebDiscoveryIllust, String> _f$title = Field(
    'title',
    _$title,
  );
  static int _$illustType(WebDiscoveryIllust v) => v.illustType;
  static const Field<WebDiscoveryIllust, int> _f$illustType = Field(
    'illustType',
    _$illustType,
    opt: true,
    def: 0,
  );
  static int _$xRestrict(WebDiscoveryIllust v) => v.xRestrict;
  static const Field<WebDiscoveryIllust, int> _f$xRestrict = Field(
    'xRestrict',
    _$xRestrict,
    opt: true,
    def: 0,
  );
  static int _$restrict(WebDiscoveryIllust v) => v.restrict;
  static const Field<WebDiscoveryIllust, int> _f$restrict = Field(
    'restrict',
    _$restrict,
    opt: true,
    def: 0,
  );
  static int _$sl(WebDiscoveryIllust v) => v.sl;
  static const Field<WebDiscoveryIllust, int> _f$sl = Field(
    'sl',
    _$sl,
    opt: true,
    def: 0,
  );
  static String _$url(WebDiscoveryIllust v) => v.url;
  static const Field<WebDiscoveryIllust, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static String _$description(WebDiscoveryIllust v) => v.description;
  static const Field<WebDiscoveryIllust, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static List<String> _$tags(WebDiscoveryIllust v) => v.tags;
  static const Field<WebDiscoveryIllust, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
    def: const [],
  );
  static String? _$userId(WebDiscoveryIllust v) => v.userId;
  static const Field<WebDiscoveryIllust, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
  );
  static String? _$userName(WebDiscoveryIllust v) => v.userName;
  static const Field<WebDiscoveryIllust, String> _f$userName = Field(
    'userName',
    _$userName,
    opt: true,
  );
  static int _$width(WebDiscoveryIllust v) => v.width;
  static const Field<WebDiscoveryIllust, int> _f$width = Field(
    'width',
    _$width,
    opt: true,
    def: 0,
  );
  static int _$height(WebDiscoveryIllust v) => v.height;
  static const Field<WebDiscoveryIllust, int> _f$height = Field(
    'height',
    _$height,
    opt: true,
    def: 0,
  );
  static int _$pageCount(WebDiscoveryIllust v) => v.pageCount;
  static const Field<WebDiscoveryIllust, int> _f$pageCount = Field(
    'pageCount',
    _$pageCount,
    opt: true,
    def: 0,
  );
  static bool _$isBookmarkable(WebDiscoveryIllust v) => v.isBookmarkable;
  static const Field<WebDiscoveryIllust, bool> _f$isBookmarkable = Field(
    'isBookmarkable',
    _$isBookmarkable,
    opt: true,
    def: false,
  );
  static dynamic _$bookmarkData(WebDiscoveryIllust v) => v.bookmarkData;
  static const Field<WebDiscoveryIllust, dynamic> _f$bookmarkData = Field(
    'bookmarkData',
    _$bookmarkData,
    opt: true,
  );
  static String? _$alt(WebDiscoveryIllust v) => v.alt;
  static const Field<WebDiscoveryIllust, String> _f$alt = Field(
    'alt',
    _$alt,
    opt: true,
  );
  static WebTitleCaptionTranslation? _$titleCaptionTranslation(
    WebDiscoveryIllust v,
  ) => v.titleCaptionTranslation;
  static const Field<WebDiscoveryIllust, WebTitleCaptionTranslation>
  _f$titleCaptionTranslation = Field(
    'titleCaptionTranslation',
    _$titleCaptionTranslation,
    opt: true,
  );
  static String? _$createDate(WebDiscoveryIllust v) => v.createDate;
  static const Field<WebDiscoveryIllust, String> _f$createDate = Field(
    'createDate',
    _$createDate,
    opt: true,
  );
  static String? _$updateDate(WebDiscoveryIllust v) => v.updateDate;
  static const Field<WebDiscoveryIllust, String> _f$updateDate = Field(
    'updateDate',
    _$updateDate,
    opt: true,
  );
  static bool _$isUnlisted(WebDiscoveryIllust v) => v.isUnlisted;
  static const Field<WebDiscoveryIllust, bool> _f$isUnlisted = Field(
    'isUnlisted',
    _$isUnlisted,
    opt: true,
    def: false,
  );
  static bool _$isMasked(WebDiscoveryIllust v) => v.isMasked;
  static const Field<WebDiscoveryIllust, bool> _f$isMasked = Field(
    'isMasked',
    _$isMasked,
    opt: true,
    def: false,
  );
  static int _$aiType(WebDiscoveryIllust v) => v.aiType;
  static const Field<WebDiscoveryIllust, int> _f$aiType = Field(
    'aiType',
    _$aiType,
    opt: true,
    def: 0,
  );
  static int _$visibilityScope(WebDiscoveryIllust v) => v.visibilityScope;
  static const Field<WebDiscoveryIllust, int> _f$visibilityScope = Field(
    'visibilityScope',
    _$visibilityScope,
    opt: true,
    def: 0,
  );
  static Map<String, String> _$urls(WebDiscoveryIllust v) => v.urls;
  static const Field<WebDiscoveryIllust, Map<String, String>> _f$urls = Field(
    'urls',
    _$urls,
    opt: true,
    def: const {},
  );
  static String? _$profileImageUrl(WebDiscoveryIllust v) => v.profileImageUrl;
  static const Field<WebDiscoveryIllust, String> _f$profileImageUrl = Field(
    'profileImageUrl',
    _$profileImageUrl,
    opt: true,
  );

  @override
  final MappableFields<WebDiscoveryIllust> fields = const {
    #id: _f$id,
    #title: _f$title,
    #illustType: _f$illustType,
    #xRestrict: _f$xRestrict,
    #restrict: _f$restrict,
    #sl: _f$sl,
    #url: _f$url,
    #description: _f$description,
    #tags: _f$tags,
    #userId: _f$userId,
    #userName: _f$userName,
    #width: _f$width,
    #height: _f$height,
    #pageCount: _f$pageCount,
    #isBookmarkable: _f$isBookmarkable,
    #bookmarkData: _f$bookmarkData,
    #alt: _f$alt,
    #titleCaptionTranslation: _f$titleCaptionTranslation,
    #createDate: _f$createDate,
    #updateDate: _f$updateDate,
    #isUnlisted: _f$isUnlisted,
    #isMasked: _f$isMasked,
    #aiType: _f$aiType,
    #visibilityScope: _f$visibilityScope,
    #urls: _f$urls,
    #profileImageUrl: _f$profileImageUrl,
  };

  static WebDiscoveryIllust _instantiate(DecodingData data) {
    return WebDiscoveryIllust(
      data.dec(_f$id),
      data.dec(_f$title),
      illustType: data.dec(_f$illustType),
      xRestrict: data.dec(_f$xRestrict),
      restrict: data.dec(_f$restrict),
      sl: data.dec(_f$sl),
      url: data.dec(_f$url),
      description: data.dec(_f$description),
      tags: data.dec(_f$tags),
      userId: data.dec(_f$userId),
      userName: data.dec(_f$userName),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
      pageCount: data.dec(_f$pageCount),
      isBookmarkable: data.dec(_f$isBookmarkable),
      bookmarkData: data.dec(_f$bookmarkData),
      alt: data.dec(_f$alt),
      titleCaptionTranslation: data.dec(_f$titleCaptionTranslation),
      createDate: data.dec(_f$createDate),
      updateDate: data.dec(_f$updateDate),
      isUnlisted: data.dec(_f$isUnlisted),
      isMasked: data.dec(_f$isMasked),
      aiType: data.dec(_f$aiType),
      visibilityScope: data.dec(_f$visibilityScope),
      urls: data.dec(_f$urls),
      profileImageUrl: data.dec(_f$profileImageUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebDiscoveryIllust fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDiscoveryIllust>(map);
  }

  static WebDiscoveryIllust fromJson(String json) {
    return ensureInitialized().decodeJson<WebDiscoveryIllust>(json);
  }
}

mixin WebDiscoveryIllustMappable {
  String toJson() {
    return WebDiscoveryIllustMapper.ensureInitialized()
        .encodeJson<WebDiscoveryIllust>(this as WebDiscoveryIllust);
  }

  Map<String, dynamic> toMap() {
    return WebDiscoveryIllustMapper.ensureInitialized()
        .encodeMap<WebDiscoveryIllust>(this as WebDiscoveryIllust);
  }

  WebDiscoveryIllustCopyWith<
    WebDiscoveryIllust,
    WebDiscoveryIllust,
    WebDiscoveryIllust
  >
  get copyWith =>
      _WebDiscoveryIllustCopyWithImpl<WebDiscoveryIllust, WebDiscoveryIllust>(
        this as WebDiscoveryIllust,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebDiscoveryIllustMapper.ensureInitialized().stringifyValue(
      this as WebDiscoveryIllust,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDiscoveryIllustMapper.ensureInitialized().equalsValue(
      this as WebDiscoveryIllust,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDiscoveryIllustMapper.ensureInitialized().hashValue(
      this as WebDiscoveryIllust,
    );
  }
}

extension WebDiscoveryIllustValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDiscoveryIllust, $Out> {
  WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, $Out>
  get $asWebDiscoveryIllust => $base.as(
    (v, t, t2) => _WebDiscoveryIllustCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebDiscoveryIllustCopyWith<
  $R,
  $In extends WebDiscoveryIllust,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  WebTitleCaptionTranslationCopyWith<
    $R,
    WebTitleCaptionTranslation,
    WebTitleCaptionTranslation
  >?
  get titleCaptionTranslation;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>> get urls;
  $R call({
    String? id,
    String? title,
    int? illustType,
    int? xRestrict,
    int? restrict,
    int? sl,
    String? url,
    String? description,
    List<String>? tags,
    String? userId,
    String? userName,
    int? width,
    int? height,
    int? pageCount,
    bool? isBookmarkable,
    dynamic bookmarkData,
    String? alt,
    WebTitleCaptionTranslation? titleCaptionTranslation,
    String? createDate,
    String? updateDate,
    bool? isUnlisted,
    bool? isMasked,
    int? aiType,
    int? visibilityScope,
    Map<String, String>? urls,
    String? profileImageUrl,
  });
  WebDiscoveryIllustCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebDiscoveryIllustCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDiscoveryIllust, $Out>
    implements WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, $Out> {
  _WebDiscoveryIllustCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDiscoveryIllust> $mapper =
      WebDiscoveryIllustMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags =>
      ListCopyWith(
        $value.tags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tags: v),
      );
  @override
  WebTitleCaptionTranslationCopyWith<
    $R,
    WebTitleCaptionTranslation,
    WebTitleCaptionTranslation
  >?
  get titleCaptionTranslation => $value.titleCaptionTranslation?.copyWith
      .$chain((v) => call(titleCaptionTranslation: v));
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
  get urls => MapCopyWith(
    $value.urls,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(urls: v),
  );
  @override
  $R call({
    String? id,
    String? title,
    int? illustType,
    int? xRestrict,
    int? restrict,
    int? sl,
    String? url,
    String? description,
    List<String>? tags,
    Object? userId = $none,
    Object? userName = $none,
    int? width,
    int? height,
    int? pageCount,
    bool? isBookmarkable,
    Object? bookmarkData = $none,
    Object? alt = $none,
    Object? titleCaptionTranslation = $none,
    Object? createDate = $none,
    Object? updateDate = $none,
    bool? isUnlisted,
    bool? isMasked,
    int? aiType,
    int? visibilityScope,
    Map<String, String>? urls,
    Object? profileImageUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (illustType != null) #illustType: illustType,
      if (xRestrict != null) #xRestrict: xRestrict,
      if (restrict != null) #restrict: restrict,
      if (sl != null) #sl: sl,
      if (url != null) #url: url,
      if (description != null) #description: description,
      if (tags != null) #tags: tags,
      if (userId != $none) #userId: userId,
      if (userName != $none) #userName: userName,
      if (width != null) #width: width,
      if (height != null) #height: height,
      if (pageCount != null) #pageCount: pageCount,
      if (isBookmarkable != null) #isBookmarkable: isBookmarkable,
      if (bookmarkData != $none) #bookmarkData: bookmarkData,
      if (alt != $none) #alt: alt,
      if (titleCaptionTranslation != $none)
        #titleCaptionTranslation: titleCaptionTranslation,
      if (createDate != $none) #createDate: createDate,
      if (updateDate != $none) #updateDate: updateDate,
      if (isUnlisted != null) #isUnlisted: isUnlisted,
      if (isMasked != null) #isMasked: isMasked,
      if (aiType != null) #aiType: aiType,
      if (visibilityScope != null) #visibilityScope: visibilityScope,
      if (urls != null) #urls: urls,
      if (profileImageUrl != $none) #profileImageUrl: profileImageUrl,
    }),
  );
  @override
  WebDiscoveryIllust $make(CopyWithData data) => WebDiscoveryIllust(
    data.get(#id, or: $value.id),
    data.get(#title, or: $value.title),
    illustType: data.get(#illustType, or: $value.illustType),
    xRestrict: data.get(#xRestrict, or: $value.xRestrict),
    restrict: data.get(#restrict, or: $value.restrict),
    sl: data.get(#sl, or: $value.sl),
    url: data.get(#url, or: $value.url),
    description: data.get(#description, or: $value.description),
    tags: data.get(#tags, or: $value.tags),
    userId: data.get(#userId, or: $value.userId),
    userName: data.get(#userName, or: $value.userName),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
    pageCount: data.get(#pageCount, or: $value.pageCount),
    isBookmarkable: data.get(#isBookmarkable, or: $value.isBookmarkable),
    bookmarkData: data.get(#bookmarkData, or: $value.bookmarkData),
    alt: data.get(#alt, or: $value.alt),
    titleCaptionTranslation: data.get(
      #titleCaptionTranslation,
      or: $value.titleCaptionTranslation,
    ),
    createDate: data.get(#createDate, or: $value.createDate),
    updateDate: data.get(#updateDate, or: $value.updateDate),
    isUnlisted: data.get(#isUnlisted, or: $value.isUnlisted),
    isMasked: data.get(#isMasked, or: $value.isMasked),
    aiType: data.get(#aiType, or: $value.aiType),
    visibilityScope: data.get(#visibilityScope, or: $value.visibilityScope),
    urls: data.get(#urls, or: $value.urls),
    profileImageUrl: data.get(#profileImageUrl, or: $value.profileImageUrl),
  );

  @override
  WebDiscoveryIllustCopyWith<$R2, WebDiscoveryIllust, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebDiscoveryIllustCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebRecommendedIllustMapper extends ClassMapperBase<WebRecommendedIllust> {
  WebRecommendedIllustMapper._();

  static WebRecommendedIllustMapper? _instance;
  static WebRecommendedIllustMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebRecommendedIllustMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebRecommendedIllust';

  static String _$illustId(WebRecommendedIllust v) => v.illustId;
  static const Field<WebRecommendedIllust, String> _f$illustId = Field(
    'illustId',
    _$illustId,
  );
  static List<String> _$recommendMethods(WebRecommendedIllust v) =>
      v.recommendMethods;
  static const Field<WebRecommendedIllust, List<String>> _f$recommendMethods =
      Field('recommendMethods', _$recommendMethods, opt: true, def: const []);
  static double _$recommendScore(WebRecommendedIllust v) => v.recommendScore;
  static const Field<WebRecommendedIllust, double> _f$recommendScore = Field(
    'recommendScore',
    _$recommendScore,
    opt: true,
    def: 0,
  );
  static List<int> _$recommendSeedIllustIds(WebRecommendedIllust v) =>
      v.recommendSeedIllustIds;
  static const Field<WebRecommendedIllust, List<int>>
  _f$recommendSeedIllustIds = Field(
    'recommendSeedIllustIds',
    _$recommendSeedIllustIds,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<WebRecommendedIllust> fields = const {
    #illustId: _f$illustId,
    #recommendMethods: _f$recommendMethods,
    #recommendScore: _f$recommendScore,
    #recommendSeedIllustIds: _f$recommendSeedIllustIds,
  };

  static WebRecommendedIllust _instantiate(DecodingData data) {
    return WebRecommendedIllust(
      data.dec(_f$illustId),
      recommendMethods: data.dec(_f$recommendMethods),
      recommendScore: data.dec(_f$recommendScore),
      recommendSeedIllustIds: data.dec(_f$recommendSeedIllustIds),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebRecommendedIllust fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebRecommendedIllust>(map);
  }

  static WebRecommendedIllust fromJson(String json) {
    return ensureInitialized().decodeJson<WebRecommendedIllust>(json);
  }
}

mixin WebRecommendedIllustMappable {
  String toJson() {
    return WebRecommendedIllustMapper.ensureInitialized()
        .encodeJson<WebRecommendedIllust>(this as WebRecommendedIllust);
  }

  Map<String, dynamic> toMap() {
    return WebRecommendedIllustMapper.ensureInitialized()
        .encodeMap<WebRecommendedIllust>(this as WebRecommendedIllust);
  }

  WebRecommendedIllustCopyWith<
    WebRecommendedIllust,
    WebRecommendedIllust,
    WebRecommendedIllust
  >
  get copyWith =>
      _WebRecommendedIllustCopyWithImpl<
        WebRecommendedIllust,
        WebRecommendedIllust
      >(this as WebRecommendedIllust, $identity, $identity);
  @override
  String toString() {
    return WebRecommendedIllustMapper.ensureInitialized().stringifyValue(
      this as WebRecommendedIllust,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebRecommendedIllustMapper.ensureInitialized().equalsValue(
      this as WebRecommendedIllust,
      other,
    );
  }

  @override
  int get hashCode {
    return WebRecommendedIllustMapper.ensureInitialized().hashValue(
      this as WebRecommendedIllust,
    );
  }
}

extension WebRecommendedIllustValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebRecommendedIllust, $Out> {
  WebRecommendedIllustCopyWith<$R, WebRecommendedIllust, $Out>
  get $asWebRecommendedIllust => $base.as(
    (v, t, t2) => _WebRecommendedIllustCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebRecommendedIllustCopyWith<
  $R,
  $In extends WebRecommendedIllust,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get recommendMethods;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>
  get recommendSeedIllustIds;
  $R call({
    String? illustId,
    List<String>? recommendMethods,
    double? recommendScore,
    List<int>? recommendSeedIllustIds,
  });
  WebRecommendedIllustCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebRecommendedIllustCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebRecommendedIllust, $Out>
    implements WebRecommendedIllustCopyWith<$R, WebRecommendedIllust, $Out> {
  _WebRecommendedIllustCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebRecommendedIllust> $mapper =
      WebRecommendedIllustMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get recommendMethods => ListCopyWith(
    $value.recommendMethods,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(recommendMethods: v),
  );
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>
  get recommendSeedIllustIds => ListCopyWith(
    $value.recommendSeedIllustIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(recommendSeedIllustIds: v),
  );
  @override
  $R call({
    String? illustId,
    List<String>? recommendMethods,
    double? recommendScore,
    List<int>? recommendSeedIllustIds,
  }) => $apply(
    FieldCopyWithData({
      if (illustId != null) #illustId: illustId,
      if (recommendMethods != null) #recommendMethods: recommendMethods,
      if (recommendScore != null) #recommendScore: recommendScore,
      if (recommendSeedIllustIds != null)
        #recommendSeedIllustIds: recommendSeedIllustIds,
    }),
  );
  @override
  WebRecommendedIllust $make(CopyWithData data) => WebRecommendedIllust(
    data.get(#illustId, or: $value.illustId),
    recommendMethods: data.get(#recommendMethods, or: $value.recommendMethods),
    recommendScore: data.get(#recommendScore, or: $value.recommendScore),
    recommendSeedIllustIds: data.get(
      #recommendSeedIllustIds,
      or: $value.recommendSeedIllustIds,
    ),
  );

  @override
  WebRecommendedIllustCopyWith<$R2, WebRecommendedIllust, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebRecommendedIllustCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDiscoveryThumbnailsMapper
    extends ClassMapperBase<WebDiscoveryThumbnails> {
  WebDiscoveryThumbnailsMapper._();

  static WebDiscoveryThumbnailsMapper? _instance;
  static WebDiscoveryThumbnailsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDiscoveryThumbnailsMapper._());
      WebDiscoveryIllustMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebDiscoveryThumbnails';

  static List<WebDiscoveryIllust> _$illust(WebDiscoveryThumbnails v) =>
      v.illust;
  static const Field<WebDiscoveryThumbnails, List<WebDiscoveryIllust>>
  _f$illust = Field('illust', _$illust, opt: true, def: const []);

  @override
  final MappableFields<WebDiscoveryThumbnails> fields = const {
    #illust: _f$illust,
  };

  static WebDiscoveryThumbnails _instantiate(DecodingData data) {
    return WebDiscoveryThumbnails(illust: data.dec(_f$illust));
  }

  @override
  final Function instantiate = _instantiate;

  static WebDiscoveryThumbnails fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDiscoveryThumbnails>(map);
  }

  static WebDiscoveryThumbnails fromJson(String json) {
    return ensureInitialized().decodeJson<WebDiscoveryThumbnails>(json);
  }
}

mixin WebDiscoveryThumbnailsMappable {
  String toJson() {
    return WebDiscoveryThumbnailsMapper.ensureInitialized()
        .encodeJson<WebDiscoveryThumbnails>(this as WebDiscoveryThumbnails);
  }

  Map<String, dynamic> toMap() {
    return WebDiscoveryThumbnailsMapper.ensureInitialized()
        .encodeMap<WebDiscoveryThumbnails>(this as WebDiscoveryThumbnails);
  }

  WebDiscoveryThumbnailsCopyWith<
    WebDiscoveryThumbnails,
    WebDiscoveryThumbnails,
    WebDiscoveryThumbnails
  >
  get copyWith =>
      _WebDiscoveryThumbnailsCopyWithImpl<
        WebDiscoveryThumbnails,
        WebDiscoveryThumbnails
      >(this as WebDiscoveryThumbnails, $identity, $identity);
  @override
  String toString() {
    return WebDiscoveryThumbnailsMapper.ensureInitialized().stringifyValue(
      this as WebDiscoveryThumbnails,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDiscoveryThumbnailsMapper.ensureInitialized().equalsValue(
      this as WebDiscoveryThumbnails,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDiscoveryThumbnailsMapper.ensureInitialized().hashValue(
      this as WebDiscoveryThumbnails,
    );
  }
}

extension WebDiscoveryThumbnailsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDiscoveryThumbnails, $Out> {
  WebDiscoveryThumbnailsCopyWith<$R, WebDiscoveryThumbnails, $Out>
  get $asWebDiscoveryThumbnails => $base.as(
    (v, t, t2) => _WebDiscoveryThumbnailsCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebDiscoveryThumbnailsCopyWith<
  $R,
  $In extends WebDiscoveryThumbnails,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get illust;
  $R call({List<WebDiscoveryIllust>? illust});
  WebDiscoveryThumbnailsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebDiscoveryThumbnailsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDiscoveryThumbnails, $Out>
    implements
        WebDiscoveryThumbnailsCopyWith<$R, WebDiscoveryThumbnails, $Out> {
  _WebDiscoveryThumbnailsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDiscoveryThumbnails> $mapper =
      WebDiscoveryThumbnailsMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get illust => ListCopyWith(
    $value.illust,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(illust: v),
  );
  @override
  $R call({List<WebDiscoveryIllust>? illust}) =>
      $apply(FieldCopyWithData({if (illust != null) #illust: illust}));
  @override
  WebDiscoveryThumbnails $make(CopyWithData data) =>
      WebDiscoveryThumbnails(illust: data.get(#illust, or: $value.illust));

  @override
  WebDiscoveryThumbnailsCopyWith<$R2, WebDiscoveryThumbnails, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebDiscoveryThumbnailsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDiscoveryBodyMapper extends ClassMapperBase<WebDiscoveryBody> {
  WebDiscoveryBodyMapper._();

  static WebDiscoveryBodyMapper? _instance;
  static WebDiscoveryBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDiscoveryBodyMapper._());
      WebDiscoveryThumbnailsMapper.ensureInitialized();
      WebRecommendedIllustMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebDiscoveryBody';

  static WebDiscoveryThumbnails _$thumbnails(WebDiscoveryBody v) =>
      v.thumbnails;
  static const Field<WebDiscoveryBody, WebDiscoveryThumbnails> _f$thumbnails =
      Field('thumbnails', _$thumbnails);
  static Map<String, dynamic>? _$tagTranslation(WebDiscoveryBody v) =>
      v.tagTranslation;
  static const Field<WebDiscoveryBody, Map<String, dynamic>> _f$tagTranslation =
      Field('tagTranslation', _$tagTranslation, opt: true);
  static List<dynamic> _$illustSeries(WebDiscoveryBody v) => v.illustSeries;
  static const Field<WebDiscoveryBody, List<dynamic>> _f$illustSeries = Field(
    'illustSeries',
    _$illustSeries,
    opt: true,
    def: const [],
  );
  static List<dynamic> _$requests(WebDiscoveryBody v) => v.requests;
  static const Field<WebDiscoveryBody, List<dynamic>> _f$requests = Field(
    'requests',
    _$requests,
    opt: true,
    def: const [],
  );
  static List<dynamic> _$users(WebDiscoveryBody v) => v.users;
  static const Field<WebDiscoveryBody, List<dynamic>> _f$users = Field(
    'users',
    _$users,
    opt: true,
    def: const [],
  );
  static List<WebRecommendedIllust> _$recommendedIllusts(WebDiscoveryBody v) =>
      v.recommendedIllusts;
  static const Field<WebDiscoveryBody, List<WebRecommendedIllust>>
  _f$recommendedIllusts = Field(
    'recommendedIllusts',
    _$recommendedIllusts,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<WebDiscoveryBody> fields = const {
    #thumbnails: _f$thumbnails,
    #tagTranslation: _f$tagTranslation,
    #illustSeries: _f$illustSeries,
    #requests: _f$requests,
    #users: _f$users,
    #recommendedIllusts: _f$recommendedIllusts,
  };

  static WebDiscoveryBody _instantiate(DecodingData data) {
    return WebDiscoveryBody(
      data.dec(_f$thumbnails),
      tagTranslation: data.dec(_f$tagTranslation),
      illustSeries: data.dec(_f$illustSeries),
      requests: data.dec(_f$requests),
      users: data.dec(_f$users),
      recommendedIllusts: data.dec(_f$recommendedIllusts),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebDiscoveryBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDiscoveryBody>(map);
  }

  static WebDiscoveryBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebDiscoveryBody>(json);
  }
}

mixin WebDiscoveryBodyMappable {
  String toJson() {
    return WebDiscoveryBodyMapper.ensureInitialized()
        .encodeJson<WebDiscoveryBody>(this as WebDiscoveryBody);
  }

  Map<String, dynamic> toMap() {
    return WebDiscoveryBodyMapper.ensureInitialized()
        .encodeMap<WebDiscoveryBody>(this as WebDiscoveryBody);
  }

  WebDiscoveryBodyCopyWith<WebDiscoveryBody, WebDiscoveryBody, WebDiscoveryBody>
  get copyWith =>
      _WebDiscoveryBodyCopyWithImpl<WebDiscoveryBody, WebDiscoveryBody>(
        this as WebDiscoveryBody,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebDiscoveryBodyMapper.ensureInitialized().stringifyValue(
      this as WebDiscoveryBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDiscoveryBodyMapper.ensureInitialized().equalsValue(
      this as WebDiscoveryBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDiscoveryBodyMapper.ensureInitialized().hashValue(
      this as WebDiscoveryBody,
    );
  }
}

extension WebDiscoveryBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDiscoveryBody, $Out> {
  WebDiscoveryBodyCopyWith<$R, WebDiscoveryBody, $Out>
  get $asWebDiscoveryBody =>
      $base.as((v, t, t2) => _WebDiscoveryBodyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebDiscoveryBodyCopyWith<$R, $In extends WebDiscoveryBody, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  WebDiscoveryThumbnailsCopyWith<
    $R,
    WebDiscoveryThumbnails,
    WebDiscoveryThumbnails
  >
  get thumbnails;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get tagTranslation;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get illustSeries;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get requests;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get users;
  ListCopyWith<
    $R,
    WebRecommendedIllust,
    WebRecommendedIllustCopyWith<$R, WebRecommendedIllust, WebRecommendedIllust>
  >
  get recommendedIllusts;
  $R call({
    WebDiscoveryThumbnails? thumbnails,
    Map<String, dynamic>? tagTranslation,
    List<dynamic>? illustSeries,
    List<dynamic>? requests,
    List<dynamic>? users,
    List<WebRecommendedIllust>? recommendedIllusts,
  });
  WebDiscoveryBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebDiscoveryBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDiscoveryBody, $Out>
    implements WebDiscoveryBodyCopyWith<$R, WebDiscoveryBody, $Out> {
  _WebDiscoveryBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDiscoveryBody> $mapper =
      WebDiscoveryBodyMapper.ensureInitialized();
  @override
  WebDiscoveryThumbnailsCopyWith<
    $R,
    WebDiscoveryThumbnails,
    WebDiscoveryThumbnails
  >
  get thumbnails =>
      $value.thumbnails.copyWith.$chain((v) => call(thumbnails: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get tagTranslation => $value.tagTranslation != null
      ? MapCopyWith(
          $value.tagTranslation!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tagTranslation: v),
        )
      : null;
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get illustSeries => ListCopyWith(
    $value.illustSeries,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(illustSeries: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get requests => ListCopyWith(
    $value.requests,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(requests: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get users =>
      ListCopyWith(
        $value.users,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(users: v),
      );
  @override
  ListCopyWith<
    $R,
    WebRecommendedIllust,
    WebRecommendedIllustCopyWith<$R, WebRecommendedIllust, WebRecommendedIllust>
  >
  get recommendedIllusts => ListCopyWith(
    $value.recommendedIllusts,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(recommendedIllusts: v),
  );
  @override
  $R call({
    WebDiscoveryThumbnails? thumbnails,
    Object? tagTranslation = $none,
    List<dynamic>? illustSeries,
    List<dynamic>? requests,
    List<dynamic>? users,
    List<WebRecommendedIllust>? recommendedIllusts,
  }) => $apply(
    FieldCopyWithData({
      if (thumbnails != null) #thumbnails: thumbnails,
      if (tagTranslation != $none) #tagTranslation: tagTranslation,
      if (illustSeries != null) #illustSeries: illustSeries,
      if (requests != null) #requests: requests,
      if (users != null) #users: users,
      if (recommendedIllusts != null) #recommendedIllusts: recommendedIllusts,
    }),
  );
  @override
  WebDiscoveryBody $make(CopyWithData data) => WebDiscoveryBody(
    data.get(#thumbnails, or: $value.thumbnails),
    tagTranslation: data.get(#tagTranslation, or: $value.tagTranslation),
    illustSeries: data.get(#illustSeries, or: $value.illustSeries),
    requests: data.get(#requests, or: $value.requests),
    users: data.get(#users, or: $value.users),
    recommendedIllusts: data.get(
      #recommendedIllusts,
      or: $value.recommendedIllusts,
    ),
  );

  @override
  WebDiscoveryBodyCopyWith<$R2, WebDiscoveryBody, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebDiscoveryBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDiscoveryResponseMapper extends ClassMapperBase<WebDiscoveryResponse> {
  WebDiscoveryResponseMapper._();

  static WebDiscoveryResponseMapper? _instance;
  static WebDiscoveryResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDiscoveryResponseMapper._());
      WebDiscoveryBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebDiscoveryResponse';

  static bool _$error(WebDiscoveryResponse v) => v.error;
  static const Field<WebDiscoveryResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static WebDiscoveryBody _$body(WebDiscoveryResponse v) => v.body;
  static const Field<WebDiscoveryResponse, WebDiscoveryBody> _f$body = Field(
    'body',
    _$body,
  );
  static String _$message(WebDiscoveryResponse v) => v.message;
  static const Field<WebDiscoveryResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<WebDiscoveryResponse> fields = const {
    #error: _f$error,
    #body: _f$body,
    #message: _f$message,
  };

  static WebDiscoveryResponse _instantiate(DecodingData data) {
    return WebDiscoveryResponse(
      data.dec(_f$error),
      data.dec(_f$body),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebDiscoveryResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDiscoveryResponse>(map);
  }

  static WebDiscoveryResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebDiscoveryResponse>(json);
  }
}

mixin WebDiscoveryResponseMappable {
  String toJson() {
    return WebDiscoveryResponseMapper.ensureInitialized()
        .encodeJson<WebDiscoveryResponse>(this as WebDiscoveryResponse);
  }

  Map<String, dynamic> toMap() {
    return WebDiscoveryResponseMapper.ensureInitialized()
        .encodeMap<WebDiscoveryResponse>(this as WebDiscoveryResponse);
  }

  WebDiscoveryResponseCopyWith<
    WebDiscoveryResponse,
    WebDiscoveryResponse,
    WebDiscoveryResponse
  >
  get copyWith =>
      _WebDiscoveryResponseCopyWithImpl<
        WebDiscoveryResponse,
        WebDiscoveryResponse
      >(this as WebDiscoveryResponse, $identity, $identity);
  @override
  String toString() {
    return WebDiscoveryResponseMapper.ensureInitialized().stringifyValue(
      this as WebDiscoveryResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDiscoveryResponseMapper.ensureInitialized().equalsValue(
      this as WebDiscoveryResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDiscoveryResponseMapper.ensureInitialized().hashValue(
      this as WebDiscoveryResponse,
    );
  }
}

extension WebDiscoveryResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDiscoveryResponse, $Out> {
  WebDiscoveryResponseCopyWith<$R, WebDiscoveryResponse, $Out>
  get $asWebDiscoveryResponse => $base.as(
    (v, t, t2) => _WebDiscoveryResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebDiscoveryResponseCopyWith<
  $R,
  $In extends WebDiscoveryResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebDiscoveryBodyCopyWith<$R, WebDiscoveryBody, WebDiscoveryBody> get body;
  $R call({bool? error, WebDiscoveryBody? body, String? message});
  WebDiscoveryResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebDiscoveryResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDiscoveryResponse, $Out>
    implements WebDiscoveryResponseCopyWith<$R, WebDiscoveryResponse, $Out> {
  _WebDiscoveryResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDiscoveryResponse> $mapper =
      WebDiscoveryResponseMapper.ensureInitialized();
  @override
  WebDiscoveryBodyCopyWith<$R, WebDiscoveryBody, WebDiscoveryBody> get body =>
      $value.body.copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, WebDiscoveryBody? body, String? message}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (body != null) #body: body,
      if (message != null) #message: message,
    }),
  );
  @override
  WebDiscoveryResponse $make(CopyWithData data) => WebDiscoveryResponse(
    data.get(#error, or: $value.error),
    data.get(#body, or: $value.body),
    message: data.get(#message, or: $value.message),
  );

  @override
  WebDiscoveryResponseCopyWith<$R2, WebDiscoveryResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebDiscoveryResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDetailUrlsMapper extends ClassMapperBase<WebDetailUrls> {
  WebDetailUrlsMapper._();

  static WebDetailUrlsMapper? _instance;
  static WebDetailUrlsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDetailUrlsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebDetailUrls';

  static String _$mini(WebDetailUrls v) => v.mini;
  static const Field<WebDetailUrls, String> _f$mini = Field(
    'mini',
    _$mini,
    opt: true,
    def: '',
  );
  static String _$thumb(WebDetailUrls v) => v.thumb;
  static const Field<WebDetailUrls, String> _f$thumb = Field(
    'thumb',
    _$thumb,
    opt: true,
    def: '',
  );
  static String _$small(WebDetailUrls v) => v.small;
  static const Field<WebDetailUrls, String> _f$small = Field(
    'small',
    _$small,
    opt: true,
    def: '',
  );
  static String _$regular(WebDetailUrls v) => v.regular;
  static const Field<WebDetailUrls, String> _f$regular = Field(
    'regular',
    _$regular,
    opt: true,
    def: '',
  );
  static String _$original(WebDetailUrls v) => v.original;
  static const Field<WebDetailUrls, String> _f$original = Field(
    'original',
    _$original,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<WebDetailUrls> fields = const {
    #mini: _f$mini,
    #thumb: _f$thumb,
    #small: _f$small,
    #regular: _f$regular,
    #original: _f$original,
  };

  static WebDetailUrls _instantiate(DecodingData data) {
    return WebDetailUrls(
      mini: data.dec(_f$mini),
      thumb: data.dec(_f$thumb),
      small: data.dec(_f$small),
      regular: data.dec(_f$regular),
      original: data.dec(_f$original),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebDetailUrls fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDetailUrls>(map);
  }

  static WebDetailUrls fromJson(String json) {
    return ensureInitialized().decodeJson<WebDetailUrls>(json);
  }
}

mixin WebDetailUrlsMappable {
  String toJson() {
    return WebDetailUrlsMapper.ensureInitialized().encodeJson<WebDetailUrls>(
      this as WebDetailUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return WebDetailUrlsMapper.ensureInitialized().encodeMap<WebDetailUrls>(
      this as WebDetailUrls,
    );
  }

  WebDetailUrlsCopyWith<WebDetailUrls, WebDetailUrls, WebDetailUrls>
  get copyWith => _WebDetailUrlsCopyWithImpl<WebDetailUrls, WebDetailUrls>(
    this as WebDetailUrls,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebDetailUrlsMapper.ensureInitialized().stringifyValue(
      this as WebDetailUrls,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDetailUrlsMapper.ensureInitialized().equalsValue(
      this as WebDetailUrls,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDetailUrlsMapper.ensureInitialized().hashValue(
      this as WebDetailUrls,
    );
  }
}

extension WebDetailUrlsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDetailUrls, $Out> {
  WebDetailUrlsCopyWith<$R, WebDetailUrls, $Out> get $asWebDetailUrls =>
      $base.as((v, t, t2) => _WebDetailUrlsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebDetailUrlsCopyWith<$R, $In extends WebDetailUrls, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? mini,
    String? thumb,
    String? small,
    String? regular,
    String? original,
  });
  WebDetailUrlsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebDetailUrlsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDetailUrls, $Out>
    implements WebDetailUrlsCopyWith<$R, WebDetailUrls, $Out> {
  _WebDetailUrlsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDetailUrls> $mapper =
      WebDetailUrlsMapper.ensureInitialized();
  @override
  $R call({
    String? mini,
    String? thumb,
    String? small,
    String? regular,
    String? original,
  }) => $apply(
    FieldCopyWithData({
      if (mini != null) #mini: mini,
      if (thumb != null) #thumb: thumb,
      if (small != null) #small: small,
      if (regular != null) #regular: regular,
      if (original != null) #original: original,
    }),
  );
  @override
  WebDetailUrls $make(CopyWithData data) => WebDetailUrls(
    mini: data.get(#mini, or: $value.mini),
    thumb: data.get(#thumb, or: $value.thumb),
    small: data.get(#small, or: $value.small),
    regular: data.get(#regular, or: $value.regular),
    original: data.get(#original, or: $value.original),
  );

  @override
  WebDetailUrlsCopyWith<$R2, WebDetailUrls, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebDetailUrlsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDetailTagMapper extends ClassMapperBase<WebDetailTag> {
  WebDetailTagMapper._();

  static WebDetailTagMapper? _instance;
  static WebDetailTagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDetailTagMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebDetailTag';

  static String _$tag(WebDetailTag v) => v.tag;
  static const Field<WebDetailTag, String> _f$tag = Field('tag', _$tag);
  static bool _$locked(WebDetailTag v) => v.locked;
  static const Field<WebDetailTag, bool> _f$locked = Field(
    'locked',
    _$locked,
    opt: true,
    def: false,
  );
  static bool _$deletable(WebDetailTag v) => v.deletable;
  static const Field<WebDetailTag, bool> _f$deletable = Field(
    'deletable',
    _$deletable,
    opt: true,
    def: false,
  );
  static String? _$userId(WebDetailTag v) => v.userId;
  static const Field<WebDetailTag, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
  );
  static String? _$userName(WebDetailTag v) => v.userName;
  static const Field<WebDetailTag, String> _f$userName = Field(
    'userName',
    _$userName,
    opt: true,
  );
  static String? _$romaji(WebDetailTag v) => v.romaji;
  static const Field<WebDetailTag, String> _f$romaji = Field(
    'romaji',
    _$romaji,
    opt: true,
  );
  static Map<String, String>? _$translation(WebDetailTag v) => v.translation;
  static const Field<WebDetailTag, Map<String, String>> _f$translation = Field(
    'translation',
    _$translation,
    opt: true,
  );

  @override
  final MappableFields<WebDetailTag> fields = const {
    #tag: _f$tag,
    #locked: _f$locked,
    #deletable: _f$deletable,
    #userId: _f$userId,
    #userName: _f$userName,
    #romaji: _f$romaji,
    #translation: _f$translation,
  };

  static WebDetailTag _instantiate(DecodingData data) {
    return WebDetailTag(
      data.dec(_f$tag),
      locked: data.dec(_f$locked),
      deletable: data.dec(_f$deletable),
      userId: data.dec(_f$userId),
      userName: data.dec(_f$userName),
      romaji: data.dec(_f$romaji),
      translation: data.dec(_f$translation),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebDetailTag fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDetailTag>(map);
  }

  static WebDetailTag fromJson(String json) {
    return ensureInitialized().decodeJson<WebDetailTag>(json);
  }
}

mixin WebDetailTagMappable {
  String toJson() {
    return WebDetailTagMapper.ensureInitialized().encodeJson<WebDetailTag>(
      this as WebDetailTag,
    );
  }

  Map<String, dynamic> toMap() {
    return WebDetailTagMapper.ensureInitialized().encodeMap<WebDetailTag>(
      this as WebDetailTag,
    );
  }

  WebDetailTagCopyWith<WebDetailTag, WebDetailTag, WebDetailTag> get copyWith =>
      _WebDetailTagCopyWithImpl<WebDetailTag, WebDetailTag>(
        this as WebDetailTag,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebDetailTagMapper.ensureInitialized().stringifyValue(
      this as WebDetailTag,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDetailTagMapper.ensureInitialized().equalsValue(
      this as WebDetailTag,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDetailTagMapper.ensureInitialized().hashValue(
      this as WebDetailTag,
    );
  }
}

extension WebDetailTagValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDetailTag, $Out> {
  WebDetailTagCopyWith<$R, WebDetailTag, $Out> get $asWebDetailTag =>
      $base.as((v, t, t2) => _WebDetailTagCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebDetailTagCopyWith<$R, $In extends WebDetailTag, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
  get translation;
  $R call({
    String? tag,
    bool? locked,
    bool? deletable,
    String? userId,
    String? userName,
    String? romaji,
    Map<String, String>? translation,
  });
  WebDetailTagCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebDetailTagCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDetailTag, $Out>
    implements WebDetailTagCopyWith<$R, WebDetailTag, $Out> {
  _WebDetailTagCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDetailTag> $mapper =
      WebDetailTagMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
  get translation => $value.translation != null
      ? MapCopyWith(
          $value.translation!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(translation: v),
        )
      : null;
  @override
  $R call({
    String? tag,
    bool? locked,
    bool? deletable,
    Object? userId = $none,
    Object? userName = $none,
    Object? romaji = $none,
    Object? translation = $none,
  }) => $apply(
    FieldCopyWithData({
      if (tag != null) #tag: tag,
      if (locked != null) #locked: locked,
      if (deletable != null) #deletable: deletable,
      if (userId != $none) #userId: userId,
      if (userName != $none) #userName: userName,
      if (romaji != $none) #romaji: romaji,
      if (translation != $none) #translation: translation,
    }),
  );
  @override
  WebDetailTag $make(CopyWithData data) => WebDetailTag(
    data.get(#tag, or: $value.tag),
    locked: data.get(#locked, or: $value.locked),
    deletable: data.get(#deletable, or: $value.deletable),
    userId: data.get(#userId, or: $value.userId),
    userName: data.get(#userName, or: $value.userName),
    romaji: data.get(#romaji, or: $value.romaji),
    translation: data.get(#translation, or: $value.translation),
  );

  @override
  WebDetailTagCopyWith<$R2, WebDetailTag, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebDetailTagCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDetailTagWrapMapper extends ClassMapperBase<WebDetailTagWrap> {
  WebDetailTagWrapMapper._();

  static WebDetailTagWrapMapper? _instance;
  static WebDetailTagWrapMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDetailTagWrapMapper._());
      WebDetailTagMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebDetailTagWrap';

  static String? _$authorId(WebDetailTagWrap v) => v.authorId;
  static const Field<WebDetailTagWrap, String> _f$authorId = Field(
    'authorId',
    _$authorId,
    opt: true,
  );
  static bool _$isLocked(WebDetailTagWrap v) => v.isLocked;
  static const Field<WebDetailTagWrap, bool> _f$isLocked = Field(
    'isLocked',
    _$isLocked,
    opt: true,
    def: false,
  );
  static List<WebDetailTag> _$tags(WebDetailTagWrap v) => v.tags;
  static const Field<WebDetailTagWrap, List<WebDetailTag>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
    def: const [],
  );
  static bool? _$writable(WebDetailTagWrap v) => v.writable;
  static const Field<WebDetailTagWrap, bool> _f$writable = Field(
    'writable',
    _$writable,
    opt: true,
  );

  @override
  final MappableFields<WebDetailTagWrap> fields = const {
    #authorId: _f$authorId,
    #isLocked: _f$isLocked,
    #tags: _f$tags,
    #writable: _f$writable,
  };

  static WebDetailTagWrap _instantiate(DecodingData data) {
    return WebDetailTagWrap(
      authorId: data.dec(_f$authorId),
      isLocked: data.dec(_f$isLocked),
      tags: data.dec(_f$tags),
      writable: data.dec(_f$writable),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebDetailTagWrap fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDetailTagWrap>(map);
  }

  static WebDetailTagWrap fromJson(String json) {
    return ensureInitialized().decodeJson<WebDetailTagWrap>(json);
  }
}

mixin WebDetailTagWrapMappable {
  String toJson() {
    return WebDetailTagWrapMapper.ensureInitialized()
        .encodeJson<WebDetailTagWrap>(this as WebDetailTagWrap);
  }

  Map<String, dynamic> toMap() {
    return WebDetailTagWrapMapper.ensureInitialized()
        .encodeMap<WebDetailTagWrap>(this as WebDetailTagWrap);
  }

  WebDetailTagWrapCopyWith<WebDetailTagWrap, WebDetailTagWrap, WebDetailTagWrap>
  get copyWith =>
      _WebDetailTagWrapCopyWithImpl<WebDetailTagWrap, WebDetailTagWrap>(
        this as WebDetailTagWrap,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebDetailTagWrapMapper.ensureInitialized().stringifyValue(
      this as WebDetailTagWrap,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebDetailTagWrapMapper.ensureInitialized().equalsValue(
      this as WebDetailTagWrap,
      other,
    );
  }

  @override
  int get hashCode {
    return WebDetailTagWrapMapper.ensureInitialized().hashValue(
      this as WebDetailTagWrap,
    );
  }
}

extension WebDetailTagWrapValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDetailTagWrap, $Out> {
  WebDetailTagWrapCopyWith<$R, WebDetailTagWrap, $Out>
  get $asWebDetailTagWrap =>
      $base.as((v, t, t2) => _WebDetailTagWrapCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebDetailTagWrapCopyWith<$R, $In extends WebDetailTagWrap, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebDetailTag,
    WebDetailTagCopyWith<$R, WebDetailTag, WebDetailTag>
  >
  get tags;
  $R call({
    String? authorId,
    bool? isLocked,
    List<WebDetailTag>? tags,
    bool? writable,
  });
  WebDetailTagWrapCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebDetailTagWrapCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDetailTagWrap, $Out>
    implements WebDetailTagWrapCopyWith<$R, WebDetailTagWrap, $Out> {
  _WebDetailTagWrapCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDetailTagWrap> $mapper =
      WebDetailTagWrapMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebDetailTag,
    WebDetailTagCopyWith<$R, WebDetailTag, WebDetailTag>
  >
  get tags => ListCopyWith(
    $value.tags,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(tags: v),
  );
  @override
  $R call({
    Object? authorId = $none,
    bool? isLocked,
    List<WebDetailTag>? tags,
    Object? writable = $none,
  }) => $apply(
    FieldCopyWithData({
      if (authorId != $none) #authorId: authorId,
      if (isLocked != null) #isLocked: isLocked,
      if (tags != null) #tags: tags,
      if (writable != $none) #writable: writable,
    }),
  );
  @override
  WebDetailTagWrap $make(CopyWithData data) => WebDetailTagWrap(
    authorId: data.get(#authorId, or: $value.authorId),
    isLocked: data.get(#isLocked, or: $value.isLocked),
    tags: data.get(#tags, or: $value.tags),
    writable: data.get(#writable, or: $value.writable),
  );

  @override
  WebDetailTagWrapCopyWith<$R2, WebDetailTagWrap, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebDetailTagWrapCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebIllustDetailMapper extends ClassMapperBase<WebIllustDetail> {
  WebIllustDetailMapper._();

  static WebIllustDetailMapper? _instance;
  static WebIllustDetailMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebIllustDetailMapper._());
      WebDetailUrlsMapper.ensureInitialized();
      WebDetailTagWrapMapper.ensureInitialized();
      WebTitleCaptionTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebIllustDetail';

  static String _$id(WebIllustDetail v) => v.id;
  static const Field<WebIllustDetail, String> _f$id = Field('id', _$id);
  static String _$title(WebIllustDetail v) => v.title;
  static const Field<WebIllustDetail, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$description(WebIllustDetail v) => v.description;
  static const Field<WebIllustDetail, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static int _$illustType(WebIllustDetail v) => v.illustType;
  static const Field<WebIllustDetail, int> _f$illustType = Field(
    'illustType',
    _$illustType,
    opt: true,
    def: 0,
  );
  static String? _$createDate(WebIllustDetail v) => v.createDate;
  static const Field<WebIllustDetail, String> _f$createDate = Field(
    'createDate',
    _$createDate,
    opt: true,
  );
  static String? _$uploadDate(WebIllustDetail v) => v.uploadDate;
  static const Field<WebIllustDetail, String> _f$uploadDate = Field(
    'uploadDate',
    _$uploadDate,
    opt: true,
  );
  static int _$restrict(WebIllustDetail v) => v.restrict;
  static const Field<WebIllustDetail, int> _f$restrict = Field(
    'restrict',
    _$restrict,
    opt: true,
    def: 0,
  );
  static int _$xRestrict(WebIllustDetail v) => v.xRestrict;
  static const Field<WebIllustDetail, int> _f$xRestrict = Field(
    'xRestrict',
    _$xRestrict,
    opt: true,
    def: 0,
  );
  static int _$sl(WebIllustDetail v) => v.sl;
  static const Field<WebIllustDetail, int> _f$sl = Field(
    'sl',
    _$sl,
    opt: true,
    def: 0,
  );
  static WebDetailUrls _$urls(WebIllustDetail v) => v.urls;
  static const Field<WebIllustDetail, WebDetailUrls> _f$urls = Field(
    'urls',
    _$urls,
    opt: true,
  );
  static WebDetailTagWrap _$tags(WebIllustDetail v) => v.tags;
  static const Field<WebIllustDetail, WebDetailTagWrap> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
  );
  static String? _$alt(WebIllustDetail v) => v.alt;
  static const Field<WebIllustDetail, String> _f$alt = Field(
    'alt',
    _$alt,
    opt: true,
  );
  static String? _$userId(WebIllustDetail v) => v.userId;
  static const Field<WebIllustDetail, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
  );
  static String? _$userName(WebIllustDetail v) => v.userName;
  static const Field<WebIllustDetail, String> _f$userName = Field(
    'userName',
    _$userName,
    opt: true,
  );
  static String? _$userAccount(WebIllustDetail v) => v.userAccount;
  static const Field<WebIllustDetail, String> _f$userAccount = Field(
    'userAccount',
    _$userAccount,
    opt: true,
  );
  static int _$width(WebIllustDetail v) => v.width;
  static const Field<WebIllustDetail, int> _f$width = Field(
    'width',
    _$width,
    opt: true,
    def: 0,
  );
  static int _$height(WebIllustDetail v) => v.height;
  static const Field<WebIllustDetail, int> _f$height = Field(
    'height',
    _$height,
    opt: true,
    def: 0,
  );
  static int _$pageCount(WebIllustDetail v) => v.pageCount;
  static const Field<WebIllustDetail, int> _f$pageCount = Field(
    'pageCount',
    _$pageCount,
    opt: true,
    def: 0,
  );
  static int _$bookmarkCount(WebIllustDetail v) => v.bookmarkCount;
  static const Field<WebIllustDetail, int> _f$bookmarkCount = Field(
    'bookmarkCount',
    _$bookmarkCount,
    opt: true,
    def: 0,
  );
  static int _$likeCount(WebIllustDetail v) => v.likeCount;
  static const Field<WebIllustDetail, int> _f$likeCount = Field(
    'likeCount',
    _$likeCount,
    opt: true,
    def: 0,
  );
  static int _$commentCount(WebIllustDetail v) => v.commentCount;
  static const Field<WebIllustDetail, int> _f$commentCount = Field(
    'commentCount',
    _$commentCount,
    opt: true,
    def: 0,
  );
  static int _$viewCount(WebIllustDetail v) => v.viewCount;
  static const Field<WebIllustDetail, int> _f$viewCount = Field(
    'viewCount',
    _$viewCount,
    opt: true,
    def: 0,
  );
  static String? _$bookStyle(WebIllustDetail v) => v.bookStyle;
  static const Field<WebIllustDetail, String> _f$bookStyle = Field(
    'bookStyle',
    _$bookStyle,
    opt: true,
  );
  static int _$aiType(WebIllustDetail v) => v.aiType;
  static const Field<WebIllustDetail, int> _f$aiType = Field(
    'aiType',
    _$aiType,
    opt: true,
    def: 0,
  );
  static bool _$isBookmarkable(WebIllustDetail v) => v.isBookmarkable;
  static const Field<WebIllustDetail, bool> _f$isBookmarkable = Field(
    'isBookmarkable',
    _$isBookmarkable,
    opt: true,
    def: false,
  );
  static Map<String, dynamic>? _$bookmarkData(WebIllustDetail v) =>
      v.bookmarkData;
  static const Field<WebIllustDetail, Map<String, dynamic>> _f$bookmarkData =
      Field('bookmarkData', _$bookmarkData, opt: true);
  static WebTitleCaptionTranslation? _$titleCaptionTranslation(
    WebIllustDetail v,
  ) => v.titleCaptionTranslation;
  static const Field<WebIllustDetail, WebTitleCaptionTranslation>
  _f$titleCaptionTranslation = Field(
    'titleCaptionTranslation',
    _$titleCaptionTranslation,
    opt: true,
  );
  static Map<String, dynamic>? _$zoneConfig(WebIllustDetail v) => v.zoneConfig;
  static const Field<WebIllustDetail, Map<String, dynamic>> _f$zoneConfig =
      Field('zoneConfig', _$zoneConfig, opt: true);
  static Map<String, dynamic>? _$extraData(WebIllustDetail v) => v.extraData;
  static const Field<WebIllustDetail, Map<String, dynamic>> _f$extraData =
      Field('extraData', _$extraData, opt: true);
  static Map<String, dynamic>? _$userIllusts(WebIllustDetail v) =>
      v.userIllusts;
  static const Field<WebIllustDetail, Map<String, dynamic>> _f$userIllusts =
      Field('userIllusts', _$userIllusts, opt: true);
  static dynamic _$likeData(WebIllustDetail v) => v.likeData;
  static const Field<WebIllustDetail, dynamic> _f$likeData = Field(
    'likeData',
    _$likeData,
    opt: true,
  );

  @override
  final MappableFields<WebIllustDetail> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #illustType: _f$illustType,
    #createDate: _f$createDate,
    #uploadDate: _f$uploadDate,
    #restrict: _f$restrict,
    #xRestrict: _f$xRestrict,
    #sl: _f$sl,
    #urls: _f$urls,
    #tags: _f$tags,
    #alt: _f$alt,
    #userId: _f$userId,
    #userName: _f$userName,
    #userAccount: _f$userAccount,
    #width: _f$width,
    #height: _f$height,
    #pageCount: _f$pageCount,
    #bookmarkCount: _f$bookmarkCount,
    #likeCount: _f$likeCount,
    #commentCount: _f$commentCount,
    #viewCount: _f$viewCount,
    #bookStyle: _f$bookStyle,
    #aiType: _f$aiType,
    #isBookmarkable: _f$isBookmarkable,
    #bookmarkData: _f$bookmarkData,
    #titleCaptionTranslation: _f$titleCaptionTranslation,
    #zoneConfig: _f$zoneConfig,
    #extraData: _f$extraData,
    #userIllusts: _f$userIllusts,
    #likeData: _f$likeData,
  };

  static WebIllustDetail _instantiate(DecodingData data) {
    return WebIllustDetail(
      data.dec(_f$id),
      data.dec(_f$title),
      description: data.dec(_f$description),
      illustType: data.dec(_f$illustType),
      createDate: data.dec(_f$createDate),
      uploadDate: data.dec(_f$uploadDate),
      restrict: data.dec(_f$restrict),
      xRestrict: data.dec(_f$xRestrict),
      sl: data.dec(_f$sl),
      urls: data.dec(_f$urls),
      tags: data.dec(_f$tags),
      alt: data.dec(_f$alt),
      userId: data.dec(_f$userId),
      userName: data.dec(_f$userName),
      userAccount: data.dec(_f$userAccount),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
      pageCount: data.dec(_f$pageCount),
      bookmarkCount: data.dec(_f$bookmarkCount),
      likeCount: data.dec(_f$likeCount),
      commentCount: data.dec(_f$commentCount),
      viewCount: data.dec(_f$viewCount),
      bookStyle: data.dec(_f$bookStyle),
      aiType: data.dec(_f$aiType),
      isBookmarkable: data.dec(_f$isBookmarkable),
      bookmarkData: data.dec(_f$bookmarkData),
      titleCaptionTranslation: data.dec(_f$titleCaptionTranslation),
      zoneConfig: data.dec(_f$zoneConfig),
      extraData: data.dec(_f$extraData),
      userIllusts: data.dec(_f$userIllusts),
      likeData: data.dec(_f$likeData),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebIllustDetail fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebIllustDetail>(map);
  }

  static WebIllustDetail fromJson(String json) {
    return ensureInitialized().decodeJson<WebIllustDetail>(json);
  }
}

mixin WebIllustDetailMappable {
  String toJson() {
    return WebIllustDetailMapper.ensureInitialized()
        .encodeJson<WebIllustDetail>(this as WebIllustDetail);
  }

  Map<String, dynamic> toMap() {
    return WebIllustDetailMapper.ensureInitialized().encodeMap<WebIllustDetail>(
      this as WebIllustDetail,
    );
  }

  WebIllustDetailCopyWith<WebIllustDetail, WebIllustDetail, WebIllustDetail>
  get copyWith =>
      _WebIllustDetailCopyWithImpl<WebIllustDetail, WebIllustDetail>(
        this as WebIllustDetail,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebIllustDetailMapper.ensureInitialized().stringifyValue(
      this as WebIllustDetail,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebIllustDetailMapper.ensureInitialized().equalsValue(
      this as WebIllustDetail,
      other,
    );
  }

  @override
  int get hashCode {
    return WebIllustDetailMapper.ensureInitialized().hashValue(
      this as WebIllustDetail,
    );
  }
}

extension WebIllustDetailValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebIllustDetail, $Out> {
  WebIllustDetailCopyWith<$R, WebIllustDetail, $Out> get $asWebIllustDetail =>
      $base.as((v, t, t2) => _WebIllustDetailCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebIllustDetailCopyWith<$R, $In extends WebIllustDetail, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  WebDetailUrlsCopyWith<$R, WebDetailUrls, WebDetailUrls> get urls;
  WebDetailTagWrapCopyWith<$R, WebDetailTagWrap, WebDetailTagWrap> get tags;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get bookmarkData;
  WebTitleCaptionTranslationCopyWith<
    $R,
    WebTitleCaptionTranslation,
    WebTitleCaptionTranslation
  >?
  get titleCaptionTranslation;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get zoneConfig;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get extraData;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get userIllusts;
  $R call({
    String? id,
    String? title,
    String? description,
    int? illustType,
    String? createDate,
    String? uploadDate,
    int? restrict,
    int? xRestrict,
    int? sl,
    WebDetailUrls? urls,
    WebDetailTagWrap? tags,
    String? alt,
    String? userId,
    String? userName,
    String? userAccount,
    int? width,
    int? height,
    int? pageCount,
    int? bookmarkCount,
    int? likeCount,
    int? commentCount,
    int? viewCount,
    String? bookStyle,
    int? aiType,
    bool? isBookmarkable,
    Map<String, dynamic>? bookmarkData,
    WebTitleCaptionTranslation? titleCaptionTranslation,
    Map<String, dynamic>? zoneConfig,
    Map<String, dynamic>? extraData,
    Map<String, dynamic>? userIllusts,
    dynamic likeData,
  });
  WebIllustDetailCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebIllustDetailCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebIllustDetail, $Out>
    implements WebIllustDetailCopyWith<$R, WebIllustDetail, $Out> {
  _WebIllustDetailCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebIllustDetail> $mapper =
      WebIllustDetailMapper.ensureInitialized();
  @override
  WebDetailUrlsCopyWith<$R, WebDetailUrls, WebDetailUrls> get urls =>
      ($value.urls as WebDetailUrls).copyWith.$chain((v) => call(urls: v));
  @override
  WebDetailTagWrapCopyWith<$R, WebDetailTagWrap, WebDetailTagWrap> get tags =>
      ($value.tags as WebDetailTagWrap).copyWith.$chain((v) => call(tags: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get bookmarkData => $value.bookmarkData != null
      ? MapCopyWith(
          $value.bookmarkData!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(bookmarkData: v),
        )
      : null;
  @override
  WebTitleCaptionTranslationCopyWith<
    $R,
    WebTitleCaptionTranslation,
    WebTitleCaptionTranslation
  >?
  get titleCaptionTranslation => $value.titleCaptionTranslation?.copyWith
      .$chain((v) => call(titleCaptionTranslation: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get zoneConfig => $value.zoneConfig != null
      ? MapCopyWith(
          $value.zoneConfig!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(zoneConfig: v),
        )
      : null;
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get extraData => $value.extraData != null
      ? MapCopyWith(
          $value.extraData!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(extraData: v),
        )
      : null;
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get userIllusts => $value.userIllusts != null
      ? MapCopyWith(
          $value.userIllusts!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(userIllusts: v),
        )
      : null;
  @override
  $R call({
    String? id,
    String? title,
    String? description,
    int? illustType,
    Object? createDate = $none,
    Object? uploadDate = $none,
    int? restrict,
    int? xRestrict,
    int? sl,
    Object? urls = $none,
    Object? tags = $none,
    Object? alt = $none,
    Object? userId = $none,
    Object? userName = $none,
    Object? userAccount = $none,
    int? width,
    int? height,
    int? pageCount,
    int? bookmarkCount,
    int? likeCount,
    int? commentCount,
    int? viewCount,
    Object? bookStyle = $none,
    int? aiType,
    bool? isBookmarkable,
    Object? bookmarkData = $none,
    Object? titleCaptionTranslation = $none,
    Object? zoneConfig = $none,
    Object? extraData = $none,
    Object? userIllusts = $none,
    Object? likeData = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (illustType != null) #illustType: illustType,
      if (createDate != $none) #createDate: createDate,
      if (uploadDate != $none) #uploadDate: uploadDate,
      if (restrict != null) #restrict: restrict,
      if (xRestrict != null) #xRestrict: xRestrict,
      if (sl != null) #sl: sl,
      if (urls != $none) #urls: urls,
      if (tags != $none) #tags: tags,
      if (alt != $none) #alt: alt,
      if (userId != $none) #userId: userId,
      if (userName != $none) #userName: userName,
      if (userAccount != $none) #userAccount: userAccount,
      if (width != null) #width: width,
      if (height != null) #height: height,
      if (pageCount != null) #pageCount: pageCount,
      if (bookmarkCount != null) #bookmarkCount: bookmarkCount,
      if (likeCount != null) #likeCount: likeCount,
      if (commentCount != null) #commentCount: commentCount,
      if (viewCount != null) #viewCount: viewCount,
      if (bookStyle != $none) #bookStyle: bookStyle,
      if (aiType != null) #aiType: aiType,
      if (isBookmarkable != null) #isBookmarkable: isBookmarkable,
      if (bookmarkData != $none) #bookmarkData: bookmarkData,
      if (titleCaptionTranslation != $none)
        #titleCaptionTranslation: titleCaptionTranslation,
      if (zoneConfig != $none) #zoneConfig: zoneConfig,
      if (extraData != $none) #extraData: extraData,
      if (userIllusts != $none) #userIllusts: userIllusts,
      if (likeData != $none) #likeData: likeData,
    }),
  );
  @override
  WebIllustDetail $make(CopyWithData data) => WebIllustDetail(
    data.get(#id, or: $value.id),
    data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    illustType: data.get(#illustType, or: $value.illustType),
    createDate: data.get(#createDate, or: $value.createDate),
    uploadDate: data.get(#uploadDate, or: $value.uploadDate),
    restrict: data.get(#restrict, or: $value.restrict),
    xRestrict: data.get(#xRestrict, or: $value.xRestrict),
    sl: data.get(#sl, or: $value.sl),
    urls: data.get(#urls, or: $value.urls),
    tags: data.get(#tags, or: $value.tags),
    alt: data.get(#alt, or: $value.alt),
    userId: data.get(#userId, or: $value.userId),
    userName: data.get(#userName, or: $value.userName),
    userAccount: data.get(#userAccount, or: $value.userAccount),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
    pageCount: data.get(#pageCount, or: $value.pageCount),
    bookmarkCount: data.get(#bookmarkCount, or: $value.bookmarkCount),
    likeCount: data.get(#likeCount, or: $value.likeCount),
    commentCount: data.get(#commentCount, or: $value.commentCount),
    viewCount: data.get(#viewCount, or: $value.viewCount),
    bookStyle: data.get(#bookStyle, or: $value.bookStyle),
    aiType: data.get(#aiType, or: $value.aiType),
    isBookmarkable: data.get(#isBookmarkable, or: $value.isBookmarkable),
    bookmarkData: data.get(#bookmarkData, or: $value.bookmarkData),
    titleCaptionTranslation: data.get(
      #titleCaptionTranslation,
      or: $value.titleCaptionTranslation,
    ),
    zoneConfig: data.get(#zoneConfig, or: $value.zoneConfig),
    extraData: data.get(#extraData, or: $value.extraData),
    userIllusts: data.get(#userIllusts, or: $value.userIllusts),
    likeData: data.get(#likeData, or: $value.likeData),
  );

  @override
  WebIllustDetailCopyWith<$R2, WebIllustDetail, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebIllustDetailCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebIllustDetailResponseMapper
    extends ClassMapperBase<WebIllustDetailResponse> {
  WebIllustDetailResponseMapper._();

  static WebIllustDetailResponseMapper? _instance;
  static WebIllustDetailResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebIllustDetailResponseMapper._(),
      );
      WebIllustDetailMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebIllustDetailResponse';

  static bool _$error(WebIllustDetailResponse v) => v.error;
  static const Field<WebIllustDetailResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static WebIllustDetail _$body(WebIllustDetailResponse v) => v.body;
  static const Field<WebIllustDetailResponse, WebIllustDetail> _f$body = Field(
    'body',
    _$body,
  );
  static String _$message(WebIllustDetailResponse v) => v.message;
  static const Field<WebIllustDetailResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<WebIllustDetailResponse> fields = const {
    #error: _f$error,
    #body: _f$body,
    #message: _f$message,
  };

  static WebIllustDetailResponse _instantiate(DecodingData data) {
    return WebIllustDetailResponse(
      data.dec(_f$error),
      data.dec(_f$body),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebIllustDetailResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebIllustDetailResponse>(map);
  }

  static WebIllustDetailResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebIllustDetailResponse>(json);
  }
}

mixin WebIllustDetailResponseMappable {
  String toJson() {
    return WebIllustDetailResponseMapper.ensureInitialized()
        .encodeJson<WebIllustDetailResponse>(this as WebIllustDetailResponse);
  }

  Map<String, dynamic> toMap() {
    return WebIllustDetailResponseMapper.ensureInitialized()
        .encodeMap<WebIllustDetailResponse>(this as WebIllustDetailResponse);
  }

  WebIllustDetailResponseCopyWith<
    WebIllustDetailResponse,
    WebIllustDetailResponse,
    WebIllustDetailResponse
  >
  get copyWith =>
      _WebIllustDetailResponseCopyWithImpl<
        WebIllustDetailResponse,
        WebIllustDetailResponse
      >(this as WebIllustDetailResponse, $identity, $identity);
  @override
  String toString() {
    return WebIllustDetailResponseMapper.ensureInitialized().stringifyValue(
      this as WebIllustDetailResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebIllustDetailResponseMapper.ensureInitialized().equalsValue(
      this as WebIllustDetailResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebIllustDetailResponseMapper.ensureInitialized().hashValue(
      this as WebIllustDetailResponse,
    );
  }
}

extension WebIllustDetailResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebIllustDetailResponse, $Out> {
  WebIllustDetailResponseCopyWith<$R, WebIllustDetailResponse, $Out>
  get $asWebIllustDetailResponse => $base.as(
    (v, t, t2) => _WebIllustDetailResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebIllustDetailResponseCopyWith<
  $R,
  $In extends WebIllustDetailResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebIllustDetailCopyWith<$R, WebIllustDetail, WebIllustDetail> get body;
  $R call({bool? error, WebIllustDetail? body, String? message});
  WebIllustDetailResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebIllustDetailResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebIllustDetailResponse, $Out>
    implements
        WebIllustDetailResponseCopyWith<$R, WebIllustDetailResponse, $Out> {
  _WebIllustDetailResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebIllustDetailResponse> $mapper =
      WebIllustDetailResponseMapper.ensureInitialized();
  @override
  WebIllustDetailCopyWith<$R, WebIllustDetail, WebIllustDetail> get body =>
      $value.body.copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, WebIllustDetail? body, String? message}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (body != null) #body: body,
      if (message != null) #message: message,
    }),
  );
  @override
  WebIllustDetailResponse $make(CopyWithData data) => WebIllustDetailResponse(
    data.get(#error, or: $value.error),
    data.get(#body, or: $value.body),
    message: data.get(#message, or: $value.message),
  );

  @override
  WebIllustDetailResponseCopyWith<$R2, WebIllustDetailResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebIllustDetailResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebPageUrlsMapper extends ClassMapperBase<WebPageUrls> {
  WebPageUrlsMapper._();

  static WebPageUrlsMapper? _instance;
  static WebPageUrlsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebPageUrlsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebPageUrls';

  static String _$thumbMini(WebPageUrls v) => v.thumbMini;
  static const Field<WebPageUrls, String> _f$thumbMini = Field(
    'thumbMini',
    _$thumbMini,
    key: r'thumb_mini',
    opt: true,
    def: '',
  );
  static String _$small(WebPageUrls v) => v.small;
  static const Field<WebPageUrls, String> _f$small = Field(
    'small',
    _$small,
    opt: true,
    def: '',
  );
  static String _$regular(WebPageUrls v) => v.regular;
  static const Field<WebPageUrls, String> _f$regular = Field(
    'regular',
    _$regular,
    opt: true,
    def: '',
  );
  static String _$original(WebPageUrls v) => v.original;
  static const Field<WebPageUrls, String> _f$original = Field(
    'original',
    _$original,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<WebPageUrls> fields = const {
    #thumbMini: _f$thumbMini,
    #small: _f$small,
    #regular: _f$regular,
    #original: _f$original,
  };

  static WebPageUrls _instantiate(DecodingData data) {
    return WebPageUrls(
      thumbMini: data.dec(_f$thumbMini),
      small: data.dec(_f$small),
      regular: data.dec(_f$regular),
      original: data.dec(_f$original),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebPageUrls fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebPageUrls>(map);
  }

  static WebPageUrls fromJson(String json) {
    return ensureInitialized().decodeJson<WebPageUrls>(json);
  }
}

mixin WebPageUrlsMappable {
  String toJson() {
    return WebPageUrlsMapper.ensureInitialized().encodeJson<WebPageUrls>(
      this as WebPageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return WebPageUrlsMapper.ensureInitialized().encodeMap<WebPageUrls>(
      this as WebPageUrls,
    );
  }

  WebPageUrlsCopyWith<WebPageUrls, WebPageUrls, WebPageUrls> get copyWith =>
      _WebPageUrlsCopyWithImpl<WebPageUrls, WebPageUrls>(
        this as WebPageUrls,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebPageUrlsMapper.ensureInitialized().stringifyValue(
      this as WebPageUrls,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebPageUrlsMapper.ensureInitialized().equalsValue(
      this as WebPageUrls,
      other,
    );
  }

  @override
  int get hashCode {
    return WebPageUrlsMapper.ensureInitialized().hashValue(this as WebPageUrls);
  }
}

extension WebPageUrlsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebPageUrls, $Out> {
  WebPageUrlsCopyWith<$R, WebPageUrls, $Out> get $asWebPageUrls =>
      $base.as((v, t, t2) => _WebPageUrlsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebPageUrlsCopyWith<$R, $In extends WebPageUrls, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? thumbMini,
    String? small,
    String? regular,
    String? original,
  });
  WebPageUrlsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebPageUrlsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebPageUrls, $Out>
    implements WebPageUrlsCopyWith<$R, WebPageUrls, $Out> {
  _WebPageUrlsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebPageUrls> $mapper =
      WebPageUrlsMapper.ensureInitialized();
  @override
  $R call({
    String? thumbMini,
    String? small,
    String? regular,
    String? original,
  }) => $apply(
    FieldCopyWithData({
      if (thumbMini != null) #thumbMini: thumbMini,
      if (small != null) #small: small,
      if (regular != null) #regular: regular,
      if (original != null) #original: original,
    }),
  );
  @override
  WebPageUrls $make(CopyWithData data) => WebPageUrls(
    thumbMini: data.get(#thumbMini, or: $value.thumbMini),
    small: data.get(#small, or: $value.small),
    regular: data.get(#regular, or: $value.regular),
    original: data.get(#original, or: $value.original),
  );

  @override
  WebPageUrlsCopyWith<$R2, WebPageUrls, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebPageUrlsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebIllustPageMapper extends ClassMapperBase<WebIllustPage> {
  WebIllustPageMapper._();

  static WebIllustPageMapper? _instance;
  static WebIllustPageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebIllustPageMapper._());
      WebPageUrlsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebIllustPage';

  static WebPageUrls _$urls(WebIllustPage v) => v.urls;
  static const Field<WebIllustPage, WebPageUrls> _f$urls = Field(
    'urls',
    _$urls,
    opt: true,
  );
  static int _$width(WebIllustPage v) => v.width;
  static const Field<WebIllustPage, int> _f$width = Field(
    'width',
    _$width,
    opt: true,
    def: 0,
  );
  static int _$height(WebIllustPage v) => v.height;
  static const Field<WebIllustPage, int> _f$height = Field(
    'height',
    _$height,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<WebIllustPage> fields = const {
    #urls: _f$urls,
    #width: _f$width,
    #height: _f$height,
  };

  static WebIllustPage _instantiate(DecodingData data) {
    return WebIllustPage(
      urls: data.dec(_f$urls),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebIllustPage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebIllustPage>(map);
  }

  static WebIllustPage fromJson(String json) {
    return ensureInitialized().decodeJson<WebIllustPage>(json);
  }
}

mixin WebIllustPageMappable {
  String toJson() {
    return WebIllustPageMapper.ensureInitialized().encodeJson<WebIllustPage>(
      this as WebIllustPage,
    );
  }

  Map<String, dynamic> toMap() {
    return WebIllustPageMapper.ensureInitialized().encodeMap<WebIllustPage>(
      this as WebIllustPage,
    );
  }

  WebIllustPageCopyWith<WebIllustPage, WebIllustPage, WebIllustPage>
  get copyWith => _WebIllustPageCopyWithImpl<WebIllustPage, WebIllustPage>(
    this as WebIllustPage,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebIllustPageMapper.ensureInitialized().stringifyValue(
      this as WebIllustPage,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebIllustPageMapper.ensureInitialized().equalsValue(
      this as WebIllustPage,
      other,
    );
  }

  @override
  int get hashCode {
    return WebIllustPageMapper.ensureInitialized().hashValue(
      this as WebIllustPage,
    );
  }
}

extension WebIllustPageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebIllustPage, $Out> {
  WebIllustPageCopyWith<$R, WebIllustPage, $Out> get $asWebIllustPage =>
      $base.as((v, t, t2) => _WebIllustPageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebIllustPageCopyWith<$R, $In extends WebIllustPage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  WebPageUrlsCopyWith<$R, WebPageUrls, WebPageUrls> get urls;
  $R call({WebPageUrls? urls, int? width, int? height});
  WebIllustPageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebIllustPageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebIllustPage, $Out>
    implements WebIllustPageCopyWith<$R, WebIllustPage, $Out> {
  _WebIllustPageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebIllustPage> $mapper =
      WebIllustPageMapper.ensureInitialized();
  @override
  WebPageUrlsCopyWith<$R, WebPageUrls, WebPageUrls> get urls =>
      ($value.urls as WebPageUrls).copyWith.$chain((v) => call(urls: v));
  @override
  $R call({Object? urls = $none, int? width, int? height}) => $apply(
    FieldCopyWithData({
      if (urls != $none) #urls: urls,
      if (width != null) #width: width,
      if (height != null) #height: height,
    }),
  );
  @override
  WebIllustPage $make(CopyWithData data) => WebIllustPage(
    urls: data.get(#urls, or: $value.urls),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
  );

  @override
  WebIllustPageCopyWith<$R2, WebIllustPage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebIllustPageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebIllustPagesResponseMapper
    extends ClassMapperBase<WebIllustPagesResponse> {
  WebIllustPagesResponseMapper._();

  static WebIllustPagesResponseMapper? _instance;
  static WebIllustPagesResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebIllustPagesResponseMapper._());
      WebIllustPageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebIllustPagesResponse';

  static bool _$error(WebIllustPagesResponse v) => v.error;
  static const Field<WebIllustPagesResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebIllustPagesResponse v) => v.message;
  static const Field<WebIllustPagesResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static List<WebIllustPage> _$body(WebIllustPagesResponse v) => v.body;
  static const Field<WebIllustPagesResponse, List<WebIllustPage>> _f$body =
      Field('body', _$body, opt: true, def: const []);

  @override
  final MappableFields<WebIllustPagesResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebIllustPagesResponse _instantiate(DecodingData data) {
    return WebIllustPagesResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebIllustPagesResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebIllustPagesResponse>(map);
  }

  static WebIllustPagesResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebIllustPagesResponse>(json);
  }
}

mixin WebIllustPagesResponseMappable {
  String toJson() {
    return WebIllustPagesResponseMapper.ensureInitialized()
        .encodeJson<WebIllustPagesResponse>(this as WebIllustPagesResponse);
  }

  Map<String, dynamic> toMap() {
    return WebIllustPagesResponseMapper.ensureInitialized()
        .encodeMap<WebIllustPagesResponse>(this as WebIllustPagesResponse);
  }

  WebIllustPagesResponseCopyWith<
    WebIllustPagesResponse,
    WebIllustPagesResponse,
    WebIllustPagesResponse
  >
  get copyWith =>
      _WebIllustPagesResponseCopyWithImpl<
        WebIllustPagesResponse,
        WebIllustPagesResponse
      >(this as WebIllustPagesResponse, $identity, $identity);
  @override
  String toString() {
    return WebIllustPagesResponseMapper.ensureInitialized().stringifyValue(
      this as WebIllustPagesResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebIllustPagesResponseMapper.ensureInitialized().equalsValue(
      this as WebIllustPagesResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebIllustPagesResponseMapper.ensureInitialized().hashValue(
      this as WebIllustPagesResponse,
    );
  }
}

extension WebIllustPagesResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebIllustPagesResponse, $Out> {
  WebIllustPagesResponseCopyWith<$R, WebIllustPagesResponse, $Out>
  get $asWebIllustPagesResponse => $base.as(
    (v, t, t2) => _WebIllustPagesResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebIllustPagesResponseCopyWith<
  $R,
  $In extends WebIllustPagesResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebIllustPage,
    WebIllustPageCopyWith<$R, WebIllustPage, WebIllustPage>
  >
  get body;
  $R call({bool? error, String? message, List<WebIllustPage>? body});
  WebIllustPagesResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebIllustPagesResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebIllustPagesResponse, $Out>
    implements
        WebIllustPagesResponseCopyWith<$R, WebIllustPagesResponse, $Out> {
  _WebIllustPagesResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebIllustPagesResponse> $mapper =
      WebIllustPagesResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebIllustPage,
    WebIllustPageCopyWith<$R, WebIllustPage, WebIllustPage>
  >
  get body => ListCopyWith(
    $value.body,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(body: v),
  );
  @override
  $R call({bool? error, String? message, List<WebIllustPage>? body}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != null) #body: body,
    }),
  );
  @override
  WebIllustPagesResponse $make(CopyWithData data) => WebIllustPagesResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebIllustPagesResponseCopyWith<$R2, WebIllustPagesResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebIllustPagesResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUgoiraFrameMapper extends ClassMapperBase<WebUgoiraFrame> {
  WebUgoiraFrameMapper._();

  static WebUgoiraFrameMapper? _instance;
  static WebUgoiraFrameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebUgoiraFrameMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebUgoiraFrame';

  static String _$file(WebUgoiraFrame v) => v.file;
  static const Field<WebUgoiraFrame, String> _f$file = Field(
    'file',
    _$file,
    opt: true,
    def: '',
  );
  static int _$delay(WebUgoiraFrame v) => v.delay;
  static const Field<WebUgoiraFrame, int> _f$delay = Field(
    'delay',
    _$delay,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<WebUgoiraFrame> fields = const {
    #file: _f$file,
    #delay: _f$delay,
  };

  static WebUgoiraFrame _instantiate(DecodingData data) {
    return WebUgoiraFrame(file: data.dec(_f$file), delay: data.dec(_f$delay));
  }

  @override
  final Function instantiate = _instantiate;

  static WebUgoiraFrame fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUgoiraFrame>(map);
  }

  static WebUgoiraFrame fromJson(String json) {
    return ensureInitialized().decodeJson<WebUgoiraFrame>(json);
  }
}

mixin WebUgoiraFrameMappable {
  String toJson() {
    return WebUgoiraFrameMapper.ensureInitialized().encodeJson<WebUgoiraFrame>(
      this as WebUgoiraFrame,
    );
  }

  Map<String, dynamic> toMap() {
    return WebUgoiraFrameMapper.ensureInitialized().encodeMap<WebUgoiraFrame>(
      this as WebUgoiraFrame,
    );
  }

  WebUgoiraFrameCopyWith<WebUgoiraFrame, WebUgoiraFrame, WebUgoiraFrame>
  get copyWith => _WebUgoiraFrameCopyWithImpl<WebUgoiraFrame, WebUgoiraFrame>(
    this as WebUgoiraFrame,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebUgoiraFrameMapper.ensureInitialized().stringifyValue(
      this as WebUgoiraFrame,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUgoiraFrameMapper.ensureInitialized().equalsValue(
      this as WebUgoiraFrame,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUgoiraFrameMapper.ensureInitialized().hashValue(
      this as WebUgoiraFrame,
    );
  }
}

extension WebUgoiraFrameValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUgoiraFrame, $Out> {
  WebUgoiraFrameCopyWith<$R, WebUgoiraFrame, $Out> get $asWebUgoiraFrame =>
      $base.as((v, t, t2) => _WebUgoiraFrameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebUgoiraFrameCopyWith<$R, $In extends WebUgoiraFrame, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? file, int? delay});
  WebUgoiraFrameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUgoiraFrameCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUgoiraFrame, $Out>
    implements WebUgoiraFrameCopyWith<$R, WebUgoiraFrame, $Out> {
  _WebUgoiraFrameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUgoiraFrame> $mapper =
      WebUgoiraFrameMapper.ensureInitialized();
  @override
  $R call({String? file, int? delay}) => $apply(
    FieldCopyWithData({
      if (file != null) #file: file,
      if (delay != null) #delay: delay,
    }),
  );
  @override
  WebUgoiraFrame $make(CopyWithData data) => WebUgoiraFrame(
    file: data.get(#file, or: $value.file),
    delay: data.get(#delay, or: $value.delay),
  );

  @override
  WebUgoiraFrameCopyWith<$R2, WebUgoiraFrame, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebUgoiraFrameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUgoiraMetaMapper extends ClassMapperBase<WebUgoiraMeta> {
  WebUgoiraMetaMapper._();

  static WebUgoiraMetaMapper? _instance;
  static WebUgoiraMetaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebUgoiraMetaMapper._());
      WebUgoiraFrameMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebUgoiraMeta';

  static String _$src(WebUgoiraMeta v) => v.src;
  static const Field<WebUgoiraMeta, String> _f$src = Field(
    'src',
    _$src,
    opt: true,
    def: '',
  );
  static String _$originalSrc(WebUgoiraMeta v) => v.originalSrc;
  static const Field<WebUgoiraMeta, String> _f$originalSrc = Field(
    'originalSrc',
    _$originalSrc,
    opt: true,
    def: '',
  );
  static String _$mimeType(WebUgoiraMeta v) => v.mimeType;
  static const Field<WebUgoiraMeta, String> _f$mimeType = Field(
    'mimeType',
    _$mimeType,
    key: r'mime_type',
    opt: true,
    def: '',
  );
  static List<WebUgoiraFrame> _$frames(WebUgoiraMeta v) => v.frames;
  static const Field<WebUgoiraMeta, List<WebUgoiraFrame>> _f$frames = Field(
    'frames',
    _$frames,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<WebUgoiraMeta> fields = const {
    #src: _f$src,
    #originalSrc: _f$originalSrc,
    #mimeType: _f$mimeType,
    #frames: _f$frames,
  };

  static WebUgoiraMeta _instantiate(DecodingData data) {
    return WebUgoiraMeta(
      src: data.dec(_f$src),
      originalSrc: data.dec(_f$originalSrc),
      mimeType: data.dec(_f$mimeType),
      frames: data.dec(_f$frames),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUgoiraMeta fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUgoiraMeta>(map);
  }

  static WebUgoiraMeta fromJson(String json) {
    return ensureInitialized().decodeJson<WebUgoiraMeta>(json);
  }
}

mixin WebUgoiraMetaMappable {
  String toJson() {
    return WebUgoiraMetaMapper.ensureInitialized().encodeJson<WebUgoiraMeta>(
      this as WebUgoiraMeta,
    );
  }

  Map<String, dynamic> toMap() {
    return WebUgoiraMetaMapper.ensureInitialized().encodeMap<WebUgoiraMeta>(
      this as WebUgoiraMeta,
    );
  }

  WebUgoiraMetaCopyWith<WebUgoiraMeta, WebUgoiraMeta, WebUgoiraMeta>
  get copyWith => _WebUgoiraMetaCopyWithImpl<WebUgoiraMeta, WebUgoiraMeta>(
    this as WebUgoiraMeta,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebUgoiraMetaMapper.ensureInitialized().stringifyValue(
      this as WebUgoiraMeta,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUgoiraMetaMapper.ensureInitialized().equalsValue(
      this as WebUgoiraMeta,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUgoiraMetaMapper.ensureInitialized().hashValue(
      this as WebUgoiraMeta,
    );
  }
}

extension WebUgoiraMetaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUgoiraMeta, $Out> {
  WebUgoiraMetaCopyWith<$R, WebUgoiraMeta, $Out> get $asWebUgoiraMeta =>
      $base.as((v, t, t2) => _WebUgoiraMetaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebUgoiraMetaCopyWith<$R, $In extends WebUgoiraMeta, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebUgoiraFrame,
    WebUgoiraFrameCopyWith<$R, WebUgoiraFrame, WebUgoiraFrame>
  >
  get frames;
  $R call({
    String? src,
    String? originalSrc,
    String? mimeType,
    List<WebUgoiraFrame>? frames,
  });
  WebUgoiraMetaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebUgoiraMetaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUgoiraMeta, $Out>
    implements WebUgoiraMetaCopyWith<$R, WebUgoiraMeta, $Out> {
  _WebUgoiraMetaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUgoiraMeta> $mapper =
      WebUgoiraMetaMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebUgoiraFrame,
    WebUgoiraFrameCopyWith<$R, WebUgoiraFrame, WebUgoiraFrame>
  >
  get frames => ListCopyWith(
    $value.frames,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(frames: v),
  );
  @override
  $R call({
    String? src,
    String? originalSrc,
    String? mimeType,
    List<WebUgoiraFrame>? frames,
  }) => $apply(
    FieldCopyWithData({
      if (src != null) #src: src,
      if (originalSrc != null) #originalSrc: originalSrc,
      if (mimeType != null) #mimeType: mimeType,
      if (frames != null) #frames: frames,
    }),
  );
  @override
  WebUgoiraMeta $make(CopyWithData data) => WebUgoiraMeta(
    src: data.get(#src, or: $value.src),
    originalSrc: data.get(#originalSrc, or: $value.originalSrc),
    mimeType: data.get(#mimeType, or: $value.mimeType),
    frames: data.get(#frames, or: $value.frames),
  );

  @override
  WebUgoiraMetaCopyWith<$R2, WebUgoiraMeta, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebUgoiraMetaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUgoiraResponseMapper extends ClassMapperBase<WebUgoiraResponse> {
  WebUgoiraResponseMapper._();

  static WebUgoiraResponseMapper? _instance;
  static WebUgoiraResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebUgoiraResponseMapper._());
      WebUgoiraMetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebUgoiraResponse';

  static bool _$error(WebUgoiraResponse v) => v.error;
  static const Field<WebUgoiraResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebUgoiraResponse v) => v.message;
  static const Field<WebUgoiraResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebUgoiraMeta _$body(WebUgoiraResponse v) => v.body;
  static const Field<WebUgoiraResponse, WebUgoiraMeta> _f$body = Field(
    'body',
    _$body,
    opt: true,
  );

  @override
  final MappableFields<WebUgoiraResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebUgoiraResponse _instantiate(DecodingData data) {
    return WebUgoiraResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUgoiraResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUgoiraResponse>(map);
  }

  static WebUgoiraResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebUgoiraResponse>(json);
  }
}

mixin WebUgoiraResponseMappable {
  String toJson() {
    return WebUgoiraResponseMapper.ensureInitialized()
        .encodeJson<WebUgoiraResponse>(this as WebUgoiraResponse);
  }

  Map<String, dynamic> toMap() {
    return WebUgoiraResponseMapper.ensureInitialized()
        .encodeMap<WebUgoiraResponse>(this as WebUgoiraResponse);
  }

  WebUgoiraResponseCopyWith<
    WebUgoiraResponse,
    WebUgoiraResponse,
    WebUgoiraResponse
  >
  get copyWith =>
      _WebUgoiraResponseCopyWithImpl<WebUgoiraResponse, WebUgoiraResponse>(
        this as WebUgoiraResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebUgoiraResponseMapper.ensureInitialized().stringifyValue(
      this as WebUgoiraResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUgoiraResponseMapper.ensureInitialized().equalsValue(
      this as WebUgoiraResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUgoiraResponseMapper.ensureInitialized().hashValue(
      this as WebUgoiraResponse,
    );
  }
}

extension WebUgoiraResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUgoiraResponse, $Out> {
  WebUgoiraResponseCopyWith<$R, WebUgoiraResponse, $Out>
  get $asWebUgoiraResponse => $base.as(
    (v, t, t2) => _WebUgoiraResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebUgoiraResponseCopyWith<
  $R,
  $In extends WebUgoiraResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebUgoiraMetaCopyWith<$R, WebUgoiraMeta, WebUgoiraMeta> get body;
  $R call({bool? error, String? message, WebUgoiraMeta? body});
  WebUgoiraResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUgoiraResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUgoiraResponse, $Out>
    implements WebUgoiraResponseCopyWith<$R, WebUgoiraResponse, $Out> {
  _WebUgoiraResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUgoiraResponse> $mapper =
      WebUgoiraResponseMapper.ensureInitialized();
  @override
  WebUgoiraMetaCopyWith<$R, WebUgoiraMeta, WebUgoiraMeta> get body =>
      ($value.body as WebUgoiraMeta).copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebUgoiraResponse $make(CopyWithData data) => WebUgoiraResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebUgoiraResponseCopyWith<$R2, WebUgoiraResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebUgoiraResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebRecommendBodyMapper extends ClassMapperBase<WebRecommendBody> {
  WebRecommendBodyMapper._();

  static WebRecommendBodyMapper? _instance;
  static WebRecommendBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebRecommendBodyMapper._());
      WebDiscoveryIllustMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebRecommendBody';

  static List<WebDiscoveryIllust> _$illusts(WebRecommendBody v) => v.illusts;
  static const Field<WebRecommendBody, List<WebDiscoveryIllust>> _f$illusts =
      Field('illusts', _$illusts, opt: true, def: const []);
  static List<String> _$nextIds(WebRecommendBody v) => v.nextIds;
  static const Field<WebRecommendBody, List<String>> _f$nextIds = Field(
    'nextIds',
    _$nextIds,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<WebRecommendBody> fields = const {
    #illusts: _f$illusts,
    #nextIds: _f$nextIds,
  };

  static WebRecommendBody _instantiate(DecodingData data) {
    return WebRecommendBody(
      illusts: data.dec(_f$illusts),
      nextIds: data.dec(_f$nextIds),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebRecommendBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebRecommendBody>(map);
  }

  static WebRecommendBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebRecommendBody>(json);
  }
}

mixin WebRecommendBodyMappable {
  String toJson() {
    return WebRecommendBodyMapper.ensureInitialized()
        .encodeJson<WebRecommendBody>(this as WebRecommendBody);
  }

  Map<String, dynamic> toMap() {
    return WebRecommendBodyMapper.ensureInitialized()
        .encodeMap<WebRecommendBody>(this as WebRecommendBody);
  }

  WebRecommendBodyCopyWith<WebRecommendBody, WebRecommendBody, WebRecommendBody>
  get copyWith =>
      _WebRecommendBodyCopyWithImpl<WebRecommendBody, WebRecommendBody>(
        this as WebRecommendBody,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebRecommendBodyMapper.ensureInitialized().stringifyValue(
      this as WebRecommendBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebRecommendBodyMapper.ensureInitialized().equalsValue(
      this as WebRecommendBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebRecommendBodyMapper.ensureInitialized().hashValue(
      this as WebRecommendBody,
    );
  }
}

extension WebRecommendBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebRecommendBody, $Out> {
  WebRecommendBodyCopyWith<$R, WebRecommendBody, $Out>
  get $asWebRecommendBody =>
      $base.as((v, t, t2) => _WebRecommendBodyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebRecommendBodyCopyWith<$R, $In extends WebRecommendBody, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get illusts;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get nextIds;
  $R call({List<WebDiscoveryIllust>? illusts, List<String>? nextIds});
  WebRecommendBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebRecommendBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebRecommendBody, $Out>
    implements WebRecommendBodyCopyWith<$R, WebRecommendBody, $Out> {
  _WebRecommendBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebRecommendBody> $mapper =
      WebRecommendBodyMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get illusts => ListCopyWith(
    $value.illusts,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(illusts: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get nextIds =>
      ListCopyWith(
        $value.nextIds,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(nextIds: v),
      );
  @override
  $R call({List<WebDiscoveryIllust>? illusts, List<String>? nextIds}) => $apply(
    FieldCopyWithData({
      if (illusts != null) #illusts: illusts,
      if (nextIds != null) #nextIds: nextIds,
    }),
  );
  @override
  WebRecommendBody $make(CopyWithData data) => WebRecommendBody(
    illusts: data.get(#illusts, or: $value.illusts),
    nextIds: data.get(#nextIds, or: $value.nextIds),
  );

  @override
  WebRecommendBodyCopyWith<$R2, WebRecommendBody, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebRecommendBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebRecommendResponseMapper extends ClassMapperBase<WebRecommendResponse> {
  WebRecommendResponseMapper._();

  static WebRecommendResponseMapper? _instance;
  static WebRecommendResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebRecommendResponseMapper._());
      WebRecommendBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebRecommendResponse';

  static bool _$error(WebRecommendResponse v) => v.error;
  static const Field<WebRecommendResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebRecommendResponse v) => v.message;
  static const Field<WebRecommendResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebRecommendBody _$body(WebRecommendResponse v) => v.body;
  static const Field<WebRecommendResponse, WebRecommendBody> _f$body = Field(
    'body',
    _$body,
    opt: true,
  );

  @override
  final MappableFields<WebRecommendResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebRecommendResponse _instantiate(DecodingData data) {
    return WebRecommendResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebRecommendResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebRecommendResponse>(map);
  }

  static WebRecommendResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebRecommendResponse>(json);
  }
}

mixin WebRecommendResponseMappable {
  String toJson() {
    return WebRecommendResponseMapper.ensureInitialized()
        .encodeJson<WebRecommendResponse>(this as WebRecommendResponse);
  }

  Map<String, dynamic> toMap() {
    return WebRecommendResponseMapper.ensureInitialized()
        .encodeMap<WebRecommendResponse>(this as WebRecommendResponse);
  }

  WebRecommendResponseCopyWith<
    WebRecommendResponse,
    WebRecommendResponse,
    WebRecommendResponse
  >
  get copyWith =>
      _WebRecommendResponseCopyWithImpl<
        WebRecommendResponse,
        WebRecommendResponse
      >(this as WebRecommendResponse, $identity, $identity);
  @override
  String toString() {
    return WebRecommendResponseMapper.ensureInitialized().stringifyValue(
      this as WebRecommendResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebRecommendResponseMapper.ensureInitialized().equalsValue(
      this as WebRecommendResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebRecommendResponseMapper.ensureInitialized().hashValue(
      this as WebRecommendResponse,
    );
  }
}

extension WebRecommendResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebRecommendResponse, $Out> {
  WebRecommendResponseCopyWith<$R, WebRecommendResponse, $Out>
  get $asWebRecommendResponse => $base.as(
    (v, t, t2) => _WebRecommendResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebRecommendResponseCopyWith<
  $R,
  $In extends WebRecommendResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebRecommendBodyCopyWith<$R, WebRecommendBody, WebRecommendBody> get body;
  $R call({bool? error, String? message, WebRecommendBody? body});
  WebRecommendResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebRecommendResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebRecommendResponse, $Out>
    implements WebRecommendResponseCopyWith<$R, WebRecommendResponse, $Out> {
  _WebRecommendResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebRecommendResponse> $mapper =
      WebRecommendResponseMapper.ensureInitialized();
  @override
  WebRecommendBodyCopyWith<$R, WebRecommendBody, WebRecommendBody> get body =>
      ($value.body as WebRecommendBody).copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebRecommendResponse $make(CopyWithData data) => WebRecommendResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebRecommendResponseCopyWith<$R2, WebRecommendResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebRecommendResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebFollowPageMapper extends ClassMapperBase<WebFollowPage> {
  WebFollowPageMapper._();

  static WebFollowPageMapper? _instance;
  static WebFollowPageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebFollowPageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebFollowPage';

  static List<String> _$ids(WebFollowPage v) => v.ids;
  static const Field<WebFollowPage, List<String>> _f$ids = Field(
    'ids',
    _$ids,
    opt: true,
    def: const [],
  );
  static bool _$isLastPage(WebFollowPage v) => v.isLastPage;
  static const Field<WebFollowPage, bool> _f$isLastPage = Field(
    'isLastPage',
    _$isLastPage,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<WebFollowPage> fields = const {
    #ids: _f$ids,
    #isLastPage: _f$isLastPage,
  };

  static WebFollowPage _instantiate(DecodingData data) {
    return WebFollowPage(
      ids: data.dec(_f$ids),
      isLastPage: data.dec(_f$isLastPage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebFollowPage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebFollowPage>(map);
  }

  static WebFollowPage fromJson(String json) {
    return ensureInitialized().decodeJson<WebFollowPage>(json);
  }
}

mixin WebFollowPageMappable {
  String toJson() {
    return WebFollowPageMapper.ensureInitialized().encodeJson<WebFollowPage>(
      this as WebFollowPage,
    );
  }

  Map<String, dynamic> toMap() {
    return WebFollowPageMapper.ensureInitialized().encodeMap<WebFollowPage>(
      this as WebFollowPage,
    );
  }

  WebFollowPageCopyWith<WebFollowPage, WebFollowPage, WebFollowPage>
  get copyWith => _WebFollowPageCopyWithImpl<WebFollowPage, WebFollowPage>(
    this as WebFollowPage,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebFollowPageMapper.ensureInitialized().stringifyValue(
      this as WebFollowPage,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebFollowPageMapper.ensureInitialized().equalsValue(
      this as WebFollowPage,
      other,
    );
  }

  @override
  int get hashCode {
    return WebFollowPageMapper.ensureInitialized().hashValue(
      this as WebFollowPage,
    );
  }
}

extension WebFollowPageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebFollowPage, $Out> {
  WebFollowPageCopyWith<$R, WebFollowPage, $Out> get $asWebFollowPage =>
      $base.as((v, t, t2) => _WebFollowPageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebFollowPageCopyWith<$R, $In extends WebFollowPage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get ids;
  $R call({List<String>? ids, bool? isLastPage});
  WebFollowPageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebFollowPageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebFollowPage, $Out>
    implements WebFollowPageCopyWith<$R, WebFollowPage, $Out> {
  _WebFollowPageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebFollowPage> $mapper =
      WebFollowPageMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get ids =>
      ListCopyWith(
        $value.ids,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(ids: v),
      );
  @override
  $R call({List<String>? ids, bool? isLastPage}) => $apply(
    FieldCopyWithData({
      if (ids != null) #ids: ids,
      if (isLastPage != null) #isLastPage: isLastPage,
    }),
  );
  @override
  WebFollowPage $make(CopyWithData data) => WebFollowPage(
    ids: data.get(#ids, or: $value.ids),
    isLastPage: data.get(#isLastPage, or: $value.isLastPage),
  );

  @override
  WebFollowPageCopyWith<$R2, WebFollowPage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebFollowPageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebFollowLatestBodyMapper extends ClassMapperBase<WebFollowLatestBody> {
  WebFollowLatestBodyMapper._();

  static WebFollowLatestBodyMapper? _instance;
  static WebFollowLatestBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebFollowLatestBodyMapper._());
      WebFollowPageMapper.ensureInitialized();
      WebDiscoveryThumbnailsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebFollowLatestBody';

  static WebFollowPage _$page(WebFollowLatestBody v) => v.page;
  static const Field<WebFollowLatestBody, WebFollowPage> _f$page = Field(
    'page',
    _$page,
    opt: true,
  );
  static WebDiscoveryThumbnails _$thumbnails(WebFollowLatestBody v) =>
      v.thumbnails;
  static const Field<WebFollowLatestBody, WebDiscoveryThumbnails>
  _f$thumbnails = Field('thumbnails', _$thumbnails, opt: true);

  @override
  final MappableFields<WebFollowLatestBody> fields = const {
    #page: _f$page,
    #thumbnails: _f$thumbnails,
  };

  static WebFollowLatestBody _instantiate(DecodingData data) {
    return WebFollowLatestBody(
      page: data.dec(_f$page),
      thumbnails: data.dec(_f$thumbnails),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebFollowLatestBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebFollowLatestBody>(map);
  }

  static WebFollowLatestBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebFollowLatestBody>(json);
  }
}

mixin WebFollowLatestBodyMappable {
  String toJson() {
    return WebFollowLatestBodyMapper.ensureInitialized()
        .encodeJson<WebFollowLatestBody>(this as WebFollowLatestBody);
  }

  Map<String, dynamic> toMap() {
    return WebFollowLatestBodyMapper.ensureInitialized()
        .encodeMap<WebFollowLatestBody>(this as WebFollowLatestBody);
  }

  WebFollowLatestBodyCopyWith<
    WebFollowLatestBody,
    WebFollowLatestBody,
    WebFollowLatestBody
  >
  get copyWith =>
      _WebFollowLatestBodyCopyWithImpl<
        WebFollowLatestBody,
        WebFollowLatestBody
      >(this as WebFollowLatestBody, $identity, $identity);
  @override
  String toString() {
    return WebFollowLatestBodyMapper.ensureInitialized().stringifyValue(
      this as WebFollowLatestBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebFollowLatestBodyMapper.ensureInitialized().equalsValue(
      this as WebFollowLatestBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebFollowLatestBodyMapper.ensureInitialized().hashValue(
      this as WebFollowLatestBody,
    );
  }
}

extension WebFollowLatestBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebFollowLatestBody, $Out> {
  WebFollowLatestBodyCopyWith<$R, WebFollowLatestBody, $Out>
  get $asWebFollowLatestBody => $base.as(
    (v, t, t2) => _WebFollowLatestBodyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebFollowLatestBodyCopyWith<
  $R,
  $In extends WebFollowLatestBody,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebFollowPageCopyWith<$R, WebFollowPage, WebFollowPage> get page;
  WebDiscoveryThumbnailsCopyWith<
    $R,
    WebDiscoveryThumbnails,
    WebDiscoveryThumbnails
  >
  get thumbnails;
  $R call({WebFollowPage? page, WebDiscoveryThumbnails? thumbnails});
  WebFollowLatestBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebFollowLatestBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebFollowLatestBody, $Out>
    implements WebFollowLatestBodyCopyWith<$R, WebFollowLatestBody, $Out> {
  _WebFollowLatestBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebFollowLatestBody> $mapper =
      WebFollowLatestBodyMapper.ensureInitialized();
  @override
  WebFollowPageCopyWith<$R, WebFollowPage, WebFollowPage> get page =>
      ($value.page as WebFollowPage).copyWith.$chain((v) => call(page: v));
  @override
  WebDiscoveryThumbnailsCopyWith<
    $R,
    WebDiscoveryThumbnails,
    WebDiscoveryThumbnails
  >
  get thumbnails => ($value.thumbnails as WebDiscoveryThumbnails).copyWith
      .$chain((v) => call(thumbnails: v));
  @override
  $R call({Object? page = $none, Object? thumbnails = $none}) => $apply(
    FieldCopyWithData({
      if (page != $none) #page: page,
      if (thumbnails != $none) #thumbnails: thumbnails,
    }),
  );
  @override
  WebFollowLatestBody $make(CopyWithData data) => WebFollowLatestBody(
    page: data.get(#page, or: $value.page),
    thumbnails: data.get(#thumbnails, or: $value.thumbnails),
  );

  @override
  WebFollowLatestBodyCopyWith<$R2, WebFollowLatestBody, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebFollowLatestBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebFollowLatestResponseMapper
    extends ClassMapperBase<WebFollowLatestResponse> {
  WebFollowLatestResponseMapper._();

  static WebFollowLatestResponseMapper? _instance;
  static WebFollowLatestResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebFollowLatestResponseMapper._(),
      );
      WebFollowLatestBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebFollowLatestResponse';

  static bool _$error(WebFollowLatestResponse v) => v.error;
  static const Field<WebFollowLatestResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebFollowLatestResponse v) => v.message;
  static const Field<WebFollowLatestResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebFollowLatestBody _$body(WebFollowLatestResponse v) => v.body;
  static const Field<WebFollowLatestResponse, WebFollowLatestBody> _f$body =
      Field('body', _$body, opt: true);

  @override
  final MappableFields<WebFollowLatestResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebFollowLatestResponse _instantiate(DecodingData data) {
    return WebFollowLatestResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebFollowLatestResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebFollowLatestResponse>(map);
  }

  static WebFollowLatestResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebFollowLatestResponse>(json);
  }
}

mixin WebFollowLatestResponseMappable {
  String toJson() {
    return WebFollowLatestResponseMapper.ensureInitialized()
        .encodeJson<WebFollowLatestResponse>(this as WebFollowLatestResponse);
  }

  Map<String, dynamic> toMap() {
    return WebFollowLatestResponseMapper.ensureInitialized()
        .encodeMap<WebFollowLatestResponse>(this as WebFollowLatestResponse);
  }

  WebFollowLatestResponseCopyWith<
    WebFollowLatestResponse,
    WebFollowLatestResponse,
    WebFollowLatestResponse
  >
  get copyWith =>
      _WebFollowLatestResponseCopyWithImpl<
        WebFollowLatestResponse,
        WebFollowLatestResponse
      >(this as WebFollowLatestResponse, $identity, $identity);
  @override
  String toString() {
    return WebFollowLatestResponseMapper.ensureInitialized().stringifyValue(
      this as WebFollowLatestResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebFollowLatestResponseMapper.ensureInitialized().equalsValue(
      this as WebFollowLatestResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebFollowLatestResponseMapper.ensureInitialized().hashValue(
      this as WebFollowLatestResponse,
    );
  }
}

extension WebFollowLatestResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebFollowLatestResponse, $Out> {
  WebFollowLatestResponseCopyWith<$R, WebFollowLatestResponse, $Out>
  get $asWebFollowLatestResponse => $base.as(
    (v, t, t2) => _WebFollowLatestResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebFollowLatestResponseCopyWith<
  $R,
  $In extends WebFollowLatestResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebFollowLatestBodyCopyWith<$R, WebFollowLatestBody, WebFollowLatestBody>
  get body;
  $R call({bool? error, String? message, WebFollowLatestBody? body});
  WebFollowLatestResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebFollowLatestResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebFollowLatestResponse, $Out>
    implements
        WebFollowLatestResponseCopyWith<$R, WebFollowLatestResponse, $Out> {
  _WebFollowLatestResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebFollowLatestResponse> $mapper =
      WebFollowLatestResponseMapper.ensureInitialized();
  @override
  WebFollowLatestBodyCopyWith<$R, WebFollowLatestBody, WebFollowLatestBody>
  get body => ($value.body as WebFollowLatestBody).copyWith.$chain(
    (v) => call(body: v),
  );
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebFollowLatestResponse $make(CopyWithData data) => WebFollowLatestResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebFollowLatestResponseCopyWith<$R2, WebFollowLatestResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebFollowLatestResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebRankingItemMapper extends ClassMapperBase<WebRankingItem> {
  WebRankingItemMapper._();

  static WebRankingItemMapper? _instance;
  static WebRankingItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebRankingItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebRankingItem';

  static int _$illustId(WebRankingItem v) => v.illustId;
  static const Field<WebRankingItem, int> _f$illustId = Field(
    'illustId',
    _$illustId,
    key: r'illust_id',
    opt: true,
    def: 0,
  );
  static String _$title(WebRankingItem v) => v.title;
  static const Field<WebRankingItem, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$url(WebRankingItem v) => v.url;
  static const Field<WebRankingItem, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static int _$rank(WebRankingItem v) => v.rank;
  static const Field<WebRankingItem, int> _f$rank = Field(
    'rank',
    _$rank,
    opt: true,
    def: 0,
  );
  static int _$yesRank(WebRankingItem v) => v.yesRank;
  static const Field<WebRankingItem, int> _f$yesRank = Field(
    'yesRank',
    _$yesRank,
    key: r'yes_rank',
    opt: true,
    def: 0,
  );
  static int _$userId(WebRankingItem v) => v.userId;
  static const Field<WebRankingItem, int> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
    opt: true,
    def: 0,
  );
  static String _$userName(WebRankingItem v) => v.userName;
  static const Field<WebRankingItem, String> _f$userName = Field(
    'userName',
    _$userName,
    key: r'user_name',
    opt: true,
    def: '',
  );
  static String _$profileImg(WebRankingItem v) => v.profileImg;
  static const Field<WebRankingItem, String> _f$profileImg = Field(
    'profileImg',
    _$profileImg,
    key: r'profile_img',
    opt: true,
    def: '',
  );
  static List<String> _$tags(WebRankingItem v) => v.tags;
  static const Field<WebRankingItem, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
    def: const [],
  );
  static String _$illustType(WebRankingItem v) => v.illustType;
  static const Field<WebRankingItem, String> _f$illustType = Field(
    'illustType',
    _$illustType,
    key: r'illust_type',
    opt: true,
    def: '',
  );
  static String _$illustPageCount(WebRankingItem v) => v.illustPageCount;
  static const Field<WebRankingItem, String> _f$illustPageCount = Field(
    'illustPageCount',
    _$illustPageCount,
    key: r'illust_page_count',
    opt: true,
    def: '',
  );
  static String _$illustBookStyle(WebRankingItem v) => v.illustBookStyle;
  static const Field<WebRankingItem, String> _f$illustBookStyle = Field(
    'illustBookStyle',
    _$illustBookStyle,
    key: r'illust_book_style',
    opt: true,
    def: '',
  );
  static int _$width(WebRankingItem v) => v.width;
  static const Field<WebRankingItem, int> _f$width = Field(
    'width',
    _$width,
    opt: true,
    def: 0,
  );
  static int _$height(WebRankingItem v) => v.height;
  static const Field<WebRankingItem, int> _f$height = Field(
    'height',
    _$height,
    opt: true,
    def: 0,
  );
  static int _$ratingCount(WebRankingItem v) => v.ratingCount;
  static const Field<WebRankingItem, int> _f$ratingCount = Field(
    'ratingCount',
    _$ratingCount,
    key: r'rating_count',
    opt: true,
    def: 0,
  );
  static int _$viewCount(WebRankingItem v) => v.viewCount;
  static const Field<WebRankingItem, int> _f$viewCount = Field(
    'viewCount',
    _$viewCount,
    key: r'view_count',
    opt: true,
    def: 0,
  );
  static int _$illustUploadTimestamp(WebRankingItem v) =>
      v.illustUploadTimestamp;
  static const Field<WebRankingItem, int> _f$illustUploadTimestamp = Field(
    'illustUploadTimestamp',
    _$illustUploadTimestamp,
    key: r'illust_upload_timestamp',
    opt: true,
    def: 0,
  );
  static String _$date(WebRankingItem v) => v.date;
  static const Field<WebRankingItem, String> _f$date = Field(
    'date',
    _$date,
    opt: true,
    def: '',
  );
  static String _$attr(WebRankingItem v) => v.attr;
  static const Field<WebRankingItem, String> _f$attr = Field(
    'attr',
    _$attr,
    opt: true,
    def: '',
  );
  static bool _$isMasked(WebRankingItem v) => v.isMasked;
  static const Field<WebRankingItem, bool> _f$isMasked = Field(
    'isMasked',
    _$isMasked,
    key: r'is_masked',
    opt: true,
    def: false,
  );
  static bool _$isBookmarked(WebRankingItem v) => v.isBookmarked;
  static const Field<WebRankingItem, bool> _f$isBookmarked = Field(
    'isBookmarked',
    _$isBookmarked,
    key: r'is_bookmarked',
    opt: true,
    def: false,
  );
  static bool _$bookmarkable(WebRankingItem v) => v.bookmarkable;
  static const Field<WebRankingItem, bool> _f$bookmarkable = Field(
    'bookmarkable',
    _$bookmarkable,
    opt: true,
    def: false,
  );
  static Map<String, dynamic>? _$illustContentType(WebRankingItem v) =>
      v.illustContentType;
  static const Field<WebRankingItem, Map<String, dynamic>>
  _f$illustContentType = Field(
    'illustContentType',
    _$illustContentType,
    key: r'illust_content_type',
    opt: true,
  );
  static dynamic _$illustSeries(WebRankingItem v) => v.illustSeries;
  static const Field<WebRankingItem, dynamic> _f$illustSeries = Field(
    'illustSeries',
    _$illustSeries,
    key: r'illust_series',
    opt: true,
  );

  @override
  final MappableFields<WebRankingItem> fields = const {
    #illustId: _f$illustId,
    #title: _f$title,
    #url: _f$url,
    #rank: _f$rank,
    #yesRank: _f$yesRank,
    #userId: _f$userId,
    #userName: _f$userName,
    #profileImg: _f$profileImg,
    #tags: _f$tags,
    #illustType: _f$illustType,
    #illustPageCount: _f$illustPageCount,
    #illustBookStyle: _f$illustBookStyle,
    #width: _f$width,
    #height: _f$height,
    #ratingCount: _f$ratingCount,
    #viewCount: _f$viewCount,
    #illustUploadTimestamp: _f$illustUploadTimestamp,
    #date: _f$date,
    #attr: _f$attr,
    #isMasked: _f$isMasked,
    #isBookmarked: _f$isBookmarked,
    #bookmarkable: _f$bookmarkable,
    #illustContentType: _f$illustContentType,
    #illustSeries: _f$illustSeries,
  };

  static WebRankingItem _instantiate(DecodingData data) {
    return WebRankingItem(
      illustId: data.dec(_f$illustId),
      title: data.dec(_f$title),
      url: data.dec(_f$url),
      rank: data.dec(_f$rank),
      yesRank: data.dec(_f$yesRank),
      userId: data.dec(_f$userId),
      userName: data.dec(_f$userName),
      profileImg: data.dec(_f$profileImg),
      tags: data.dec(_f$tags),
      illustType: data.dec(_f$illustType),
      illustPageCount: data.dec(_f$illustPageCount),
      illustBookStyle: data.dec(_f$illustBookStyle),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
      ratingCount: data.dec(_f$ratingCount),
      viewCount: data.dec(_f$viewCount),
      illustUploadTimestamp: data.dec(_f$illustUploadTimestamp),
      date: data.dec(_f$date),
      attr: data.dec(_f$attr),
      isMasked: data.dec(_f$isMasked),
      isBookmarked: data.dec(_f$isBookmarked),
      bookmarkable: data.dec(_f$bookmarkable),
      illustContentType: data.dec(_f$illustContentType),
      illustSeries: data.dec(_f$illustSeries),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebRankingItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebRankingItem>(map);
  }

  static WebRankingItem fromJson(String json) {
    return ensureInitialized().decodeJson<WebRankingItem>(json);
  }
}

mixin WebRankingItemMappable {
  String toJson() {
    return WebRankingItemMapper.ensureInitialized().encodeJson<WebRankingItem>(
      this as WebRankingItem,
    );
  }

  Map<String, dynamic> toMap() {
    return WebRankingItemMapper.ensureInitialized().encodeMap<WebRankingItem>(
      this as WebRankingItem,
    );
  }

  WebRankingItemCopyWith<WebRankingItem, WebRankingItem, WebRankingItem>
  get copyWith => _WebRankingItemCopyWithImpl<WebRankingItem, WebRankingItem>(
    this as WebRankingItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebRankingItemMapper.ensureInitialized().stringifyValue(
      this as WebRankingItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebRankingItemMapper.ensureInitialized().equalsValue(
      this as WebRankingItem,
      other,
    );
  }

  @override
  int get hashCode {
    return WebRankingItemMapper.ensureInitialized().hashValue(
      this as WebRankingItem,
    );
  }
}

extension WebRankingItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebRankingItem, $Out> {
  WebRankingItemCopyWith<$R, WebRankingItem, $Out> get $asWebRankingItem =>
      $base.as((v, t, t2) => _WebRankingItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebRankingItemCopyWith<$R, $In extends WebRankingItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get illustContentType;
  $R call({
    int? illustId,
    String? title,
    String? url,
    int? rank,
    int? yesRank,
    int? userId,
    String? userName,
    String? profileImg,
    List<String>? tags,
    String? illustType,
    String? illustPageCount,
    String? illustBookStyle,
    int? width,
    int? height,
    int? ratingCount,
    int? viewCount,
    int? illustUploadTimestamp,
    String? date,
    String? attr,
    bool? isMasked,
    bool? isBookmarked,
    bool? bookmarkable,
    Map<String, dynamic>? illustContentType,
    dynamic illustSeries,
  });
  WebRankingItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebRankingItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebRankingItem, $Out>
    implements WebRankingItemCopyWith<$R, WebRankingItem, $Out> {
  _WebRankingItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebRankingItem> $mapper =
      WebRankingItemMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags =>
      ListCopyWith(
        $value.tags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tags: v),
      );
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get illustContentType => $value.illustContentType != null
      ? MapCopyWith(
          $value.illustContentType!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(illustContentType: v),
        )
      : null;
  @override
  $R call({
    int? illustId,
    String? title,
    String? url,
    int? rank,
    int? yesRank,
    int? userId,
    String? userName,
    String? profileImg,
    List<String>? tags,
    String? illustType,
    String? illustPageCount,
    String? illustBookStyle,
    int? width,
    int? height,
    int? ratingCount,
    int? viewCount,
    int? illustUploadTimestamp,
    String? date,
    String? attr,
    bool? isMasked,
    bool? isBookmarked,
    bool? bookmarkable,
    Object? illustContentType = $none,
    Object? illustSeries = $none,
  }) => $apply(
    FieldCopyWithData({
      if (illustId != null) #illustId: illustId,
      if (title != null) #title: title,
      if (url != null) #url: url,
      if (rank != null) #rank: rank,
      if (yesRank != null) #yesRank: yesRank,
      if (userId != null) #userId: userId,
      if (userName != null) #userName: userName,
      if (profileImg != null) #profileImg: profileImg,
      if (tags != null) #tags: tags,
      if (illustType != null) #illustType: illustType,
      if (illustPageCount != null) #illustPageCount: illustPageCount,
      if (illustBookStyle != null) #illustBookStyle: illustBookStyle,
      if (width != null) #width: width,
      if (height != null) #height: height,
      if (ratingCount != null) #ratingCount: ratingCount,
      if (viewCount != null) #viewCount: viewCount,
      if (illustUploadTimestamp != null)
        #illustUploadTimestamp: illustUploadTimestamp,
      if (date != null) #date: date,
      if (attr != null) #attr: attr,
      if (isMasked != null) #isMasked: isMasked,
      if (isBookmarked != null) #isBookmarked: isBookmarked,
      if (bookmarkable != null) #bookmarkable: bookmarkable,
      if (illustContentType != $none) #illustContentType: illustContentType,
      if (illustSeries != $none) #illustSeries: illustSeries,
    }),
  );
  @override
  WebRankingItem $make(CopyWithData data) => WebRankingItem(
    illustId: data.get(#illustId, or: $value.illustId),
    title: data.get(#title, or: $value.title),
    url: data.get(#url, or: $value.url),
    rank: data.get(#rank, or: $value.rank),
    yesRank: data.get(#yesRank, or: $value.yesRank),
    userId: data.get(#userId, or: $value.userId),
    userName: data.get(#userName, or: $value.userName),
    profileImg: data.get(#profileImg, or: $value.profileImg),
    tags: data.get(#tags, or: $value.tags),
    illustType: data.get(#illustType, or: $value.illustType),
    illustPageCount: data.get(#illustPageCount, or: $value.illustPageCount),
    illustBookStyle: data.get(#illustBookStyle, or: $value.illustBookStyle),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
    ratingCount: data.get(#ratingCount, or: $value.ratingCount),
    viewCount: data.get(#viewCount, or: $value.viewCount),
    illustUploadTimestamp: data.get(
      #illustUploadTimestamp,
      or: $value.illustUploadTimestamp,
    ),
    date: data.get(#date, or: $value.date),
    attr: data.get(#attr, or: $value.attr),
    isMasked: data.get(#isMasked, or: $value.isMasked),
    isBookmarked: data.get(#isBookmarked, or: $value.isBookmarked),
    bookmarkable: data.get(#bookmarkable, or: $value.bookmarkable),
    illustContentType: data.get(
      #illustContentType,
      or: $value.illustContentType,
    ),
    illustSeries: data.get(#illustSeries, or: $value.illustSeries),
  );

  @override
  WebRankingItemCopyWith<$R2, WebRankingItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebRankingItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebRankingResponseMapper extends ClassMapperBase<WebRankingResponse> {
  WebRankingResponseMapper._();

  static WebRankingResponseMapper? _instance;
  static WebRankingResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebRankingResponseMapper._());
      WebRankingItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebRankingResponse';

  static List<WebRankingItem> _$contents(WebRankingResponse v) => v.contents;
  static const Field<WebRankingResponse, List<WebRankingItem>> _f$contents =
      Field('contents', _$contents, opt: true, def: const []);
  static String _$mode(WebRankingResponse v) => v.mode;
  static const Field<WebRankingResponse, String> _f$mode = Field(
    'mode',
    _$mode,
    opt: true,
    def: '',
  );
  static String _$content(WebRankingResponse v) => v.content;
  static const Field<WebRankingResponse, String> _f$content = Field(
    'content',
    _$content,
    opt: true,
    def: '',
  );
  static int _$page(WebRankingResponse v) => v.page;
  static const Field<WebRankingResponse, int> _f$page = Field(
    'page',
    _$page,
    opt: true,
    def: 0,
  );
  static dynamic _$prev(WebRankingResponse v) => v.prev;
  static const Field<WebRankingResponse, dynamic> _f$prev = Field(
    'prev',
    _$prev,
    opt: true,
  );
  static dynamic _$next(WebRankingResponse v) => v.next;
  static const Field<WebRankingResponse, dynamic> _f$next = Field(
    'next',
    _$next,
    opt: true,
  );
  static String _$date(WebRankingResponse v) => v.date;
  static const Field<WebRankingResponse, String> _f$date = Field(
    'date',
    _$date,
    opt: true,
    def: '',
  );
  static String _$prevDate(WebRankingResponse v) => v.prevDate;
  static const Field<WebRankingResponse, String> _f$prevDate = Field(
    'prevDate',
    _$prevDate,
    key: r'prev_date',
    opt: true,
    def: '',
  );
  static String _$nextDate(WebRankingResponse v) => v.nextDate;
  static const Field<WebRankingResponse, String> _f$nextDate = Field(
    'nextDate',
    _$nextDate,
    key: r'next_date',
    opt: true,
    def: '',
  );
  static int _$rankTotal(WebRankingResponse v) => v.rankTotal;
  static const Field<WebRankingResponse, int> _f$rankTotal = Field(
    'rankTotal',
    _$rankTotal,
    key: r'rank_total',
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<WebRankingResponse> fields = const {
    #contents: _f$contents,
    #mode: _f$mode,
    #content: _f$content,
    #page: _f$page,
    #prev: _f$prev,
    #next: _f$next,
    #date: _f$date,
    #prevDate: _f$prevDate,
    #nextDate: _f$nextDate,
    #rankTotal: _f$rankTotal,
  };

  static WebRankingResponse _instantiate(DecodingData data) {
    return WebRankingResponse(
      contents: data.dec(_f$contents),
      mode: data.dec(_f$mode),
      content: data.dec(_f$content),
      page: data.dec(_f$page),
      prev: data.dec(_f$prev),
      next: data.dec(_f$next),
      date: data.dec(_f$date),
      prevDate: data.dec(_f$prevDate),
      nextDate: data.dec(_f$nextDate),
      rankTotal: data.dec(_f$rankTotal),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebRankingResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebRankingResponse>(map);
  }

  static WebRankingResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebRankingResponse>(json);
  }
}

mixin WebRankingResponseMappable {
  String toJson() {
    return WebRankingResponseMapper.ensureInitialized()
        .encodeJson<WebRankingResponse>(this as WebRankingResponse);
  }

  Map<String, dynamic> toMap() {
    return WebRankingResponseMapper.ensureInitialized()
        .encodeMap<WebRankingResponse>(this as WebRankingResponse);
  }

  WebRankingResponseCopyWith<
    WebRankingResponse,
    WebRankingResponse,
    WebRankingResponse
  >
  get copyWith =>
      _WebRankingResponseCopyWithImpl<WebRankingResponse, WebRankingResponse>(
        this as WebRankingResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebRankingResponseMapper.ensureInitialized().stringifyValue(
      this as WebRankingResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebRankingResponseMapper.ensureInitialized().equalsValue(
      this as WebRankingResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebRankingResponseMapper.ensureInitialized().hashValue(
      this as WebRankingResponse,
    );
  }
}

extension WebRankingResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebRankingResponse, $Out> {
  WebRankingResponseCopyWith<$R, WebRankingResponse, $Out>
  get $asWebRankingResponse => $base.as(
    (v, t, t2) => _WebRankingResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebRankingResponseCopyWith<
  $R,
  $In extends WebRankingResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebRankingItem,
    WebRankingItemCopyWith<$R, WebRankingItem, WebRankingItem>
  >
  get contents;
  $R call({
    List<WebRankingItem>? contents,
    String? mode,
    String? content,
    int? page,
    dynamic prev,
    dynamic next,
    String? date,
    String? prevDate,
    String? nextDate,
    int? rankTotal,
  });
  WebRankingResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebRankingResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebRankingResponse, $Out>
    implements WebRankingResponseCopyWith<$R, WebRankingResponse, $Out> {
  _WebRankingResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebRankingResponse> $mapper =
      WebRankingResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebRankingItem,
    WebRankingItemCopyWith<$R, WebRankingItem, WebRankingItem>
  >
  get contents => ListCopyWith(
    $value.contents,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(contents: v),
  );
  @override
  $R call({
    List<WebRankingItem>? contents,
    String? mode,
    String? content,
    int? page,
    Object? prev = $none,
    Object? next = $none,
    String? date,
    String? prevDate,
    String? nextDate,
    int? rankTotal,
  }) => $apply(
    FieldCopyWithData({
      if (contents != null) #contents: contents,
      if (mode != null) #mode: mode,
      if (content != null) #content: content,
      if (page != null) #page: page,
      if (prev != $none) #prev: prev,
      if (next != $none) #next: next,
      if (date != null) #date: date,
      if (prevDate != null) #prevDate: prevDate,
      if (nextDate != null) #nextDate: nextDate,
      if (rankTotal != null) #rankTotal: rankTotal,
    }),
  );
  @override
  WebRankingResponse $make(CopyWithData data) => WebRankingResponse(
    contents: data.get(#contents, or: $value.contents),
    mode: data.get(#mode, or: $value.mode),
    content: data.get(#content, or: $value.content),
    page: data.get(#page, or: $value.page),
    prev: data.get(#prev, or: $value.prev),
    next: data.get(#next, or: $value.next),
    date: data.get(#date, or: $value.date),
    prevDate: data.get(#prevDate, or: $value.prevDate),
    nextDate: data.get(#nextDate, or: $value.nextDate),
    rankTotal: data.get(#rankTotal, or: $value.rankTotal),
  );

  @override
  WebRankingResponseCopyWith<$R2, WebRankingResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebRankingResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebSearchIllustMangaMapper extends ClassMapperBase<WebSearchIllustManga> {
  WebSearchIllustMangaMapper._();

  static WebSearchIllustMangaMapper? _instance;
  static WebSearchIllustMangaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebSearchIllustMangaMapper._());
      WebDiscoveryIllustMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebSearchIllustManga';

  static List<WebDiscoveryIllust> _$data(WebSearchIllustManga v) => v.data;
  static const Field<WebSearchIllustManga, List<WebDiscoveryIllust>> _f$data =
      Field('data', _$data, opt: true, def: const []);
  static int _$total(WebSearchIllustManga v) => v.total;
  static const Field<WebSearchIllustManga, int> _f$total = Field(
    'total',
    _$total,
    opt: true,
    def: 0,
  );
  static int _$lastPage(WebSearchIllustManga v) => v.lastPage;
  static const Field<WebSearchIllustManga, int> _f$lastPage = Field(
    'lastPage',
    _$lastPage,
    opt: true,
    def: 0,
  );
  static List<dynamic> _$bookmarkRanges(WebSearchIllustManga v) =>
      v.bookmarkRanges;
  static const Field<WebSearchIllustManga, List<dynamic>> _f$bookmarkRanges =
      Field('bookmarkRanges', _$bookmarkRanges, opt: true, def: const []);

  @override
  final MappableFields<WebSearchIllustManga> fields = const {
    #data: _f$data,
    #total: _f$total,
    #lastPage: _f$lastPage,
    #bookmarkRanges: _f$bookmarkRanges,
  };

  static WebSearchIllustManga _instantiate(DecodingData data) {
    return WebSearchIllustManga(
      data: data.dec(_f$data),
      total: data.dec(_f$total),
      lastPage: data.dec(_f$lastPage),
      bookmarkRanges: data.dec(_f$bookmarkRanges),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebSearchIllustManga fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebSearchIllustManga>(map);
  }

  static WebSearchIllustManga fromJson(String json) {
    return ensureInitialized().decodeJson<WebSearchIllustManga>(json);
  }
}

mixin WebSearchIllustMangaMappable {
  String toJson() {
    return WebSearchIllustMangaMapper.ensureInitialized()
        .encodeJson<WebSearchIllustManga>(this as WebSearchIllustManga);
  }

  Map<String, dynamic> toMap() {
    return WebSearchIllustMangaMapper.ensureInitialized()
        .encodeMap<WebSearchIllustManga>(this as WebSearchIllustManga);
  }

  WebSearchIllustMangaCopyWith<
    WebSearchIllustManga,
    WebSearchIllustManga,
    WebSearchIllustManga
  >
  get copyWith =>
      _WebSearchIllustMangaCopyWithImpl<
        WebSearchIllustManga,
        WebSearchIllustManga
      >(this as WebSearchIllustManga, $identity, $identity);
  @override
  String toString() {
    return WebSearchIllustMangaMapper.ensureInitialized().stringifyValue(
      this as WebSearchIllustManga,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebSearchIllustMangaMapper.ensureInitialized().equalsValue(
      this as WebSearchIllustManga,
      other,
    );
  }

  @override
  int get hashCode {
    return WebSearchIllustMangaMapper.ensureInitialized().hashValue(
      this as WebSearchIllustManga,
    );
  }
}

extension WebSearchIllustMangaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebSearchIllustManga, $Out> {
  WebSearchIllustMangaCopyWith<$R, WebSearchIllustManga, $Out>
  get $asWebSearchIllustManga => $base.as(
    (v, t, t2) => _WebSearchIllustMangaCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebSearchIllustMangaCopyWith<
  $R,
  $In extends WebSearchIllustManga,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get data;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get bookmarkRanges;
  $R call({
    List<WebDiscoveryIllust>? data,
    int? total,
    int? lastPage,
    List<dynamic>? bookmarkRanges,
  });
  WebSearchIllustMangaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebSearchIllustMangaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebSearchIllustManga, $Out>
    implements WebSearchIllustMangaCopyWith<$R, WebSearchIllustManga, $Out> {
  _WebSearchIllustMangaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebSearchIllustManga> $mapper =
      WebSearchIllustMangaMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get data => ListCopyWith(
    $value.data,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(data: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get bookmarkRanges => ListCopyWith(
    $value.bookmarkRanges,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(bookmarkRanges: v),
  );
  @override
  $R call({
    List<WebDiscoveryIllust>? data,
    int? total,
    int? lastPage,
    List<dynamic>? bookmarkRanges,
  }) => $apply(
    FieldCopyWithData({
      if (data != null) #data: data,
      if (total != null) #total: total,
      if (lastPage != null) #lastPage: lastPage,
      if (bookmarkRanges != null) #bookmarkRanges: bookmarkRanges,
    }),
  );
  @override
  WebSearchIllustManga $make(CopyWithData data) => WebSearchIllustManga(
    data: data.get(#data, or: $value.data),
    total: data.get(#total, or: $value.total),
    lastPage: data.get(#lastPage, or: $value.lastPage),
    bookmarkRanges: data.get(#bookmarkRanges, or: $value.bookmarkRanges),
  );

  @override
  WebSearchIllustMangaCopyWith<$R2, WebSearchIllustManga, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebSearchIllustMangaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebSearchArtworksBodyMapper
    extends ClassMapperBase<WebSearchArtworksBody> {
  WebSearchArtworksBodyMapper._();

  static WebSearchArtworksBodyMapper? _instance;
  static WebSearchArtworksBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebSearchArtworksBodyMapper._());
      WebSearchIllustMangaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebSearchArtworksBody';

  static WebSearchIllustManga _$illustManga(WebSearchArtworksBody v) =>
      v.illustManga;
  static const Field<WebSearchArtworksBody, WebSearchIllustManga>
  _f$illustManga = Field('illustManga', _$illustManga, opt: true);
  static List<dynamic> _$relatedTags(WebSearchArtworksBody v) => v.relatedTags;
  static const Field<WebSearchArtworksBody, List<dynamic>> _f$relatedTags =
      Field('relatedTags', _$relatedTags, opt: true, def: const []);
  static dynamic _$popular(WebSearchArtworksBody v) => v.popular;
  static const Field<WebSearchArtworksBody, dynamic> _f$popular = Field(
    'popular',
    _$popular,
    opt: true,
  );
  static Map<String, dynamic>? _$tagTranslation(WebSearchArtworksBody v) =>
      v.tagTranslation;
  static const Field<WebSearchArtworksBody, Map<String, dynamic>>
  _f$tagTranslation = Field('tagTranslation', _$tagTranslation, opt: true);

  @override
  final MappableFields<WebSearchArtworksBody> fields = const {
    #illustManga: _f$illustManga,
    #relatedTags: _f$relatedTags,
    #popular: _f$popular,
    #tagTranslation: _f$tagTranslation,
  };

  static WebSearchArtworksBody _instantiate(DecodingData data) {
    return WebSearchArtworksBody(
      illustManga: data.dec(_f$illustManga),
      relatedTags: data.dec(_f$relatedTags),
      popular: data.dec(_f$popular),
      tagTranslation: data.dec(_f$tagTranslation),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebSearchArtworksBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebSearchArtworksBody>(map);
  }

  static WebSearchArtworksBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebSearchArtworksBody>(json);
  }
}

mixin WebSearchArtworksBodyMappable {
  String toJson() {
    return WebSearchArtworksBodyMapper.ensureInitialized()
        .encodeJson<WebSearchArtworksBody>(this as WebSearchArtworksBody);
  }

  Map<String, dynamic> toMap() {
    return WebSearchArtworksBodyMapper.ensureInitialized()
        .encodeMap<WebSearchArtworksBody>(this as WebSearchArtworksBody);
  }

  WebSearchArtworksBodyCopyWith<
    WebSearchArtworksBody,
    WebSearchArtworksBody,
    WebSearchArtworksBody
  >
  get copyWith =>
      _WebSearchArtworksBodyCopyWithImpl<
        WebSearchArtworksBody,
        WebSearchArtworksBody
      >(this as WebSearchArtworksBody, $identity, $identity);
  @override
  String toString() {
    return WebSearchArtworksBodyMapper.ensureInitialized().stringifyValue(
      this as WebSearchArtworksBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebSearchArtworksBodyMapper.ensureInitialized().equalsValue(
      this as WebSearchArtworksBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebSearchArtworksBodyMapper.ensureInitialized().hashValue(
      this as WebSearchArtworksBody,
    );
  }
}

extension WebSearchArtworksBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebSearchArtworksBody, $Out> {
  WebSearchArtworksBodyCopyWith<$R, WebSearchArtworksBody, $Out>
  get $asWebSearchArtworksBody => $base.as(
    (v, t, t2) => _WebSearchArtworksBodyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebSearchArtworksBodyCopyWith<
  $R,
  $In extends WebSearchArtworksBody,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebSearchIllustMangaCopyWith<$R, WebSearchIllustManga, WebSearchIllustManga>
  get illustManga;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get relatedTags;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get tagTranslation;
  $R call({
    WebSearchIllustManga? illustManga,
    List<dynamic>? relatedTags,
    dynamic popular,
    Map<String, dynamic>? tagTranslation,
  });
  WebSearchArtworksBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebSearchArtworksBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebSearchArtworksBody, $Out>
    implements WebSearchArtworksBodyCopyWith<$R, WebSearchArtworksBody, $Out> {
  _WebSearchArtworksBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebSearchArtworksBody> $mapper =
      WebSearchArtworksBodyMapper.ensureInitialized();
  @override
  WebSearchIllustMangaCopyWith<$R, WebSearchIllustManga, WebSearchIllustManga>
  get illustManga => ($value.illustManga as WebSearchIllustManga).copyWith
      .$chain((v) => call(illustManga: v));
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get relatedTags => ListCopyWith(
    $value.relatedTags,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(relatedTags: v),
  );
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get tagTranslation => $value.tagTranslation != null
      ? MapCopyWith(
          $value.tagTranslation!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tagTranslation: v),
        )
      : null;
  @override
  $R call({
    Object? illustManga = $none,
    List<dynamic>? relatedTags,
    Object? popular = $none,
    Object? tagTranslation = $none,
  }) => $apply(
    FieldCopyWithData({
      if (illustManga != $none) #illustManga: illustManga,
      if (relatedTags != null) #relatedTags: relatedTags,
      if (popular != $none) #popular: popular,
      if (tagTranslation != $none) #tagTranslation: tagTranslation,
    }),
  );
  @override
  WebSearchArtworksBody $make(CopyWithData data) => WebSearchArtworksBody(
    illustManga: data.get(#illustManga, or: $value.illustManga),
    relatedTags: data.get(#relatedTags, or: $value.relatedTags),
    popular: data.get(#popular, or: $value.popular),
    tagTranslation: data.get(#tagTranslation, or: $value.tagTranslation),
  );

  @override
  WebSearchArtworksBodyCopyWith<$R2, WebSearchArtworksBody, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebSearchArtworksBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebSearchArtworksResponseMapper
    extends ClassMapperBase<WebSearchArtworksResponse> {
  WebSearchArtworksResponseMapper._();

  static WebSearchArtworksResponseMapper? _instance;
  static WebSearchArtworksResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebSearchArtworksResponseMapper._(),
      );
      WebSearchArtworksBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebSearchArtworksResponse';

  static bool _$error(WebSearchArtworksResponse v) => v.error;
  static const Field<WebSearchArtworksResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebSearchArtworksResponse v) => v.message;
  static const Field<WebSearchArtworksResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebSearchArtworksBody _$body(WebSearchArtworksResponse v) => v.body;
  static const Field<WebSearchArtworksResponse, WebSearchArtworksBody> _f$body =
      Field('body', _$body, opt: true);

  @override
  final MappableFields<WebSearchArtworksResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebSearchArtworksResponse _instantiate(DecodingData data) {
    return WebSearchArtworksResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebSearchArtworksResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebSearchArtworksResponse>(map);
  }

  static WebSearchArtworksResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebSearchArtworksResponse>(json);
  }
}

mixin WebSearchArtworksResponseMappable {
  String toJson() {
    return WebSearchArtworksResponseMapper.ensureInitialized()
        .encodeJson<WebSearchArtworksResponse>(
          this as WebSearchArtworksResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return WebSearchArtworksResponseMapper.ensureInitialized()
        .encodeMap<WebSearchArtworksResponse>(
          this as WebSearchArtworksResponse,
        );
  }

  WebSearchArtworksResponseCopyWith<
    WebSearchArtworksResponse,
    WebSearchArtworksResponse,
    WebSearchArtworksResponse
  >
  get copyWith =>
      _WebSearchArtworksResponseCopyWithImpl<
        WebSearchArtworksResponse,
        WebSearchArtworksResponse
      >(this as WebSearchArtworksResponse, $identity, $identity);
  @override
  String toString() {
    return WebSearchArtworksResponseMapper.ensureInitialized().stringifyValue(
      this as WebSearchArtworksResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebSearchArtworksResponseMapper.ensureInitialized().equalsValue(
      this as WebSearchArtworksResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebSearchArtworksResponseMapper.ensureInitialized().hashValue(
      this as WebSearchArtworksResponse,
    );
  }
}

extension WebSearchArtworksResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebSearchArtworksResponse, $Out> {
  WebSearchArtworksResponseCopyWith<$R, WebSearchArtworksResponse, $Out>
  get $asWebSearchArtworksResponse => $base.as(
    (v, t, t2) => _WebSearchArtworksResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebSearchArtworksResponseCopyWith<
  $R,
  $In extends WebSearchArtworksResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebSearchArtworksBodyCopyWith<
    $R,
    WebSearchArtworksBody,
    WebSearchArtworksBody
  >
  get body;
  $R call({bool? error, String? message, WebSearchArtworksBody? body});
  WebSearchArtworksResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebSearchArtworksResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebSearchArtworksResponse, $Out>
    implements
        WebSearchArtworksResponseCopyWith<$R, WebSearchArtworksResponse, $Out> {
  _WebSearchArtworksResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebSearchArtworksResponse> $mapper =
      WebSearchArtworksResponseMapper.ensureInitialized();
  @override
  WebSearchArtworksBodyCopyWith<
    $R,
    WebSearchArtworksBody,
    WebSearchArtworksBody
  >
  get body => ($value.body as WebSearchArtworksBody).copyWith.$chain(
    (v) => call(body: v),
  );
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebSearchArtworksResponse $make(CopyWithData data) =>
      WebSearchArtworksResponse(
        data.get(#error, or: $value.error),
        message: data.get(#message, or: $value.message),
        body: data.get(#body, or: $value.body),
      );

  @override
  WebSearchArtworksResponseCopyWith<$R2, WebSearchArtworksResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebSearchArtworksResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUserFullMapper extends ClassMapperBase<WebUserFull> {
  WebUserFullMapper._();

  static WebUserFullMapper? _instance;
  static WebUserFullMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebUserFullMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebUserFull';

  static String _$userId(WebUserFull v) => v.userId;
  static const Field<WebUserFull, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
  );
  static String _$name(WebUserFull v) => v.name;
  static const Field<WebUserFull, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$image(WebUserFull v) => v.image;
  static const Field<WebUserFull, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
    def: '',
  );
  static String _$imageBig(WebUserFull v) => v.imageBig;
  static const Field<WebUserFull, String> _f$imageBig = Field(
    'imageBig',
    _$imageBig,
    opt: true,
    def: '',
  );
  static bool _$premium(WebUserFull v) => v.premium;
  static const Field<WebUserFull, bool> _f$premium = Field(
    'premium',
    _$premium,
    opt: true,
    def: false,
  );
  static bool _$isFollowed(WebUserFull v) => v.isFollowed;
  static const Field<WebUserFull, bool> _f$isFollowed = Field(
    'isFollowed',
    _$isFollowed,
    opt: true,
    def: false,
  );
  static bool _$isMypixiv(WebUserFull v) => v.isMypixiv;
  static const Field<WebUserFull, bool> _f$isMypixiv = Field(
    'isMypixiv',
    _$isMypixiv,
    opt: true,
    def: false,
  );
  static bool _$isBlocking(WebUserFull v) => v.isBlocking;
  static const Field<WebUserFull, bool> _f$isBlocking = Field(
    'isBlocking',
    _$isBlocking,
    opt: true,
    def: false,
  );
  static int _$following(WebUserFull v) => v.following;
  static const Field<WebUserFull, int> _f$following = Field(
    'following',
    _$following,
    opt: true,
    def: 0,
  );
  static bool _$followedBack(WebUserFull v) => v.followedBack;
  static const Field<WebUserFull, bool> _f$followedBack = Field(
    'followedBack',
    _$followedBack,
    opt: true,
    def: false,
  );
  static String _$comment(WebUserFull v) => v.comment;
  static const Field<WebUserFull, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
    def: '',
  );
  static String _$commentHtml(WebUserFull v) => v.commentHtml;
  static const Field<WebUserFull, String> _f$commentHtml = Field(
    'commentHtml',
    _$commentHtml,
    opt: true,
    def: '',
  );
  static String? _$webpage(WebUserFull v) => v.webpage;
  static const Field<WebUserFull, String> _f$webpage = Field(
    'webpage',
    _$webpage,
    opt: true,
  );
  static Map<String, dynamic>? _$social(WebUserFull v) => v.social;
  static const Field<WebUserFull, Map<String, dynamic>> _f$social = Field(
    'social',
    _$social,
    opt: true,
  );

  @override
  final MappableFields<WebUserFull> fields = const {
    #userId: _f$userId,
    #name: _f$name,
    #image: _f$image,
    #imageBig: _f$imageBig,
    #premium: _f$premium,
    #isFollowed: _f$isFollowed,
    #isMypixiv: _f$isMypixiv,
    #isBlocking: _f$isBlocking,
    #following: _f$following,
    #followedBack: _f$followedBack,
    #comment: _f$comment,
    #commentHtml: _f$commentHtml,
    #webpage: _f$webpage,
    #social: _f$social,
  };

  static WebUserFull _instantiate(DecodingData data) {
    return WebUserFull(
      userId: data.dec(_f$userId),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      imageBig: data.dec(_f$imageBig),
      premium: data.dec(_f$premium),
      isFollowed: data.dec(_f$isFollowed),
      isMypixiv: data.dec(_f$isMypixiv),
      isBlocking: data.dec(_f$isBlocking),
      following: data.dec(_f$following),
      followedBack: data.dec(_f$followedBack),
      comment: data.dec(_f$comment),
      commentHtml: data.dec(_f$commentHtml),
      webpage: data.dec(_f$webpage),
      social: data.dec(_f$social),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUserFull fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUserFull>(map);
  }

  static WebUserFull fromJson(String json) {
    return ensureInitialized().decodeJson<WebUserFull>(json);
  }
}

mixin WebUserFullMappable {
  String toJson() {
    return WebUserFullMapper.ensureInitialized().encodeJson<WebUserFull>(
      this as WebUserFull,
    );
  }

  Map<String, dynamic> toMap() {
    return WebUserFullMapper.ensureInitialized().encodeMap<WebUserFull>(
      this as WebUserFull,
    );
  }

  WebUserFullCopyWith<WebUserFull, WebUserFull, WebUserFull> get copyWith =>
      _WebUserFullCopyWithImpl<WebUserFull, WebUserFull>(
        this as WebUserFull,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebUserFullMapper.ensureInitialized().stringifyValue(
      this as WebUserFull,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUserFullMapper.ensureInitialized().equalsValue(
      this as WebUserFull,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUserFullMapper.ensureInitialized().hashValue(this as WebUserFull);
  }
}

extension WebUserFullValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUserFull, $Out> {
  WebUserFullCopyWith<$R, WebUserFull, $Out> get $asWebUserFull =>
      $base.as((v, t, t2) => _WebUserFullCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebUserFullCopyWith<$R, $In extends WebUserFull, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get social;
  $R call({
    String? userId,
    String? name,
    String? image,
    String? imageBig,
    bool? premium,
    bool? isFollowed,
    bool? isMypixiv,
    bool? isBlocking,
    int? following,
    bool? followedBack,
    String? comment,
    String? commentHtml,
    String? webpage,
    Map<String, dynamic>? social,
  });
  WebUserFullCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebUserFullCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUserFull, $Out>
    implements WebUserFullCopyWith<$R, WebUserFull, $Out> {
  _WebUserFullCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUserFull> $mapper =
      WebUserFullMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get social => $value.social != null
      ? MapCopyWith(
          $value.social!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(social: v),
        )
      : null;
  @override
  $R call({
    String? userId,
    String? name,
    String? image,
    String? imageBig,
    bool? premium,
    bool? isFollowed,
    bool? isMypixiv,
    bool? isBlocking,
    int? following,
    bool? followedBack,
    String? comment,
    String? commentHtml,
    Object? webpage = $none,
    Object? social = $none,
  }) => $apply(
    FieldCopyWithData({
      if (userId != null) #userId: userId,
      if (name != null) #name: name,
      if (image != null) #image: image,
      if (imageBig != null) #imageBig: imageBig,
      if (premium != null) #premium: premium,
      if (isFollowed != null) #isFollowed: isFollowed,
      if (isMypixiv != null) #isMypixiv: isMypixiv,
      if (isBlocking != null) #isBlocking: isBlocking,
      if (following != null) #following: following,
      if (followedBack != null) #followedBack: followedBack,
      if (comment != null) #comment: comment,
      if (commentHtml != null) #commentHtml: commentHtml,
      if (webpage != $none) #webpage: webpage,
      if (social != $none) #social: social,
    }),
  );
  @override
  WebUserFull $make(CopyWithData data) => WebUserFull(
    userId: data.get(#userId, or: $value.userId),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    imageBig: data.get(#imageBig, or: $value.imageBig),
    premium: data.get(#premium, or: $value.premium),
    isFollowed: data.get(#isFollowed, or: $value.isFollowed),
    isMypixiv: data.get(#isMypixiv, or: $value.isMypixiv),
    isBlocking: data.get(#isBlocking, or: $value.isBlocking),
    following: data.get(#following, or: $value.following),
    followedBack: data.get(#followedBack, or: $value.followedBack),
    comment: data.get(#comment, or: $value.comment),
    commentHtml: data.get(#commentHtml, or: $value.commentHtml),
    webpage: data.get(#webpage, or: $value.webpage),
    social: data.get(#social, or: $value.social),
  );

  @override
  WebUserFullCopyWith<$R2, WebUserFull, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebUserFullCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUserFullResponseMapper extends ClassMapperBase<WebUserFullResponse> {
  WebUserFullResponseMapper._();

  static WebUserFullResponseMapper? _instance;
  static WebUserFullResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebUserFullResponseMapper._());
      WebUserFullMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebUserFullResponse';

  static bool _$error(WebUserFullResponse v) => v.error;
  static const Field<WebUserFullResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebUserFullResponse v) => v.message;
  static const Field<WebUserFullResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebUserFull _$body(WebUserFullResponse v) => v.body;
  static const Field<WebUserFullResponse, WebUserFull> _f$body = Field(
    'body',
    _$body,
    opt: true,
  );

  @override
  final MappableFields<WebUserFullResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebUserFullResponse _instantiate(DecodingData data) {
    return WebUserFullResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUserFullResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUserFullResponse>(map);
  }

  static WebUserFullResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebUserFullResponse>(json);
  }
}

mixin WebUserFullResponseMappable {
  String toJson() {
    return WebUserFullResponseMapper.ensureInitialized()
        .encodeJson<WebUserFullResponse>(this as WebUserFullResponse);
  }

  Map<String, dynamic> toMap() {
    return WebUserFullResponseMapper.ensureInitialized()
        .encodeMap<WebUserFullResponse>(this as WebUserFullResponse);
  }

  WebUserFullResponseCopyWith<
    WebUserFullResponse,
    WebUserFullResponse,
    WebUserFullResponse
  >
  get copyWith =>
      _WebUserFullResponseCopyWithImpl<
        WebUserFullResponse,
        WebUserFullResponse
      >(this as WebUserFullResponse, $identity, $identity);
  @override
  String toString() {
    return WebUserFullResponseMapper.ensureInitialized().stringifyValue(
      this as WebUserFullResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUserFullResponseMapper.ensureInitialized().equalsValue(
      this as WebUserFullResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUserFullResponseMapper.ensureInitialized().hashValue(
      this as WebUserFullResponse,
    );
  }
}

extension WebUserFullResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUserFullResponse, $Out> {
  WebUserFullResponseCopyWith<$R, WebUserFullResponse, $Out>
  get $asWebUserFullResponse => $base.as(
    (v, t, t2) => _WebUserFullResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebUserFullResponseCopyWith<
  $R,
  $In extends WebUserFullResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebUserFullCopyWith<$R, WebUserFull, WebUserFull> get body;
  $R call({bool? error, String? message, WebUserFull? body});
  WebUserFullResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUserFullResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUserFullResponse, $Out>
    implements WebUserFullResponseCopyWith<$R, WebUserFullResponse, $Out> {
  _WebUserFullResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUserFullResponse> $mapper =
      WebUserFullResponseMapper.ensureInitialized();
  @override
  WebUserFullCopyWith<$R, WebUserFull, WebUserFull> get body =>
      ($value.body as WebUserFull).copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebUserFullResponse $make(CopyWithData data) => WebUserFullResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebUserFullResponseCopyWith<$R2, WebUserFullResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebUserFullResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUserWorksAllMapper extends ClassMapperBase<WebUserWorksAll> {
  WebUserWorksAllMapper._();

  static WebUserWorksAllMapper? _instance;
  static WebUserWorksAllMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebUserWorksAllMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebUserWorksAll';

  static Map<String, dynamic> _$illusts(WebUserWorksAll v) => v.illusts;
  static const Field<WebUserWorksAll, Map<String, dynamic>> _f$illusts = Field(
    'illusts',
    _$illusts,
    opt: true,
    def: const {},
  );
  static Map<String, dynamic> _$manga(WebUserWorksAll v) => v.manga;
  static const Field<WebUserWorksAll, Map<String, dynamic>> _f$manga = Field(
    'manga',
    _$manga,
    opt: true,
    def: const {},
  );
  static Map<String, dynamic> _$novels(WebUserWorksAll v) => v.novels;
  static const Field<WebUserWorksAll, Map<String, dynamic>> _f$novels = Field(
    'novels',
    _$novels,
    opt: true,
    def: const {},
  );

  @override
  final MappableFields<WebUserWorksAll> fields = const {
    #illusts: _f$illusts,
    #manga: _f$manga,
    #novels: _f$novels,
  };

  static WebUserWorksAll _instantiate(DecodingData data) {
    return WebUserWorksAll(
      illusts: data.dec(_f$illusts),
      manga: data.dec(_f$manga),
      novels: data.dec(_f$novels),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUserWorksAll fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUserWorksAll>(map);
  }

  static WebUserWorksAll fromJson(String json) {
    return ensureInitialized().decodeJson<WebUserWorksAll>(json);
  }
}

mixin WebUserWorksAllMappable {
  String toJson() {
    return WebUserWorksAllMapper.ensureInitialized()
        .encodeJson<WebUserWorksAll>(this as WebUserWorksAll);
  }

  Map<String, dynamic> toMap() {
    return WebUserWorksAllMapper.ensureInitialized().encodeMap<WebUserWorksAll>(
      this as WebUserWorksAll,
    );
  }

  WebUserWorksAllCopyWith<WebUserWorksAll, WebUserWorksAll, WebUserWorksAll>
  get copyWith =>
      _WebUserWorksAllCopyWithImpl<WebUserWorksAll, WebUserWorksAll>(
        this as WebUserWorksAll,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebUserWorksAllMapper.ensureInitialized().stringifyValue(
      this as WebUserWorksAll,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUserWorksAllMapper.ensureInitialized().equalsValue(
      this as WebUserWorksAll,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUserWorksAllMapper.ensureInitialized().hashValue(
      this as WebUserWorksAll,
    );
  }
}

extension WebUserWorksAllValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUserWorksAll, $Out> {
  WebUserWorksAllCopyWith<$R, WebUserWorksAll, $Out> get $asWebUserWorksAll =>
      $base.as((v, t, t2) => _WebUserWorksAllCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebUserWorksAllCopyWith<$R, $In extends WebUserWorksAll, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get illusts;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get manga;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get novels;
  $R call({
    Map<String, dynamic>? illusts,
    Map<String, dynamic>? manga,
    Map<String, dynamic>? novels,
  });
  WebUserWorksAllCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUserWorksAllCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUserWorksAll, $Out>
    implements WebUserWorksAllCopyWith<$R, WebUserWorksAll, $Out> {
  _WebUserWorksAllCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUserWorksAll> $mapper =
      WebUserWorksAllMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get illusts => MapCopyWith(
    $value.illusts,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(illusts: v),
  );
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get manga => MapCopyWith(
    $value.manga,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(manga: v),
  );
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get novels => MapCopyWith(
    $value.novels,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(novels: v),
  );
  @override
  $R call({
    Map<String, dynamic>? illusts,
    Map<String, dynamic>? manga,
    Map<String, dynamic>? novels,
  }) => $apply(
    FieldCopyWithData({
      if (illusts != null) #illusts: illusts,
      if (manga != null) #manga: manga,
      if (novels != null) #novels: novels,
    }),
  );
  @override
  WebUserWorksAll $make(CopyWithData data) => WebUserWorksAll(
    illusts: data.get(#illusts, or: $value.illusts),
    manga: data.get(#manga, or: $value.manga),
    novels: data.get(#novels, or: $value.novels),
  );

  @override
  WebUserWorksAllCopyWith<$R2, WebUserWorksAll, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebUserWorksAllCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUserWorksAllResponseMapper
    extends ClassMapperBase<WebUserWorksAllResponse> {
  WebUserWorksAllResponseMapper._();

  static WebUserWorksAllResponseMapper? _instance;
  static WebUserWorksAllResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebUserWorksAllResponseMapper._(),
      );
      WebUserWorksAllMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebUserWorksAllResponse';

  static bool _$error(WebUserWorksAllResponse v) => v.error;
  static const Field<WebUserWorksAllResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebUserWorksAllResponse v) => v.message;
  static const Field<WebUserWorksAllResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebUserWorksAll _$body(WebUserWorksAllResponse v) => v.body;
  static const Field<WebUserWorksAllResponse, WebUserWorksAll> _f$body = Field(
    'body',
    _$body,
    opt: true,
  );

  @override
  final MappableFields<WebUserWorksAllResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebUserWorksAllResponse _instantiate(DecodingData data) {
    return WebUserWorksAllResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUserWorksAllResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUserWorksAllResponse>(map);
  }

  static WebUserWorksAllResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebUserWorksAllResponse>(json);
  }
}

mixin WebUserWorksAllResponseMappable {
  String toJson() {
    return WebUserWorksAllResponseMapper.ensureInitialized()
        .encodeJson<WebUserWorksAllResponse>(this as WebUserWorksAllResponse);
  }

  Map<String, dynamic> toMap() {
    return WebUserWorksAllResponseMapper.ensureInitialized()
        .encodeMap<WebUserWorksAllResponse>(this as WebUserWorksAllResponse);
  }

  WebUserWorksAllResponseCopyWith<
    WebUserWorksAllResponse,
    WebUserWorksAllResponse,
    WebUserWorksAllResponse
  >
  get copyWith =>
      _WebUserWorksAllResponseCopyWithImpl<
        WebUserWorksAllResponse,
        WebUserWorksAllResponse
      >(this as WebUserWorksAllResponse, $identity, $identity);
  @override
  String toString() {
    return WebUserWorksAllResponseMapper.ensureInitialized().stringifyValue(
      this as WebUserWorksAllResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUserWorksAllResponseMapper.ensureInitialized().equalsValue(
      this as WebUserWorksAllResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUserWorksAllResponseMapper.ensureInitialized().hashValue(
      this as WebUserWorksAllResponse,
    );
  }
}

extension WebUserWorksAllResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUserWorksAllResponse, $Out> {
  WebUserWorksAllResponseCopyWith<$R, WebUserWorksAllResponse, $Out>
  get $asWebUserWorksAllResponse => $base.as(
    (v, t, t2) => _WebUserWorksAllResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebUserWorksAllResponseCopyWith<
  $R,
  $In extends WebUserWorksAllResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebUserWorksAllCopyWith<$R, WebUserWorksAll, WebUserWorksAll> get body;
  $R call({bool? error, String? message, WebUserWorksAll? body});
  WebUserWorksAllResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUserWorksAllResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUserWorksAllResponse, $Out>
    implements
        WebUserWorksAllResponseCopyWith<$R, WebUserWorksAllResponse, $Out> {
  _WebUserWorksAllResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUserWorksAllResponse> $mapper =
      WebUserWorksAllResponseMapper.ensureInitialized();
  @override
  WebUserWorksAllCopyWith<$R, WebUserWorksAll, WebUserWorksAll> get body =>
      ($value.body as WebUserWorksAll).copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebUserWorksAllResponse $make(CopyWithData data) => WebUserWorksAllResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebUserWorksAllResponseCopyWith<$R2, WebUserWorksAllResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebUserWorksAllResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebCommentMapper extends ClassMapperBase<WebComment> {
  WebCommentMapper._();

  static WebCommentMapper? _instance;
  static WebCommentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebCommentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebComment';

  static String _$id(WebComment v) => v.id;
  static const Field<WebComment, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$userId(WebComment v) => v.userId;
  static const Field<WebComment, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
  );
  static String _$userName(WebComment v) => v.userName;
  static const Field<WebComment, String> _f$userName = Field(
    'userName',
    _$userName,
    opt: true,
    def: '',
  );
  static bool _$isDeletedUser(WebComment v) => v.isDeletedUser;
  static const Field<WebComment, bool> _f$isDeletedUser = Field(
    'isDeletedUser',
    _$isDeletedUser,
    opt: true,
    def: false,
  );
  static String _$img(WebComment v) => v.img;
  static const Field<WebComment, String> _f$img = Field(
    'img',
    _$img,
    opt: true,
    def: '',
  );
  static String _$comment(WebComment v) => v.comment;
  static const Field<WebComment, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
    def: '',
  );
  static String? _$stampId(WebComment v) => v.stampId;
  static const Field<WebComment, String> _f$stampId = Field(
    'stampId',
    _$stampId,
    opt: true,
  );
  static String _$commentDate(WebComment v) => v.commentDate;
  static const Field<WebComment, String> _f$commentDate = Field(
    'commentDate',
    _$commentDate,
    opt: true,
    def: '',
  );
  static String? _$commentParentId(WebComment v) => v.commentParentId;
  static const Field<WebComment, String> _f$commentParentId = Field(
    'commentParentId',
    _$commentParentId,
    opt: true,
  );
  static String? _$commentUserId(WebComment v) => v.commentUserId;
  static const Field<WebComment, String> _f$commentUserId = Field(
    'commentUserId',
    _$commentUserId,
    opt: true,
  );
  static bool _$editable(WebComment v) => v.editable;
  static const Field<WebComment, bool> _f$editable = Field(
    'editable',
    _$editable,
    opt: true,
    def: false,
  );
  static bool _$hasReplies(WebComment v) => v.hasReplies;
  static const Field<WebComment, bool> _f$hasReplies = Field(
    'hasReplies',
    _$hasReplies,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<WebComment> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #userName: _f$userName,
    #isDeletedUser: _f$isDeletedUser,
    #img: _f$img,
    #comment: _f$comment,
    #stampId: _f$stampId,
    #commentDate: _f$commentDate,
    #commentParentId: _f$commentParentId,
    #commentUserId: _f$commentUserId,
    #editable: _f$editable,
    #hasReplies: _f$hasReplies,
  };

  static WebComment _instantiate(DecodingData data) {
    return WebComment(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      userName: data.dec(_f$userName),
      isDeletedUser: data.dec(_f$isDeletedUser),
      img: data.dec(_f$img),
      comment: data.dec(_f$comment),
      stampId: data.dec(_f$stampId),
      commentDate: data.dec(_f$commentDate),
      commentParentId: data.dec(_f$commentParentId),
      commentUserId: data.dec(_f$commentUserId),
      editable: data.dec(_f$editable),
      hasReplies: data.dec(_f$hasReplies),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebComment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebComment>(map);
  }

  static WebComment fromJson(String json) {
    return ensureInitialized().decodeJson<WebComment>(json);
  }
}

mixin WebCommentMappable {
  String toJson() {
    return WebCommentMapper.ensureInitialized().encodeJson<WebComment>(
      this as WebComment,
    );
  }

  Map<String, dynamic> toMap() {
    return WebCommentMapper.ensureInitialized().encodeMap<WebComment>(
      this as WebComment,
    );
  }

  WebCommentCopyWith<WebComment, WebComment, WebComment> get copyWith =>
      _WebCommentCopyWithImpl<WebComment, WebComment>(
        this as WebComment,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebCommentMapper.ensureInitialized().stringifyValue(
      this as WebComment,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebCommentMapper.ensureInitialized().equalsValue(
      this as WebComment,
      other,
    );
  }

  @override
  int get hashCode {
    return WebCommentMapper.ensureInitialized().hashValue(this as WebComment);
  }
}

extension WebCommentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebComment, $Out> {
  WebCommentCopyWith<$R, WebComment, $Out> get $asWebComment =>
      $base.as((v, t, t2) => _WebCommentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebCommentCopyWith<$R, $In extends WebComment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? userName,
    bool? isDeletedUser,
    String? img,
    String? comment,
    String? stampId,
    String? commentDate,
    String? commentParentId,
    String? commentUserId,
    bool? editable,
    bool? hasReplies,
  });
  WebCommentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebCommentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebComment, $Out>
    implements WebCommentCopyWith<$R, WebComment, $Out> {
  _WebCommentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebComment> $mapper =
      WebCommentMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? userName,
    bool? isDeletedUser,
    String? img,
    String? comment,
    Object? stampId = $none,
    String? commentDate,
    Object? commentParentId = $none,
    Object? commentUserId = $none,
    bool? editable,
    bool? hasReplies,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (userName != null) #userName: userName,
      if (isDeletedUser != null) #isDeletedUser: isDeletedUser,
      if (img != null) #img: img,
      if (comment != null) #comment: comment,
      if (stampId != $none) #stampId: stampId,
      if (commentDate != null) #commentDate: commentDate,
      if (commentParentId != $none) #commentParentId: commentParentId,
      if (commentUserId != $none) #commentUserId: commentUserId,
      if (editable != null) #editable: editable,
      if (hasReplies != null) #hasReplies: hasReplies,
    }),
  );
  @override
  WebComment $make(CopyWithData data) => WebComment(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    userName: data.get(#userName, or: $value.userName),
    isDeletedUser: data.get(#isDeletedUser, or: $value.isDeletedUser),
    img: data.get(#img, or: $value.img),
    comment: data.get(#comment, or: $value.comment),
    stampId: data.get(#stampId, or: $value.stampId),
    commentDate: data.get(#commentDate, or: $value.commentDate),
    commentParentId: data.get(#commentParentId, or: $value.commentParentId),
    commentUserId: data.get(#commentUserId, or: $value.commentUserId),
    editable: data.get(#editable, or: $value.editable),
    hasReplies: data.get(#hasReplies, or: $value.hasReplies),
  );

  @override
  WebCommentCopyWith<$R2, WebComment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebCommentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebCommentsBodyMapper extends ClassMapperBase<WebCommentsBody> {
  WebCommentsBodyMapper._();

  static WebCommentsBodyMapper? _instance;
  static WebCommentsBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebCommentsBodyMapper._());
      WebCommentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebCommentsBody';

  static List<WebComment> _$comments(WebCommentsBody v) => v.comments;
  static const Field<WebCommentsBody, List<WebComment>> _f$comments = Field(
    'comments',
    _$comments,
    opt: true,
    def: const [],
  );
  static bool _$hasNext(WebCommentsBody v) => v.hasNext;
  static const Field<WebCommentsBody, bool> _f$hasNext = Field(
    'hasNext',
    _$hasNext,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<WebCommentsBody> fields = const {
    #comments: _f$comments,
    #hasNext: _f$hasNext,
  };

  static WebCommentsBody _instantiate(DecodingData data) {
    return WebCommentsBody(
      comments: data.dec(_f$comments),
      hasNext: data.dec(_f$hasNext),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebCommentsBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebCommentsBody>(map);
  }

  static WebCommentsBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebCommentsBody>(json);
  }
}

mixin WebCommentsBodyMappable {
  String toJson() {
    return WebCommentsBodyMapper.ensureInitialized()
        .encodeJson<WebCommentsBody>(this as WebCommentsBody);
  }

  Map<String, dynamic> toMap() {
    return WebCommentsBodyMapper.ensureInitialized().encodeMap<WebCommentsBody>(
      this as WebCommentsBody,
    );
  }

  WebCommentsBodyCopyWith<WebCommentsBody, WebCommentsBody, WebCommentsBody>
  get copyWith =>
      _WebCommentsBodyCopyWithImpl<WebCommentsBody, WebCommentsBody>(
        this as WebCommentsBody,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebCommentsBodyMapper.ensureInitialized().stringifyValue(
      this as WebCommentsBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebCommentsBodyMapper.ensureInitialized().equalsValue(
      this as WebCommentsBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebCommentsBodyMapper.ensureInitialized().hashValue(
      this as WebCommentsBody,
    );
  }
}

extension WebCommentsBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebCommentsBody, $Out> {
  WebCommentsBodyCopyWith<$R, WebCommentsBody, $Out> get $asWebCommentsBody =>
      $base.as((v, t, t2) => _WebCommentsBodyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebCommentsBodyCopyWith<$R, $In extends WebCommentsBody, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, WebComment, WebCommentCopyWith<$R, WebComment, WebComment>>
  get comments;
  $R call({List<WebComment>? comments, bool? hasNext});
  WebCommentsBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebCommentsBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebCommentsBody, $Out>
    implements WebCommentsBodyCopyWith<$R, WebCommentsBody, $Out> {
  _WebCommentsBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebCommentsBody> $mapper =
      WebCommentsBodyMapper.ensureInitialized();
  @override
  ListCopyWith<$R, WebComment, WebCommentCopyWith<$R, WebComment, WebComment>>
  get comments => ListCopyWith(
    $value.comments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(comments: v),
  );
  @override
  $R call({List<WebComment>? comments, bool? hasNext}) => $apply(
    FieldCopyWithData({
      if (comments != null) #comments: comments,
      if (hasNext != null) #hasNext: hasNext,
    }),
  );
  @override
  WebCommentsBody $make(CopyWithData data) => WebCommentsBody(
    comments: data.get(#comments, or: $value.comments),
    hasNext: data.get(#hasNext, or: $value.hasNext),
  );

  @override
  WebCommentsBodyCopyWith<$R2, WebCommentsBody, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebCommentsBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebCommentsResponseMapper extends ClassMapperBase<WebCommentsResponse> {
  WebCommentsResponseMapper._();

  static WebCommentsResponseMapper? _instance;
  static WebCommentsResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebCommentsResponseMapper._());
      WebCommentsBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebCommentsResponse';

  static bool _$error(WebCommentsResponse v) => v.error;
  static const Field<WebCommentsResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebCommentsResponse v) => v.message;
  static const Field<WebCommentsResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebCommentsBody _$body(WebCommentsResponse v) => v.body;
  static const Field<WebCommentsResponse, WebCommentsBody> _f$body = Field(
    'body',
    _$body,
    opt: true,
  );

  @override
  final MappableFields<WebCommentsResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebCommentsResponse _instantiate(DecodingData data) {
    return WebCommentsResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebCommentsResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebCommentsResponse>(map);
  }

  static WebCommentsResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebCommentsResponse>(json);
  }
}

mixin WebCommentsResponseMappable {
  String toJson() {
    return WebCommentsResponseMapper.ensureInitialized()
        .encodeJson<WebCommentsResponse>(this as WebCommentsResponse);
  }

  Map<String, dynamic> toMap() {
    return WebCommentsResponseMapper.ensureInitialized()
        .encodeMap<WebCommentsResponse>(this as WebCommentsResponse);
  }

  WebCommentsResponseCopyWith<
    WebCommentsResponse,
    WebCommentsResponse,
    WebCommentsResponse
  >
  get copyWith =>
      _WebCommentsResponseCopyWithImpl<
        WebCommentsResponse,
        WebCommentsResponse
      >(this as WebCommentsResponse, $identity, $identity);
  @override
  String toString() {
    return WebCommentsResponseMapper.ensureInitialized().stringifyValue(
      this as WebCommentsResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebCommentsResponseMapper.ensureInitialized().equalsValue(
      this as WebCommentsResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebCommentsResponseMapper.ensureInitialized().hashValue(
      this as WebCommentsResponse,
    );
  }
}

extension WebCommentsResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebCommentsResponse, $Out> {
  WebCommentsResponseCopyWith<$R, WebCommentsResponse, $Out>
  get $asWebCommentsResponse => $base.as(
    (v, t, t2) => _WebCommentsResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebCommentsResponseCopyWith<
  $R,
  $In extends WebCommentsResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebCommentsBodyCopyWith<$R, WebCommentsBody, WebCommentsBody> get body;
  $R call({bool? error, String? message, WebCommentsBody? body});
  WebCommentsResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebCommentsResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebCommentsResponse, $Out>
    implements WebCommentsResponseCopyWith<$R, WebCommentsResponse, $Out> {
  _WebCommentsResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebCommentsResponse> $mapper =
      WebCommentsResponseMapper.ensureInitialized();
  @override
  WebCommentsBodyCopyWith<$R, WebCommentsBody, WebCommentsBody> get body =>
      ($value.body as WebCommentsBody).copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebCommentsResponse $make(CopyWithData data) => WebCommentsResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebCommentsResponseCopyWith<$R2, WebCommentsResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebCommentsResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUserProfileWorksBodyMapper
    extends ClassMapperBase<WebUserProfileWorksBody> {
  WebUserProfileWorksBodyMapper._();

  static WebUserProfileWorksBodyMapper? _instance;
  static WebUserProfileWorksBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebUserProfileWorksBodyMapper._(),
      );
      WebDiscoveryIllustMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebUserProfileWorksBody';

  static Map<String, WebDiscoveryIllust> _$works(WebUserProfileWorksBody v) =>
      v.works;
  static const Field<WebUserProfileWorksBody, Map<String, WebDiscoveryIllust>>
  _f$works = Field('works', _$works, opt: true, def: const {});

  @override
  final MappableFields<WebUserProfileWorksBody> fields = const {
    #works: _f$works,
  };

  static WebUserProfileWorksBody _instantiate(DecodingData data) {
    return WebUserProfileWorksBody(works: data.dec(_f$works));
  }

  @override
  final Function instantiate = _instantiate;

  static WebUserProfileWorksBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUserProfileWorksBody>(map);
  }

  static WebUserProfileWorksBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebUserProfileWorksBody>(json);
  }
}

mixin WebUserProfileWorksBodyMappable {
  String toJson() {
    return WebUserProfileWorksBodyMapper.ensureInitialized()
        .encodeJson<WebUserProfileWorksBody>(this as WebUserProfileWorksBody);
  }

  Map<String, dynamic> toMap() {
    return WebUserProfileWorksBodyMapper.ensureInitialized()
        .encodeMap<WebUserProfileWorksBody>(this as WebUserProfileWorksBody);
  }

  WebUserProfileWorksBodyCopyWith<
    WebUserProfileWorksBody,
    WebUserProfileWorksBody,
    WebUserProfileWorksBody
  >
  get copyWith =>
      _WebUserProfileWorksBodyCopyWithImpl<
        WebUserProfileWorksBody,
        WebUserProfileWorksBody
      >(this as WebUserProfileWorksBody, $identity, $identity);
  @override
  String toString() {
    return WebUserProfileWorksBodyMapper.ensureInitialized().stringifyValue(
      this as WebUserProfileWorksBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUserProfileWorksBodyMapper.ensureInitialized().equalsValue(
      this as WebUserProfileWorksBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUserProfileWorksBodyMapper.ensureInitialized().hashValue(
      this as WebUserProfileWorksBody,
    );
  }
}

extension WebUserProfileWorksBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUserProfileWorksBody, $Out> {
  WebUserProfileWorksBodyCopyWith<$R, WebUserProfileWorksBody, $Out>
  get $asWebUserProfileWorksBody => $base.as(
    (v, t, t2) => _WebUserProfileWorksBodyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebUserProfileWorksBodyCopyWith<
  $R,
  $In extends WebUserProfileWorksBody,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    String,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get works;
  $R call({Map<String, WebDiscoveryIllust>? works});
  WebUserProfileWorksBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUserProfileWorksBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUserProfileWorksBody, $Out>
    implements
        WebUserProfileWorksBodyCopyWith<$R, WebUserProfileWorksBody, $Out> {
  _WebUserProfileWorksBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebUserProfileWorksBody> $mapper =
      WebUserProfileWorksBodyMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    String,
    WebDiscoveryIllust,
    WebDiscoveryIllustCopyWith<$R, WebDiscoveryIllust, WebDiscoveryIllust>
  >
  get works => MapCopyWith(
    $value.works,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(works: v),
  );
  @override
  $R call({Map<String, WebDiscoveryIllust>? works}) =>
      $apply(FieldCopyWithData({if (works != null) #works: works}));
  @override
  WebUserProfileWorksBody $make(CopyWithData data) =>
      WebUserProfileWorksBody(works: data.get(#works, or: $value.works));

  @override
  WebUserProfileWorksBodyCopyWith<$R2, WebUserProfileWorksBody, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebUserProfileWorksBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebUserProfileWorksResponseMapper
    extends ClassMapperBase<WebUserProfileWorksResponse> {
  WebUserProfileWorksResponseMapper._();

  static WebUserProfileWorksResponseMapper? _instance;
  static WebUserProfileWorksResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = WebUserProfileWorksResponseMapper._(),
      );
      WebUserProfileWorksBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebUserProfileWorksResponse';

  static bool _$error(WebUserProfileWorksResponse v) => v.error;
  static const Field<WebUserProfileWorksResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebUserProfileWorksResponse v) => v.message;
  static const Field<WebUserProfileWorksResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebUserProfileWorksBody _$body(WebUserProfileWorksResponse v) =>
      v.body;
  static const Field<WebUserProfileWorksResponse, WebUserProfileWorksBody>
  _f$body = Field('body', _$body, opt: true);

  @override
  final MappableFields<WebUserProfileWorksResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebUserProfileWorksResponse _instantiate(DecodingData data) {
    return WebUserProfileWorksResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebUserProfileWorksResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebUserProfileWorksResponse>(map);
  }

  static WebUserProfileWorksResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebUserProfileWorksResponse>(json);
  }
}

mixin WebUserProfileWorksResponseMappable {
  String toJson() {
    return WebUserProfileWorksResponseMapper.ensureInitialized()
        .encodeJson<WebUserProfileWorksResponse>(
          this as WebUserProfileWorksResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return WebUserProfileWorksResponseMapper.ensureInitialized()
        .encodeMap<WebUserProfileWorksResponse>(
          this as WebUserProfileWorksResponse,
        );
  }

  WebUserProfileWorksResponseCopyWith<
    WebUserProfileWorksResponse,
    WebUserProfileWorksResponse,
    WebUserProfileWorksResponse
  >
  get copyWith =>
      _WebUserProfileWorksResponseCopyWithImpl<
        WebUserProfileWorksResponse,
        WebUserProfileWorksResponse
      >(this as WebUserProfileWorksResponse, $identity, $identity);
  @override
  String toString() {
    return WebUserProfileWorksResponseMapper.ensureInitialized().stringifyValue(
      this as WebUserProfileWorksResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebUserProfileWorksResponseMapper.ensureInitialized().equalsValue(
      this as WebUserProfileWorksResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebUserProfileWorksResponseMapper.ensureInitialized().hashValue(
      this as WebUserProfileWorksResponse,
    );
  }
}

extension WebUserProfileWorksResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebUserProfileWorksResponse, $Out> {
  WebUserProfileWorksResponseCopyWith<$R, WebUserProfileWorksResponse, $Out>
  get $asWebUserProfileWorksResponse => $base.as(
    (v, t, t2) => _WebUserProfileWorksResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebUserProfileWorksResponseCopyWith<
  $R,
  $In extends WebUserProfileWorksResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebUserProfileWorksBodyCopyWith<
    $R,
    WebUserProfileWorksBody,
    WebUserProfileWorksBody
  >
  get body;
  $R call({bool? error, String? message, WebUserProfileWorksBody? body});
  WebUserProfileWorksResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebUserProfileWorksResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebUserProfileWorksResponse, $Out>
    implements
        WebUserProfileWorksResponseCopyWith<
          $R,
          WebUserProfileWorksResponse,
          $Out
        > {
  _WebUserProfileWorksResponseCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<WebUserProfileWorksResponse> $mapper =
      WebUserProfileWorksResponseMapper.ensureInitialized();
  @override
  WebUserProfileWorksBodyCopyWith<
    $R,
    WebUserProfileWorksBody,
    WebUserProfileWorksBody
  >
  get body => ($value.body as WebUserProfileWorksBody).copyWith.$chain(
    (v) => call(body: v),
  );
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebUserProfileWorksResponse $make(CopyWithData data) =>
      WebUserProfileWorksResponse(
        data.get(#error, or: $value.error),
        message: data.get(#message, or: $value.message),
        body: data.get(#body, or: $value.body),
      );

  @override
  WebUserProfileWorksResponseCopyWith<$R2, WebUserProfileWorksResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebUserProfileWorksResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebBookmarkAddBodyMapper extends ClassMapperBase<WebBookmarkAddBody> {
  WebBookmarkAddBodyMapper._();

  static WebBookmarkAddBodyMapper? _instance;
  static WebBookmarkAddBodyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebBookmarkAddBodyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebBookmarkAddBody';

  static int _$lastBookmarkId(WebBookmarkAddBody v) => v.lastBookmarkId;
  static const Field<WebBookmarkAddBody, int> _f$lastBookmarkId = Field(
    'lastBookmarkId',
    _$lastBookmarkId,
    key: r'last_bookmark_id',
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<WebBookmarkAddBody> fields = const {
    #lastBookmarkId: _f$lastBookmarkId,
  };

  static WebBookmarkAddBody _instantiate(DecodingData data) {
    return WebBookmarkAddBody(lastBookmarkId: data.dec(_f$lastBookmarkId));
  }

  @override
  final Function instantiate = _instantiate;

  static WebBookmarkAddBody fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebBookmarkAddBody>(map);
  }

  static WebBookmarkAddBody fromJson(String json) {
    return ensureInitialized().decodeJson<WebBookmarkAddBody>(json);
  }
}

mixin WebBookmarkAddBodyMappable {
  String toJson() {
    return WebBookmarkAddBodyMapper.ensureInitialized()
        .encodeJson<WebBookmarkAddBody>(this as WebBookmarkAddBody);
  }

  Map<String, dynamic> toMap() {
    return WebBookmarkAddBodyMapper.ensureInitialized()
        .encodeMap<WebBookmarkAddBody>(this as WebBookmarkAddBody);
  }

  WebBookmarkAddBodyCopyWith<
    WebBookmarkAddBody,
    WebBookmarkAddBody,
    WebBookmarkAddBody
  >
  get copyWith =>
      _WebBookmarkAddBodyCopyWithImpl<WebBookmarkAddBody, WebBookmarkAddBody>(
        this as WebBookmarkAddBody,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebBookmarkAddBodyMapper.ensureInitialized().stringifyValue(
      this as WebBookmarkAddBody,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebBookmarkAddBodyMapper.ensureInitialized().equalsValue(
      this as WebBookmarkAddBody,
      other,
    );
  }

  @override
  int get hashCode {
    return WebBookmarkAddBodyMapper.ensureInitialized().hashValue(
      this as WebBookmarkAddBody,
    );
  }
}

extension WebBookmarkAddBodyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebBookmarkAddBody, $Out> {
  WebBookmarkAddBodyCopyWith<$R, WebBookmarkAddBody, $Out>
  get $asWebBookmarkAddBody => $base.as(
    (v, t, t2) => _WebBookmarkAddBodyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebBookmarkAddBodyCopyWith<
  $R,
  $In extends WebBookmarkAddBody,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? lastBookmarkId});
  WebBookmarkAddBodyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebBookmarkAddBodyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebBookmarkAddBody, $Out>
    implements WebBookmarkAddBodyCopyWith<$R, WebBookmarkAddBody, $Out> {
  _WebBookmarkAddBodyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebBookmarkAddBody> $mapper =
      WebBookmarkAddBodyMapper.ensureInitialized();
  @override
  $R call({int? lastBookmarkId}) => $apply(
    FieldCopyWithData({
      if (lastBookmarkId != null) #lastBookmarkId: lastBookmarkId,
    }),
  );
  @override
  WebBookmarkAddBody $make(CopyWithData data) => WebBookmarkAddBody(
    lastBookmarkId: data.get(#lastBookmarkId, or: $value.lastBookmarkId),
  );

  @override
  WebBookmarkAddBodyCopyWith<$R2, WebBookmarkAddBody, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebBookmarkAddBodyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebBookmarkAddResponseMapper
    extends ClassMapperBase<WebBookmarkAddResponse> {
  WebBookmarkAddResponseMapper._();

  static WebBookmarkAddResponseMapper? _instance;
  static WebBookmarkAddResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebBookmarkAddResponseMapper._());
      WebBookmarkAddBodyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebBookmarkAddResponse';

  static bool _$error(WebBookmarkAddResponse v) => v.error;
  static const Field<WebBookmarkAddResponse, bool> _f$error = Field(
    'error',
    _$error,
  );
  static String _$message(WebBookmarkAddResponse v) => v.message;
  static const Field<WebBookmarkAddResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static WebBookmarkAddBody _$body(WebBookmarkAddResponse v) => v.body;
  static const Field<WebBookmarkAddResponse, WebBookmarkAddBody> _f$body =
      Field('body', _$body, opt: true);

  @override
  final MappableFields<WebBookmarkAddResponse> fields = const {
    #error: _f$error,
    #message: _f$message,
    #body: _f$body,
  };

  static WebBookmarkAddResponse _instantiate(DecodingData data) {
    return WebBookmarkAddResponse(
      data.dec(_f$error),
      message: data.dec(_f$message),
      body: data.dec(_f$body),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebBookmarkAddResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebBookmarkAddResponse>(map);
  }

  static WebBookmarkAddResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WebBookmarkAddResponse>(json);
  }
}

mixin WebBookmarkAddResponseMappable {
  String toJson() {
    return WebBookmarkAddResponseMapper.ensureInitialized()
        .encodeJson<WebBookmarkAddResponse>(this as WebBookmarkAddResponse);
  }

  Map<String, dynamic> toMap() {
    return WebBookmarkAddResponseMapper.ensureInitialized()
        .encodeMap<WebBookmarkAddResponse>(this as WebBookmarkAddResponse);
  }

  WebBookmarkAddResponseCopyWith<
    WebBookmarkAddResponse,
    WebBookmarkAddResponse,
    WebBookmarkAddResponse
  >
  get copyWith =>
      _WebBookmarkAddResponseCopyWithImpl<
        WebBookmarkAddResponse,
        WebBookmarkAddResponse
      >(this as WebBookmarkAddResponse, $identity, $identity);
  @override
  String toString() {
    return WebBookmarkAddResponseMapper.ensureInitialized().stringifyValue(
      this as WebBookmarkAddResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebBookmarkAddResponseMapper.ensureInitialized().equalsValue(
      this as WebBookmarkAddResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return WebBookmarkAddResponseMapper.ensureInitialized().hashValue(
      this as WebBookmarkAddResponse,
    );
  }
}

extension WebBookmarkAddResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebBookmarkAddResponse, $Out> {
  WebBookmarkAddResponseCopyWith<$R, WebBookmarkAddResponse, $Out>
  get $asWebBookmarkAddResponse => $base.as(
    (v, t, t2) => _WebBookmarkAddResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebBookmarkAddResponseCopyWith<
  $R,
  $In extends WebBookmarkAddResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  WebBookmarkAddBodyCopyWith<$R, WebBookmarkAddBody, WebBookmarkAddBody>
  get body;
  $R call({bool? error, String? message, WebBookmarkAddBody? body});
  WebBookmarkAddResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebBookmarkAddResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebBookmarkAddResponse, $Out>
    implements
        WebBookmarkAddResponseCopyWith<$R, WebBookmarkAddResponse, $Out> {
  _WebBookmarkAddResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebBookmarkAddResponse> $mapper =
      WebBookmarkAddResponseMapper.ensureInitialized();
  @override
  WebBookmarkAddBodyCopyWith<$R, WebBookmarkAddBody, WebBookmarkAddBody>
  get body =>
      ($value.body as WebBookmarkAddBody).copyWith.$chain((v) => call(body: v));
  @override
  $R call({bool? error, String? message, Object? body = $none}) => $apply(
    FieldCopyWithData({
      if (error != null) #error: error,
      if (message != null) #message: message,
      if (body != $none) #body: body,
    }),
  );
  @override
  WebBookmarkAddResponse $make(CopyWithData data) => WebBookmarkAddResponse(
    data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
    body: data.get(#body, or: $value.body),
  );

  @override
  WebBookmarkAddResponseCopyWith<$R2, WebBookmarkAddResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WebBookmarkAddResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

