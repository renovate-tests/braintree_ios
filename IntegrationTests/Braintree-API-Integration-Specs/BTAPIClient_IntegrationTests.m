#import <BraintreeCore/BraintreeCore.h>
#import <BraintreeCore/BTAPIClient_Internal.h>
#import <XCTest/XCTest.h>

@interface BTAPIClient_IntegrationTests : XCTestCase
@end

@implementation BTAPIClient_IntegrationTests

- (void)testFetchConfiguration_withTokenizationKey_returnsTheConfiguration {
    BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:SANDBOX_TOKENIZATION_KEY];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch configuration"];
    [client fetchOrReturnRemoteConfiguration:^(BTConfiguration *configuration, NSError *error) {
        XCTAssertEqualObjects([configuration.json[@"merchantId"] asString], @"dcpspy2brwdjr3qn");
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testFetchConfiguration_withClientToken_returnsTheConfiguration {
    BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:SANDBOX_CLIENT_TOKEN];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch configuration"];
    [client fetchOrReturnRemoteConfiguration:^(BTConfiguration *configuration, NSError *error) {
        // Note: client token uses a different merchant ID than the merchant whose tokenization key
        // we use in the other test
        XCTAssertEqualObjects([configuration.json[@"merchantId"] asString], @"348pk9cgf3bgyw2b");
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testFetchConfiguration_withVersionThreeClientToken_returnsTheConfiguration {
    BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:SANDBOX_CLIENT_TOKEN_VERSION_3];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch configuration"];
    [client fetchOrReturnRemoteConfiguration:^(BTConfiguration *configuration, NSError *error) {
        // Note: client token uses a different merchant ID than the merchant whose tokenization key
        // we use in the other test
        XCTAssertEqualObjects([configuration.json[@"merchantId"] asString], @"dcpspy2brwdjr3qn");
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)pendFetchConfiguration_withPayPalUAT_returnsTheConfiguration {
    // NOTE: - This UAT will expire. To run this test, you must generate a fresh UAT.

    BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:@"eyJraWQiOiI1NTY1MWVhZWE0MjZjZDVhMjM5ZWU0ZjUwMTczMDk3NmI2YzMxZmNkIiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwaS5wYXlwYWwuY29tIiwic3ViIjoiUGF5UGFsOlc1Skw2VlVKVTlUTUwiLCJhY3IiOlsiY2xpZW50Il0sIm9wdGlvbnMiOnt9LCJheiI6Im1zbWFzdGVyMWludC1nX2lkZW50aXR5c2VjdXJldG9rZW5zZXJ2XzEucWEiLCJzY29wZXMiOlsiQnJhaW50cmVlOlZhdWx0Il0sImV4cCI6MTU3ODYzMDE1MywiZXh0ZXJuYWxfaWRzIjpbIlBheVBhbDpXNUpMNlZVSlU5VE1MIiwiQnJhaW50cmVlOm15bWt5Mm12eDVteWo1eXoiXSwianRpIjoiVTJBQUhhenpIQm1NU3Z0RXhEM1ZIak5PWWZaSFBKOHdTaGVVNEM1NFg1cTVMSnNQcTBvRVJneUVMM0FHRmlsUC1vMDhfQ0lnbzlSS3dqSUw4MzZoT3ZlZkVjcGtIWXMzZUh0OE5KYVhYZmdvZzJJNmk1Nmp2QW5zdlhNSUtlY3cifQ.GXhER7Ttn7QIqZ8Zq4Zj7iV6qyFbDddcemS9id2VyJidBgZWZZgg5Je8p7LUXcBfsjZrWaBYSepERTIEHSXHzg"];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch configuration"];
    [client fetchOrReturnRemoteConfiguration:^(BTConfiguration *configuration, NSError *error) {
        XCTAssertEqualObjects([configuration.json[@"merchantId"] asString], @"mymky2mvx5myj5yz");
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}
@end
