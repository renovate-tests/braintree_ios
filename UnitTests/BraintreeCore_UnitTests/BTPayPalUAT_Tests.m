#import <XCTest/XCTest.h>
#import "BTPayPalUAT.h"

@interface BTPayPalUAT_ObjCTests : XCTestCase

@end

@implementation BTPayPalUAT_ObjCTests

// Swift creates an error object implicitly, so a nil error can only be tested in Objective C
// TODO: - make sure this passes once PP UAT returns PayPal and Braintree URLs for each environment
- (void)testInitWithUATString_whenErrorIsNil_setsAuthorizationFingerprintAndConfigURL {
    NSString *uatString = @"123.eyJpc3MiOiJodHRwczovL2FwaS5wYXlwYWwuY29tIiwic3ViIjoiUGF5UGFsOmZha2UtcHAtbWVyY2hhbnQiLCJicmFpbnRyZWVVUkwiOiJodHRwczovL3NvbWUtYnJhaW50cmVlLXVybC5jb20iLCJzY29wZXMiOlsiQnJhaW50cmVlOlZhdWx0Il0sImV4cCI6MTU3MTk4MDUwNiwiZXh0ZXJuYWxfaWRzIjpbIlBheVBhbDpmYWtlLXBwLW1lcmNoYW50IiwiQnJhaW50cmVlOmZha2UtYnQtbWVyY2hhbnQiXSwianRpIjoiZmFrZS1qdGkifQ.456";

    BTPayPalUAT *uat = [[BTPayPalUAT alloc] initWithUATString:uatString error:nil];
    XCTAssertNotNil(uat);
    XCTAssertEqual(uat.token, uatString);
    XCTAssertEqualObjects(uat.configURL.absoluteString, @"https://some-braintree-url.com/merchants/fake-bt-merchant/client_api/v1/configuration");
}

@end
