//
//  Special.h
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Special : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) id a;
@property (nonatomic, strong) NSString * _b______;
@property (nonatomic, strong) NSString * with_some_spaces;
@property (nonatomic, strong) NSNumber * _mynew;

+ (Special *)modelWithDictionary:(NSDictionary *)dict;
+ (Special *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
