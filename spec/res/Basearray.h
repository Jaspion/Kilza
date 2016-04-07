//
//  Basearray.h
//
//  Created on 2016-04-07
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Basearray : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSMutableArray * basearrayobject;

+ (Basearray *)modelWithDictionary:(NSDictionary *)dict;
+ (Basearray *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
