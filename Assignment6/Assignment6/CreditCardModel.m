//
//  CreditCardModel.m
//  Assignment6
//
//  Created by Dylan Kyle Davis on 3/8/16.
//  Copyright © 2016 dylan. All rights reserved.
//

#import "KeychainItemWrapper.h"
#import "CreditCardModel.h"

@interface CreditCardModel()

@property NSMutableArray * cards;
@property (strong, nonatomic) KeychainItemWrapper * secureDataKeychain;

@end

@implementation CreditCardModel


- (id)init
{
    self = [super init];
    if (self) {
        
        self.secureDataKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.dylan.Assignment6.secureData" accessGroup:nil];
        
        [self.secureDataKeychain setObject:(id)kSecAttrAccessibleWhenUnlocked forKey: (id)kSecAttrAccessible];
        [self.secureDataKeychain setObject:@"secureDataIdentifer" forKey: (id)kSecAttrAccount];
        
        if([self.secureDataKeychain objectForKey:(id)kSecValueData]) {
            
            NSString *secureDataString = [self.secureDataKeychain objectForKey:(id)kSecValueData];
            
            if([secureDataString length] != 0)
            {
                NSData* data = [secureDataString dataUsingEncoding:NSUTF8StringEncoding];
                
                NSError *error = nil;
                
                NSArray *creditCardList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                if(error != nil)
                {
                    NSLog(@"An error occurred: %@", [error localizedDescription]);
                }
                
                self.cards = [[NSMutableArray alloc]initWithArray:creditCardList];
            }
            else
            {
                NSLog(@"No Keychain data stored yet");
                self.cards = [[NSMutableArray alloc] init];
            }
        }
        else {
         
            self.cards = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

+ (instancetype) sharedModel {
    
    static CreditCardModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    
    return _sharedModel;
}


-(void)addCard:(NSDictionary *)info {
    
    [self.cards addObject:info];
    
    NSError * error = nil;
    
    NSData *rawData = [NSJSONSerialization dataWithJSONObject:self.cards options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error != nil)
    {
        NSLog(@"An error occurred: %@", [error localizedDescription]);
    }
    
    NSString *dataString = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
    
    [self.secureDataKeychain setObject:dataString forKey:(id)kSecValueData];
}

-(NSUInteger)numCards{
    
    return self.cards.count;
}

-(NSDictionary*)getCardAtIndex:(NSUInteger)index {
    
    return [self.cards objectAtIndex:index];
}

@end
