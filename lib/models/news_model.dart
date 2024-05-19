class NewsModel {
    NewsModel({
        required this.meta,
        required this.data,
    });

    final Meta? meta;
    static const String metaKey = "meta";
    
    final List<Datum> data;
    static const String dataKey = "data";
    

    factory NewsModel.fromJson(Map<String, dynamic> json){ 
        return NewsModel(
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$meta, $data, ";
    }
}

class Datum {
    Datum({
        required this.uuid,
        required this.title,
        required this.description,
        required this.keywords,
        required this.snippet,
        required this.url,
        required this.imageUrl,
        required this.language,
        required this.publishedAt,
        required this.source,
        required this.categories,
        required this.relevanceScore,
    });

    final String? uuid;
    static const String uuidKey = "uuid";
    
    final String? title;
    static const String titleKey = "title";
    
    final String? description;
    static const String descriptionKey = "description";
    
    final String? keywords;
    static const String keywordsKey = "keywords";
    
    final String? snippet;
    static const String snippetKey = "snippet";
    
    final String? url;
    static const String urlKey = "url";
    
    final String? imageUrl;
    static const String imageUrlKey = "image_url";
    
    final String? language;
    static const String languageKey = "language";
    
    final DateTime? publishedAt;
    static const String publishedAtKey = "published_at";
    
    final String? source;
    static const String sourceKey = "source";
    
    final List<String> categories;
    static const String categoriesKey = "categories";
    
    final double? relevanceScore;
    static const String relevanceScoreKey = "relevance_score";
    

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            uuid: json["uuid"],
            title: json["title"],
            description: json["description"],
            keywords: json["keywords"],
            snippet: json["snippet"],
            url: json["url"],
            imageUrl: json["image_url"],
            language: json["language"],
            publishedAt: DateTime.tryParse(json["published_at"] ?? ""),
            source: json["source"],
            categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
            relevanceScore: json["relevance_score"],
        );
    }

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "title": title,
        "description": description,
        "keywords": keywords,
        "snippet": snippet,
        "url": url,
        "image_url": imageUrl,
        "language": language,
        "published_at": publishedAt?.toIso8601String(),
        "source": source,
        "categories": categories.map((x) => x).toList(),
        "relevance_score": relevanceScore,
    };

    @override
    String toString(){
        return "$uuid, $title, $description, $keywords, $snippet, $url, $imageUrl, $language, $publishedAt, $source, $categories, $relevanceScore, ";
    }
}

class Meta {
    Meta({
        required this.found,
        required this.returned,
        required this.limit,
        required this.page,
    });

    final int? found;
    static const String foundKey = "found";
    
    final int? returned;
    static const String returnedKey = "returned";
    
    final int? limit;
    static const String limitKey = "limit";
    
    final int? page;
    static const String pageKey = "page";
    

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            found: json["found"],
            returned: json["returned"],
            limit: json["limit"],
            page: json["page"],
        );
    }

    Map<String, dynamic> toJson() => {
        "found": found,
        "returned": returned,
        "limit": limit,
        "page": page,
    };

    @override
    String toString(){
        return "$found, $returned, $limit, $page, ";
    }
}
