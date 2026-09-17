import 'package:dart_mappable/dart_mappable.dart';

part 'pixiv_web_models.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebTitleCaptionTranslation with WebTitleCaptionTranslationMappable {
  @MappableField(key: 'workTitle')
  final String? workTitle;
  @MappableField(key: 'workCaption')
  final String? workCaption;

  WebTitleCaptionTranslation({this.workTitle, this.workCaption});

  static final fromMap = WebTitleCaptionTranslationMapper.fromMap;
  static final fromJson = WebTitleCaptionTranslationMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDiscoveryIllust with WebDiscoveryIllustMappable {
  final String id;
  final String title;
  @MappableField(key: 'illustType')
  final int illustType;
  @MappableField(key: 'xRestrict')
  final int xRestrict;
  final int restrict;
  final int sl;
  final String url;
  final String description;
  final List<String> tags;
  @MappableField(key: 'userId')
  final String? userId;
  @MappableField(key: 'userName')
  final String? userName;
  final int width;
  final int height;
  @MappableField(key: 'pageCount')
  final int pageCount;
  @MappableField(key: 'isBookmarkable')
  final bool isBookmarkable;
  @MappableField(key: 'bookmarkData')
  final dynamic bookmarkData;
  final String? alt;
  @MappableField(key: 'titleCaptionTranslation')
  final WebTitleCaptionTranslation? titleCaptionTranslation;
  @MappableField(key: 'createDate')
  final String? createDate;
  @MappableField(key: 'updateDate')
  final String? updateDate;
  @MappableField(key: 'isUnlisted')
  final bool isUnlisted;
  @MappableField(key: 'isMasked')
  final bool isMasked;
  @MappableField(key: 'aiType')
  final int aiType;
  @MappableField(key: 'visibilityScope')
  final int visibilityScope;
  final Map<String, String> urls;
  @MappableField(key: 'profileImageUrl')
  final String? profileImageUrl;

  WebDiscoveryIllust(
    this.id,
    this.title, {
    this.illustType = 0,
    this.xRestrict = 0,
    this.restrict = 0,
    this.sl = 0,
    this.url = '',
    this.description = '',
    this.tags = const [],
    this.userId,
    this.userName,
    this.width = 0,
    this.height = 0,
    this.pageCount = 0,
    this.isBookmarkable = false,
    this.bookmarkData,
    this.alt,
    this.titleCaptionTranslation,
    this.createDate,
    this.updateDate,
    this.isUnlisted = false,
    this.isMasked = false,
    this.aiType = 0,
    this.visibilityScope = 0,
    this.urls = const {},
    this.profileImageUrl,
  });

  static final fromMap = WebDiscoveryIllustMapper.fromMap;
  static final fromJson = WebDiscoveryIllustMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebRecommendedIllust with WebRecommendedIllustMappable {
  @MappableField(key: 'illustId')
  final String illustId;
  @MappableField(key: 'recommendMethods')
  final List<String> recommendMethods;
  @MappableField(key: 'recommendScore')
  final double recommendScore;
  @MappableField(key: 'recommendSeedIllustIds')
  final List<int> recommendSeedIllustIds;

  WebRecommendedIllust(
    this.illustId, {
    this.recommendMethods = const [],
    this.recommendScore = 0,
    this.recommendSeedIllustIds = const [],
  });

  static final fromMap = WebRecommendedIllustMapper.fromMap;
  static final fromJson = WebRecommendedIllustMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDiscoveryThumbnails with WebDiscoveryThumbnailsMappable {
  final List<WebDiscoveryIllust> illust;

  WebDiscoveryThumbnails({this.illust = const []});

  static final fromMap = WebDiscoveryThumbnailsMapper.fromMap;
  static final fromJson = WebDiscoveryThumbnailsMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDiscoveryBody with WebDiscoveryBodyMappable {
  @MappableField(key: 'tagTranslation')
  final Map<String, dynamic>? tagTranslation;
  final WebDiscoveryThumbnails thumbnails;
  @MappableField(key: 'illustSeries')
  final List<dynamic> illustSeries;
  final List<dynamic> requests;
  final List<dynamic> users;
  @MappableField(key: 'recommendedIllusts')
  final List<WebRecommendedIllust> recommendedIllusts;

  WebDiscoveryBody(
    this.thumbnails, {
    this.tagTranslation,
    this.illustSeries = const [],
    this.requests = const [],
    this.users = const [],
    this.recommendedIllusts = const [],
  });

  static final fromMap = WebDiscoveryBodyMapper.fromMap;
  static final fromJson = WebDiscoveryBodyMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDiscoveryResponse with WebDiscoveryResponseMappable {
  final bool error;
  final String message;
  final WebDiscoveryBody body;

  WebDiscoveryResponse(this.error, this.body, {this.message = ''});

  static final fromMap = WebDiscoveryResponseMapper.fromMap;
  static final fromJson = WebDiscoveryResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDetailUrls with WebDetailUrlsMappable {
  final String mini;
  final String thumb;
  final String small;
  final String regular;
  final String original;

  WebDetailUrls({
    this.mini = '',
    this.thumb = '',
    this.small = '',
    this.regular = '',
    this.original = '',
  });

  static final fromMap = WebDetailUrlsMapper.fromMap;
  static final fromJson = WebDetailUrlsMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDetailTag with WebDetailTagMappable {
  final String tag;
  final bool locked;
  final bool deletable;
  @MappableField(key: 'userId')
  final String? userId;
  @MappableField(key: 'userName')
  final String? userName;
  final String? romaji;
  final Map<String, String>? translation;

  WebDetailTag(
    this.tag, {
    this.locked = false,
    this.deletable = false,
    this.userId,
    this.userName,
    this.romaji,
    this.translation,
  });

  static final fromMap = WebDetailTagMapper.fromMap;
  static final fromJson = WebDetailTagMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebDetailTagWrap with WebDetailTagWrapMappable {
  @MappableField(key: 'authorId')
  final String? authorId;
  @MappableField(key: 'isLocked')
  final bool isLocked;
  final List<WebDetailTag> tags;
  final bool? writable;

  WebDetailTagWrap({
    this.authorId,
    this.isLocked = false,
    this.tags = const [],
    this.writable,
  });

  static final fromMap = WebDetailTagWrapMapper.fromMap;
  static final fromJson = WebDetailTagWrapMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebIllustDetail with WebIllustDetailMappable {
  final String id;
  final String title;
  final String description;
  @MappableField(key: 'illustType')
  final int illustType;
  @MappableField(key: 'createDate')
  final String? createDate;
  @MappableField(key: 'uploadDate')
  final String? uploadDate;
  final int restrict;
  @MappableField(key: 'xRestrict')
  final int xRestrict;
  final int sl;
  final WebDetailUrls urls;
  final WebDetailTagWrap tags;
  final String? alt;
  @MappableField(key: 'userId')
  final String? userId;
  @MappableField(key: 'userName')
  final String? userName;
  @MappableField(key: 'userAccount')
  final String? userAccount;
  final int width;
  final int height;
  @MappableField(key: 'pageCount')
  final int pageCount;
  @MappableField(key: 'bookmarkCount')
  final int bookmarkCount;
  @MappableField(key: 'likeCount')
  final int likeCount;
  @MappableField(key: 'commentCount')
  final int commentCount;
  @MappableField(key: 'viewCount')
  final int viewCount;
  @MappableField(key: 'bookStyle')
  final String? bookStyle;
  @MappableField(key: 'aiType')
  final int aiType;
  @MappableField(key: 'isBookmarkable')
  final bool isBookmarkable;
  @MappableField(key: 'bookmarkData')
  final Map<String, dynamic>? bookmarkData;
  @MappableField(key: 'titleCaptionTranslation')
  final WebTitleCaptionTranslation? titleCaptionTranslation;
  @MappableField(key: 'zoneConfig')
  final Map<String, dynamic>? zoneConfig;
  @MappableField(key: 'extraData')
  final Map<String, dynamic>? extraData;
  @MappableField(key: 'userIllusts')
  final Map<String, dynamic>? userIllusts;
  @MappableField(key: 'likeData')
  final dynamic likeData;

  WebIllustDetail(
    this.id,
    this.title, {
    this.description = '',
    this.illustType = 0,
    this.createDate,
    this.uploadDate,
    this.restrict = 0,
    this.xRestrict = 0,
    this.sl = 0,
    WebDetailUrls? urls,
    WebDetailTagWrap? tags,
    this.alt,
    this.userId,
    this.userName,
    this.userAccount,
    this.width = 0,
    this.height = 0,
    this.pageCount = 0,
    this.bookmarkCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.viewCount = 0,
    this.bookStyle,
    this.aiType = 0,
    this.isBookmarkable = false,
    this.bookmarkData,
    this.titleCaptionTranslation,
    this.zoneConfig,
    this.extraData,
    this.userIllusts,
    this.likeData,
  }) : urls = urls ?? WebDetailUrls(),
       tags = tags ?? WebDetailTagWrap();

  static final fromMap = WebIllustDetailMapper.fromMap;
  static final fromJson = WebIllustDetailMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebIllustDetailResponse with WebIllustDetailResponseMappable {
  final bool error;
  final String message;
  final WebIllustDetail body;

  WebIllustDetailResponse(this.error, this.body, {this.message = ''});

  static final fromMap = WebIllustDetailResponseMapper.fromMap;
  static final fromJson = WebIllustDetailResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebPageUrls with WebPageUrlsMappable {
  @MappableField(key: 'thumb_mini')
  final String thumbMini;
  final String small;
  final String regular;
  final String original;

  WebPageUrls({
    this.thumbMini = '',
    this.small = '',
    this.regular = '',
    this.original = '',
  });

  static final fromMap = WebPageUrlsMapper.fromMap;
  static final fromJson = WebPageUrlsMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebIllustPage with WebIllustPageMappable {
  final WebPageUrls urls;
  final int width;
  final int height;

  WebIllustPage({WebPageUrls? urls, this.width = 0, this.height = 0})
    : urls = urls ?? WebPageUrls();

  static final fromMap = WebIllustPageMapper.fromMap;
  static final fromJson = WebIllustPageMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebIllustPagesResponse with WebIllustPagesResponseMappable {
  final bool error;
  final String message;
  final List<WebIllustPage> body;

  WebIllustPagesResponse(this.error, {this.message = '', this.body = const []});

  static final fromMap = WebIllustPagesResponseMapper.fromMap;
  static final fromJson = WebIllustPagesResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUgoiraFrame with WebUgoiraFrameMappable {
  final String file;
  final int delay;

  WebUgoiraFrame({this.file = '', this.delay = 0});

  static final fromMap = WebUgoiraFrameMapper.fromMap;
  static final fromJson = WebUgoiraFrameMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUgoiraMeta with WebUgoiraMetaMappable {
  final String src;
  @MappableField(key: 'originalSrc')
  final String originalSrc;
  final String mimeType;
  final List<WebUgoiraFrame> frames;

  WebUgoiraMeta({
    this.src = '',
    this.originalSrc = '',
    this.mimeType = '',
    this.frames = const [],
  });

  static final fromMap = WebUgoiraMetaMapper.fromMap;
  static final fromJson = WebUgoiraMetaMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUgoiraResponse with WebUgoiraResponseMappable {
  final bool error;
  final String message;
  final WebUgoiraMeta body;

  WebUgoiraResponse(this.error, {this.message = '', WebUgoiraMeta? body})
    : body = body ?? WebUgoiraMeta();

  static final fromMap = WebUgoiraResponseMapper.fromMap;
  static final fromJson = WebUgoiraResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebRecommendBody with WebRecommendBodyMappable {
  final List<WebDiscoveryIllust> illusts;
  @MappableField(key: 'nextIds')
  final List<String> nextIds;

  WebRecommendBody({this.illusts = const [], this.nextIds = const []});

  static final fromMap = WebRecommendBodyMapper.fromMap;
  static final fromJson = WebRecommendBodyMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebRecommendResponse with WebRecommendResponseMappable {
  final bool error;
  final String message;
  final WebRecommendBody body;

  WebRecommendResponse(this.error, {this.message = '', WebRecommendBody? body})
    : body = body ?? WebRecommendBody();

  static final fromMap = WebRecommendResponseMapper.fromMap;
  static final fromJson = WebRecommendResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebFollowPage with WebFollowPageMappable {
  final List<String> ids;
  @MappableField(key: 'isLastPage')
  final bool isLastPage;

  WebFollowPage({this.ids = const [], this.isLastPage = false});

  static final fromMap = WebFollowPageMapper.fromMap;
  static final fromJson = WebFollowPageMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebFollowLatestBody with WebFollowLatestBodyMappable {
  final WebFollowPage page;
  final WebDiscoveryThumbnails thumbnails;

  WebFollowLatestBody({WebFollowPage? page, WebDiscoveryThumbnails? thumbnails})
    : page = page ?? WebFollowPage(),
      thumbnails = thumbnails ?? WebDiscoveryThumbnails();

  static final fromMap = WebFollowLatestBodyMapper.fromMap;
  static final fromJson = WebFollowLatestBodyMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebFollowLatestResponse with WebFollowLatestResponseMappable {
  final bool error;
  final String message;
  final WebFollowLatestBody body;

  WebFollowLatestResponse(
    this.error, {
    this.message = '',
    WebFollowLatestBody? body,
  }) : body = body ?? WebFollowLatestBody();

  static final fromMap = WebFollowLatestResponseMapper.fromMap;
  static final fromJson = WebFollowLatestResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebRankingItem with WebRankingItemMappable {
  final int illustId;
  final String title;
  final String url;
  final int rank;
  final int yesRank;
  final int userId;
  final String userName;
  final String profileImg;
  final List<String> tags;
  final String illustType;
  final String illustPageCount;
  final String illustBookStyle;
  final int width;
  final int height;
  final int ratingCount;
  final int viewCount;
  final int illustUploadTimestamp;
  final String date;
  final String attr;
  final bool isMasked;
  final bool isBookmarked;
  final bool bookmarkable;
  final Map<String, dynamic>? illustContentType;
  final dynamic illustSeries;

  WebRankingItem({
    this.illustId = 0,
    this.title = '',
    this.url = '',
    this.rank = 0,
    this.yesRank = 0,
    this.userId = 0,
    this.userName = '',
    this.profileImg = '',
    this.tags = const [],
    this.illustType = '',
    this.illustPageCount = '',
    this.illustBookStyle = '',
    this.width = 0,
    this.height = 0,
    this.ratingCount = 0,
    this.viewCount = 0,
    this.illustUploadTimestamp = 0,
    this.date = '',
    this.attr = '',
    this.isMasked = false,
    this.isBookmarked = false,
    this.bookmarkable = false,
    this.illustContentType,
    this.illustSeries,
  });

  static final fromMap = WebRankingItemMapper.fromMap;
  static final fromJson = WebRankingItemMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebRankingResponse with WebRankingResponseMappable {
  final List<WebRankingItem> contents;
  final String mode;
  final String content;
  final int page;
  final dynamic prev;
  final dynamic next;
  final String date;
  final String prevDate;
  final String nextDate;
  final int rankTotal;

  WebRankingResponse({
    this.contents = const [],
    this.mode = '',
    this.content = '',
    this.page = 0,
    this.prev,
    this.next,
    this.date = '',
    this.prevDate = '',
    this.nextDate = '',
    this.rankTotal = 0,
  });

  static final fromMap = WebRankingResponseMapper.fromMap;
  static final fromJson = WebRankingResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebSearchIllustManga with WebSearchIllustMangaMappable {
  final List<WebDiscoveryIllust> data;
  final int total;
  @MappableField(key: 'lastPage')
  final int lastPage;
  @MappableField(key: 'bookmarkRanges')
  final List<dynamic> bookmarkRanges;

  WebSearchIllustManga({
    this.data = const [],
    this.total = 0,
    this.lastPage = 0,
    this.bookmarkRanges = const [],
  });

  static final fromMap = WebSearchIllustMangaMapper.fromMap;
  static final fromJson = WebSearchIllustMangaMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebSearchArtworksBody with WebSearchArtworksBodyMappable {
  @MappableField(key: 'illustManga')
  final WebSearchIllustManga illustManga;
  @MappableField(key: 'relatedTags')
  final List<dynamic> relatedTags;
  final dynamic popular;
  @MappableField(key: 'tagTranslation')
  final Map<String, dynamic>? tagTranslation;

  WebSearchArtworksBody({
    WebSearchIllustManga? illustManga,
    this.relatedTags = const [],
    this.popular,
    this.tagTranslation,
  }) : illustManga = illustManga ?? WebSearchIllustManga();

  static final fromMap = WebSearchArtworksBodyMapper.fromMap;
  static final fromJson = WebSearchArtworksBodyMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebSearchArtworksResponse with WebSearchArtworksResponseMappable {
  final bool error;
  final String message;
  final WebSearchArtworksBody body;

  WebSearchArtworksResponse(
    this.error, {
    this.message = '',
    WebSearchArtworksBody? body,
  }) : body = body ?? WebSearchArtworksBody();

  static final fromMap = WebSearchArtworksResponseMapper.fromMap;
  static final fromJson = WebSearchArtworksResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUserFull with WebUserFullMappable {
  @MappableField(key: 'userId')
  final String userId;
  final String name;
  final String image;
  @MappableField(key: 'imageBig')
  final String imageBig;
  final bool premium;
  @MappableField(key: 'isFollowed')
  final bool isFollowed;
  @MappableField(key: 'isMypixiv')
  final bool isMypixiv;
  @MappableField(key: 'isBlocking')
  final bool isBlocking;
  final int following;
  @MappableField(key: 'followedBack')
  final bool followedBack;
  final String comment;
  @MappableField(key: 'commentHtml')
  final String commentHtml;
  final String? webpage;
  final Map<String, dynamic>? social;

  WebUserFull({
    this.userId = '',
    this.name = '',
    this.image = '',
    this.imageBig = '',
    this.premium = false,
    this.isFollowed = false,
    this.isMypixiv = false,
    this.isBlocking = false,
    this.following = 0,
    this.followedBack = false,
    this.comment = '',
    this.commentHtml = '',
    this.webpage,
    this.social,
  });

  static final fromMap = WebUserFullMapper.fromMap;
  static final fromJson = WebUserFullMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUserFullResponse with WebUserFullResponseMappable {
  final bool error;
  final String message;
  final WebUserFull body;

  WebUserFullResponse(this.error, {this.message = '', WebUserFull? body})
    : body = body ?? WebUserFull();

  static final fromMap = WebUserFullResponseMapper.fromMap;
  static final fromJson = WebUserFullResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUserWorksAll with WebUserWorksAllMappable {
  final Map<String, dynamic> illusts;
  final Map<String, dynamic> manga;
  final Map<String, dynamic> novels;

  WebUserWorksAll({
    this.illusts = const {},
    this.manga = const {},
    this.novels = const {},
  });

  List<String> get illustIds => illusts.keys.toList();
  List<String> get mangaIds => manga.keys.toList();
  List<String> get novelIds => novels.keys.toList();

  static final fromMap = WebUserWorksAllMapper.fromMap;
  static final fromJson = WebUserWorksAllMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebUserWorksAllResponse with WebUserWorksAllResponseMappable {
  final bool error;
  final String message;
  final WebUserWorksAll body;

  WebUserWorksAllResponse(
    this.error, {
    this.message = '',
    WebUserWorksAll? body,
  }) : body = body ?? WebUserWorksAll();

  static final fromMap = WebUserWorksAllResponseMapper.fromMap;
  static final fromJson = WebUserWorksAllMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebComment with WebCommentMappable {
  final String id;
  @MappableField(key: 'userId')
  final String userId;
  @MappableField(key: 'userName')
  final String userName;
  @MappableField(key: 'isDeletedUser')
  final bool isDeletedUser;
  final String img;
  final String comment;
  @MappableField(key: 'stampId')
  final String? stampId;
  @MappableField(key: 'commentDate')
  final String commentDate;
  @MappableField(key: 'commentParentId')
  final String? commentParentId;
  @MappableField(key: 'commentUserId')
  final String? commentUserId;
  final bool editable;
  @MappableField(key: 'hasReplies')
  final bool hasReplies;

  WebComment({
    this.id = '',
    this.userId = '',
    this.userName = '',
    this.isDeletedUser = false,
    this.img = '',
    this.comment = '',
    this.stampId,
    this.commentDate = '',
    this.commentParentId,
    this.commentUserId,
    this.editable = false,
    this.hasReplies = false,
  });

  static final fromMap = WebCommentMapper.fromMap;
  static final fromJson = WebCommentMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebCommentsBody with WebCommentsBodyMappable {
  final List<WebComment> comments;
  @MappableField(key: 'hasNext')
  final bool hasNext;

  WebCommentsBody({this.comments = const [], this.hasNext = false});

  static final fromMap = WebCommentsBodyMapper.fromMap;
  static final fromJson = WebCommentsBodyMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebCommentsResponse with WebCommentsResponseMappable {
  final bool error;
  final String message;
  final WebCommentsBody body;

  WebCommentsResponse(this.error, {this.message = '', WebCommentsBody? body})
    : body = body ?? WebCommentsBody();

  static final fromMap = WebCommentsResponseMapper.fromMap;
  static final fromJson = WebCommentsResponseMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebBookmarkAddBody with WebBookmarkAddBodyMappable {
  final int lastBookmarkId;

  WebBookmarkAddBody({this.lastBookmarkId = 0});

  static final fromMap = WebBookmarkAddBodyMapper.fromMap;
  static final fromJson = WebBookmarkAddBodyMapper.fromJson;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WebBookmarkAddResponse with WebBookmarkAddResponseMappable {
  final bool error;
  final String message;
  final WebBookmarkAddBody body;

  WebBookmarkAddResponse(
    this.error, {
    this.message = '',
    WebBookmarkAddBody? body,
  }) : body = body ?? WebBookmarkAddBody();

  static final fromMap = WebBookmarkAddResponseMapper.fromMap;
  static final fromJson = WebBookmarkAddResponseMapper.fromJson;
}
