//
//  Base.h
//
//  Created on 2016-01-07
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Base : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString * _id;
@property (nonatomic, strong) NSString * str;
@property (nonatomic, strong) NSNumber * num;
@property (nonatomic, strong) NSNumber * flo;
@property (nonatomic, strong) NSNumber * boo;
@property (nonatomic, strong) NSObject * spa_ce;
@property (nonatomic, strong) NSObject * special;
@property (nonatomic, strong) NSMutableArray * arrdouble;
@property (nonatomic, strong) NSMutableArray * arrnum;
@property (nonatomic, strong) NSMutableArray * arrstr;
@property (nonatomic, strong) NSMutableArray * arrboo;
@property (nonatomic, strong) NSMutableArray * arrnull;
@property (nonatomic, strong) NSObject * obj;
@property (nonatomic, strong) NSMutableArray * arrobj;

+ (Base *)modelWithDictionary:(NSDictionary *)dict;
+ (Base *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
