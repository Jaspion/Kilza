//
//  Basearray.h
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
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
