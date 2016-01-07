//
//  Obj.h
//
//  Created on 2016-01-07
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Obj : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString * str;
@property (nonatomic, strong) NSNumber * num;
@property (nonatomic, strong) NSNumber * flo;
@property (nonatomic, strong) NSNumber * boo;

+ (Obj *)modelWithDictionary:(NSDictionary *)dict;
+ (Obj *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
