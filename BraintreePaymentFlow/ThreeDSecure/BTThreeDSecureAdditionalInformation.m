#import "BTThreeDSecureAdditionalInformation_Internal.h"
#import "BTThreeDSecurePostalAddress_Internal.h"

@implementation BTThreeDSecureAdditionalInformation

- (NSDictionary *)asParameters {
    NSMutableDictionary *parameters = [@{} mutableCopy];

    [self insertIfExists:self.billingGivenName key:@"billingGivenName" dictionary:parameters];
    [self insertIfExists:self.billingSurname key:@"billingSurname" dictionary:parameters];
    [self insertIfExists:self.billingPhoneNumber key:@"billingPhoneNumber" dictionary:parameters];
    [self insertIfExists:self.email key:@"email" dictionary:parameters];
    [self insertIfExists:self.shippingMethod key:@"shippingMethod" dictionary:parameters];

    if (self.billingAddress) {
        // TODO billing line 3?
        [self insertIfExists:self.billingAddress.streetAddress key:@"billingLine1" dictionary:parameters];
        [self insertIfExists:self.billingAddress.extendedAddress key:@"billingLine2" dictionary:parameters];
        [self insertIfExists:self.billingAddress.locality key:@"billingCity" dictionary:parameters];
        [self insertIfExists:self.billingAddress.region key:@"billingState" dictionary:parameters];
        [self insertIfExists:self.billingAddress.postalCode key:@"billingPostalCode" dictionary:parameters];
        [self insertIfExists:self.billingAddress.countryCodeAlpha2 key:@"billingCountryCode" dictionary:parameters];
    }

    [self insertIfExists:self.shippingMethodIndicator key:@"shippingMethodIndicator" dictionary:parameters];
    [self insertIfExists:self.productCode key:@"productCode" dictionary:parameters];
    [self insertIfExists:self.deliveryTimeframe key:@"deliveryTimeframe" dictionary:parameters];
    [self insertIfExists:self.deliveryEmail key:@"deliveryEmail" dictionary:parameters];
    [self insertIfExists:self.reorderIndicator key:@"reorderIndicator" dictionary:parameters];
    [self insertIfExists:self.preorderIndicator key:@"preorderIndicator" dictionary:parameters];
    [self insertIfExists:self.preorderDate key:@"preorderDate" dictionary:parameters];
    [self insertIfExists:self.giftCardAmount key:@"giftCardAmount" dictionary:parameters];
    [self insertIfExists:self.giftCardCurrencyCode key:@"giftCardCurrencyCode" dictionary:parameters];
    [self insertIfExists:self.giftCardCount key:@"giftCardCount" dictionary:parameters];
    [self insertIfExists:self.accountAgeIndicator key:@"accountAgeIndicator" dictionary:parameters];
    [self insertIfExists:self.accountCreateDate key:@"accountCreateDate" dictionary:parameters];
    [self insertIfExists:self.accountChangeIndicator key:@"accountChangeIndicator" dictionary:parameters];
    [self insertIfExists:self.accountChangeDate key:@"accountChangeDate" dictionary:parameters];
    [self insertIfExists:self.accountPwdChangeIndicator key:@"accountPwdChangeIndicator" dictionary:parameters];
    [self insertIfExists:self.accountPwdChangeDate key:@"accountPwdChangeDate" dictionary:parameters];
    [self insertIfExists:self.shippingAddressUsageIndicator key:@"shippingAddressUsageIndicator" dictionary:parameters];
    [self insertIfExists:self.shippingAddressUsageDate key:@"shippingAddressUsageDate" dictionary:parameters];
    [self insertIfExists:self.transactionCountDay key:@"transactionCountDay" dictionary:parameters];
    [self insertIfExists:self.transactionCountYear key:@"transactionCountYear" dictionary:parameters];
    [self insertIfExists:self.addCardAttempts key:@"addCardAttempts" dictionary:parameters];
    [self insertIfExists:self.accountPurchases key:@"accountPurchases" dictionary:parameters];
    [self insertIfExists:self.fraudActivity key:@"fraudActivity" dictionary:parameters];
    [self insertIfExists:self.shippingNameIndicator key:@"shippingNameIndicator" dictionary:parameters];
    [self insertIfExists:self.paymentAccountIndicator key:@"paymentAccountIndicator" dictionary:parameters];
    [self insertIfExists:self.paymentAccountAge key:@"paymentAccountAge" dictionary:parameters];
    [self insertIfExists:self.addressMatch key:@"addressMatch" dictionary:parameters];
    [self insertIfExists:self.accountId key:@"accountId" dictionary:parameters];
    [self insertIfExists:self.ipAddress key:@"ipAddress" dictionary:parameters];
    [self insertIfExists:self.orderDescription key:@"orderDescription" dictionary:parameters];
    [self insertIfExists:self.taxAmount key:@"taxAmount" dictionary:parameters];
    [self insertIfExists:self.userAgent key:@"userAgent" dictionary:parameters];
    [self insertIfExists:self.authenticationIndicator key:@"authenticationIndicator" dictionary:parameters];
    [self insertIfExists:self.installment key:@"installment" dictionary:parameters];
    [self insertIfExists:self.purchaseDate key:@"purchaseDate" dictionary:parameters];
    [self insertIfExists:self.recurringEnd key:@"recurringEnd" dictionary:parameters];
    [self insertIfExists:self.recurringFrequency key:@"recurringFrequency" dictionary:parameters];

    return [parameters copy];
}

- (void)insertIfExists:(NSString *)param key:(NSString *)key dictionary:(NSMutableDictionary *)dictionary{
    if (param != nil && key != nil && dictionary != nil) {
        dictionary[key] = param;
    }
}

@end
