//
//  CreditCardModel.h
//  Assignment6
//
//  Created by Dylan Kyle Davis on 3/8/16.
//  Copyright © 2016 dylan. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString * kNumber = @"number";
static const NSString * kName = @"name";
static const NSString * kCV2 = @"cv2";
static const NSString * kExpirationDate = @"exp";

@interface CreditCardModel : NSObject

+(instancetype)sharedModel;
-(void) addCard:(NSDictionary*)info;
-(NSUInteger) numCards;
-(NSDictionary*)getCardAtIndex:(NSUInteger)index;

@end
