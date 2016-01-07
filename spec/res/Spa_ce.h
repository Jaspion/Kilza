//
//  Spa_ce.h
//
//  Created on 2016-01-07
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Spa_ce : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString * _1one;

+ (Spa_ce *)modelWithDictionary:(NSDictionary *)dict;
+ (Spa_ce *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
