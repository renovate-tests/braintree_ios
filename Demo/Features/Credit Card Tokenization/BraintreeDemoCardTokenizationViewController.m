#import "BraintreeDemoCardTokenizationViewController.h"
#import "BraintreeDemoSettings.h"
#import <BraintreeCard/BraintreeCard.h>
#import <CardIO/CardIO.h>


@interface BraintreeDemoCardTokenizationViewController () <CardIOPaymentViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *cardNumberField;
@property (nonatomic, strong) IBOutlet UITextField *expirationMonthField;
@property (nonatomic, strong) IBOutlet UITextField *expirationYearField;

@property (weak, nonatomic) IBOutlet UIButton *cardIOButton;
@property (weak, nonatomic) IBOutlet UIButton *autofillButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) BTAPIClient *apiClient;

@end

@implementation BraintreeDemoCardTokenizationViewController

- (instancetype)initWithAuthorization:(NSString *)authorization {
    if (self = [super initWithAuthorization:authorization]) {
        _apiClient = [[BTAPIClient alloc] initWithAuthorization:authorization];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Card Tokenization", nil);
    self.edgesForExtendedLayout = UIRectEdgeBottom;

    [CardIOUtilities preload];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    self.progressBlock([NSString stringWithFormat:@"Scanned a card with Card.IO: %@", [cardInfo redactedCardNumber]]);

    if (cardInfo.expiryYear) {
        self.expirationYearField.text = [NSString stringWithFormat:@"%d", (int)cardInfo.expiryYear];
    }

    if (cardInfo.expiryMonth) {
        self.expirationMonthField.text = [NSString stringWithFormat:@"%d", (int)cardInfo.expiryMonth];
    }

    self.cardNumberField.text = cardInfo.cardNumber;

    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitForm {
    self.progressBlock(@"Tokenizing card details!");

    self.apiClient = [[BTAPIClient alloc] initWithAuthorization:@"eyJraWQiOiI1NTY1MWVhZWE0MjZjZDVhMjM5ZWU0ZjUwMTczMDk3NmI2YzMxZmNkIiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwaS5wYXlwYWwuY29tIiwic3ViIjoiUGF5UGFsOlE3QzlONlM0WVJRWEciLCJhY3IiOlsiY2xpZW50Il0sIm9wdGlvbnMiOnt9LCJheiI6InRlLXBwY3AtbmF0aXZlc2RrX2lkZW50aXR5c2VjdXJldG9rZW5zZXJ2XzAucWEiLCJzY29wZXMiOlsiQnJhaW50cmVlOlZhdWx0Il0sImV4cCI6MTU3MDI1NjU0NywiZXh0ZXJuYWxfaWRzIjpbIlBheVBhbDpRN0M5TjZTNFlSUVhHIiwiQnJhaW50cmVlOmZtaHdoMnN3ZHo2bnJqZDciXSwianRpIjoiVTJBQUdsMjY5X3NOY0s4V01YMkcxbnRiVnptR1prOWZFUXVvV3R1cUw5bG8yamcxV2ZJM1FhNHd1NTJhZ09qb0FzQkNWMXJlVVR4MHBMWURSV1RkUXg2bXFzcmI0OFJzdWJER0lLeFZjX0RxcnZoNXBHczkyWXVWZC1lN2lXcncifQ.hyCiRqE3uO_IrHGXW1DJ1CQKQHQ0impBayIVisL43Qv64HJxYLVfDwuNnG7YzGuZx-1Q26engzs5hfdvHGzT-g"];
    BTCardClient *cardClient = [[BTCardClient alloc] initWithAPIClient:self.apiClient];
    BTCard *card = [[BTCard alloc] initWithNumber:self.cardNumberField.text
                                                                           expirationMonth:self.expirationMonthField.text
                                                                            expirationYear:self.expirationYearField.text
                                                                                       cvv:nil];

    [self setFieldsEnabled:NO];
    [cardClient tokenizeCard:card completion:^(BTCardNonce *tokenized, NSError *error) {
        [self setFieldsEnabled:YES];
        if (error) {
            self.progressBlock(error.localizedDescription);
            NSLog(@"Error: %@", error);
            return;
        }

        self.completionBlock(tokenized);
    }];
}

- (IBAction)setupDemoData {
    self.cardNumberField.text = [@"4111111111111111" copy];
    self.expirationMonthField.text = [@"12" copy];
    self.expirationYearField.text = [@"2038" copy];
}

- (IBAction)presentCardIO {
    CardIOPaymentViewController *cardIO = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    cardIO.collectExpiry = YES;
    cardIO.collectCVV = NO;
    cardIO.useCardIOLogo = YES;
    cardIO.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:cardIO animated:YES completion:nil];

}

- (void)setFieldsEnabled:(BOOL)enabled {
    self.cardNumberField.enabled = enabled;
    self.expirationMonthField.enabled = enabled;
    self.expirationYearField.enabled = enabled;
    self.submitButton.enabled = enabled;
    self.cardIOButton.enabled = enabled;
    self.autofillButton.enabled = enabled;

}

@end
