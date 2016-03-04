//
//  Null.h
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Null : NSObject <NSCoding, NSCopying>


+ (Null *)modelWithDictionary:(NSDictionary *)dict;
+ (Null *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
