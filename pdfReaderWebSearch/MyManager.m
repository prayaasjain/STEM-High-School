//
//  MyManager.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 11/14/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "MyManager.h"

static MyManager *sharedMyManager = nil;

@implementation MyManager

@synthesize searchBundle;

#pragma mark Singleton Methods

+ (id) sharedManager {
    
    static MyManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (id) init {
    
    if(self = [super init]) {
        searchBundle = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) dealloc {
    //should never be called
}

@end
