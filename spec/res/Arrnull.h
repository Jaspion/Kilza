//
//  Arrnull.h
//
//  Created on 2016-01-07
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Arrnull : NSObject <NSCoding, NSCopying>


+ (Arrnull *)modelWithDictionary:(NSDictionary *)dict;
+ (Arrnull *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
