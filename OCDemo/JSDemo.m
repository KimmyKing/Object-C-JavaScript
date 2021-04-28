//
//  JSDemo.m
//  OCDemo
//
//  Created by Jimmy King on 2021/4/25.
//

#import "JSDemo.h"

@implementation JSDemo

- (void)scan:(NSString *)message{
    [self.delegate scan: message];
}

@end
