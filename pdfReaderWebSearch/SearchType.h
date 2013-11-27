//
//  SearchType.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/19/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchType : NSObject

@property (weak, nonatomic) NSString *engineName;
@property (weak, nonatomic) NSString *searchURL;
@property (weak, nonatomic) NSString *searchDescription;
@property (weak, nonatomic) NSString *additionalSearchParameters;

@end
