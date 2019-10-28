#import <XCTest/XCTest.h>
#import "BTPayPalUAT.h"

@interface BTPayPalUAT_ObjCTests : XCTestCase

@end

@implementation BTPayPalUAT_ObjCTests

// Swift creates an error object implicitly, so a nil error can only be tested in Objective C
- (void)testInitWithUATString_whenErrorIsNil_setsAuthorizationFingerprintAndConfigURL {
    NSString *uatString = @"123.ewogICAiaXNzIjoiaHR0cHM6Ly9hcGkucGF5cGFsLmNvbSIsCiAgICJzdWIiOiJQYXlQYWw6ZmFrZS1wcC1tZXJjaGFudCIsCiAgICJzY29wZXMiOlsKICAgICAgIkJyYWludHJlZTpWYXVsdCIKICAgXSwKICAgImV4cCI6MTU3MTk4MDUwNiwKICAgImV4dGVybmFsX2lkcyI6WwogICAgICAiUGF5UGFsOmZha2UtcHAtbWVyY2hhbnQiLAogICAgICAiQnJhaW50cmVlOmZha2UtYnQtbWVyY2hhbnQiCiAgIF0sCiAgICJqdGkiOiJmYWtlLWp0aSIKfQ.456";

    BTPayPalUAT *uat = [[BTPayPalUAT alloc] initWithUATString:uatString error:nil];
    XCTAssertNotNil(uat);
    XCTAssertEqual(uat.token, uatString);
    XCTAssertEqualObjects(uat.configURL.absoluteString, @"/merchants/fake-bt-merchant/client_api/v1/configuration");
}

@end
