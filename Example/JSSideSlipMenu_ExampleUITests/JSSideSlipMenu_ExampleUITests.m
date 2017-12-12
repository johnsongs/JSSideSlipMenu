//
//  JSSideSlipMenu_ExampleUITests.m
//  JSSideSlipMenu_ExampleUITests
//
//  Created by Johnson on 2017/12/11.
//  Copyright © 2017年 johnsongs. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JSSideSlipMenu_ExampleUITests : XCTestCase
    
    @end

@implementation JSSideSlipMenu_ExampleUITests
    
- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}
    
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
    
- (void)testExample {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    [app.navigationBars.buttons[@"show"] tap];
    XCUIElement *pushNextViewControllerButton = app.buttons[@"push next view controller"];
    [pushNextViewControllerButton tap];
    [app.navigationBars.buttons[@"Back"] tap];
    
    XCUIElement *element = [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
    [[[[element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element swipeRight];
    [[[[element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeImage].element tap];
    [app.navigationBars.buttons[@"show"] tap];
    [pushNextViewControllerButton tap];
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
    
    @end

