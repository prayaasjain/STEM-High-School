//
//  ViewController.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize currentSearchEngine,searchTextField,selectSearchButton,highlighted,show,searchEngines;

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier isEqualToString:@"Search"]) {
    
        if([searchTextField.text isEqual:@""]) {
            
            UIAlertView *nullSearchAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Search" message:@"Search field cannot be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
            [nullSearchAlert show];
            return NO;
        }
        else {
            return YES;
        }
    }
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        if([segue.identifier isEqualToString:@"Search"]) {
                WebViewController *wvc = [segue destinationViewController];
                [wvc setTitle:@"Search Results"];
                SearchType* selectedSearchEngine = [self findSearchObjectForString:selectSearchButton.titleLabel.text];
                wvc.selectedSearchEngine = selectedSearchEngine;
                wvc.show = self.show;
                wvc.vc = self;
                NSString *searchText = [[NSString alloc] initWithString:searchTextField.text];
                [sharedManager.searchBundle setObject:searchText forKey:@"SEARCH"];
            
        }
        else if([segue.identifier isEqualToString:@"popOver"]) {

            UIStoryboardPopoverSegue *popoverSegue;
            popoverSegue = (UIStoryboardPopoverSegue *)segue;
            
            
            UIPopoverController *popoverController;
            popoverController = popoverSegue.popoverController;
            popoverController.delegate = self;
            
            TableViewController *tableViewController = (TableViewController *)popoverSegue.destinationViewController;
            tableViewController.popoverController = popoverController;
            tableViewController.vc = self;
            tableViewController.searchEngines = self.searchEngines;
        }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if([alertView.title isEqual:@"Invalid Search"] && buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green-board-text.png"]];
    sharedManager = [MyManager sharedManager];
    searchTextField.text = highlighted;
    
    searchEngines = [[NSMutableArray alloc] init];
    
    SearchType *search = [[SearchType alloc]init];
    [search setEngineName:@"Google"];
    [search setSearchURL:@"http://www.google.com/search?q="];
    [search setSearchDescription:@"www.google.com"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Wikipedia"];
    [search setSearchURL:@"http://en.wikipedia.org/wiki/Special:Search?search="];
    [search setSearchDescription:@"www.wikipedia.org"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Bluesci"];
    [search setSearchURL:@"http://www.bluesci.org/?s="];
    [search setSearchDescription:@"Cambridge University science magazine"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Young Scientist"];
    [search setSearchURL:@"http://searchvu.vanderbilt.edu/search?q="];
    [search setSearchDescription:@"Vanderbilt University"];
    [search setAdditionalSearchParameters:@"&client=default_frontend&proxystylesheet=default_frontend&output=xml_no_dtd&go=GO&sort=date%3AD%3AL%3Ad1&entqr=0&oe=UTF-8&ie=UTF-8&ud=1&site=default_collection"];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"TED (Video)"];
    [search setSearchURL:@"http://www.ted.com/search?cat=ss_all&q="];
    [search setSearchDescription:@"TED | Ideas Worth Inspiring"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Academic Earth"];
    [search setSearchURL:@"http://academicearth.org/?s="];
    [search setSearchDescription:@"Academic Earth"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"cK-12"];
    [search setSearchURL:@"http://www.ck12.org/search/?q="];
    [search setSearchDescription:@"cK-12"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
//    search = [[SearchType alloc]init];
//    [search setEngineName:@"TIME for Kids"];
//    [search setSearchURL:@"http://timeforkids.com/search/site/"];
//    [search setSearchDescription:@"TIME for Kids"];
//    [search setAdditionalSearchParameters:@""];
//    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Info Please"];
    [search setSearchURL:@"http://infoplease.com/search?q="];
    [search setSearchDescription:@"Info please"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
//    
//    search = [[SearchType alloc]init];
//    [search setEngineName:@"Britannica Kids"];
//    [search setSearchURL:@"http://kids.britannica.com/search?query="];
//    [search setSearchDescription:@"Britannica Kids"];
//    [search setAdditionalSearchParameters:@""];
//    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"RefSeek"];
    [search setSearchURL:@"http://www.refseek.com/documents?q="];
    [search setSearchDescription:@"RefSeek"];
    [search setAdditionalSearchParameters:@""];
    [searchEngines addObject:search];
    
//    search = [[SearchType alloc]init];
//    [search setEngineName:@"Fact Monster"];
//    [search setSearchURL:@"http://www.factmonster.com/search?fr=fmtnh&query="];
//    [search setSearchDescription:@"Fact Monster"];
//    [search setAdditionalSearchParameters:@""];
//    [searchEngines addObject:search];
}



-(SearchType*)findSearchObjectForString:(NSString*)title{
    for (SearchType* searchEngine in searchEngines) {
        if([searchEngine.engineName isEqualToString:title])
            return searchEngine;
    }
    return NULL;
}

#pragma mark - UIMenuController required methods



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [show dismissViewControllerAnimated:YES completion:nil];
}
@end
