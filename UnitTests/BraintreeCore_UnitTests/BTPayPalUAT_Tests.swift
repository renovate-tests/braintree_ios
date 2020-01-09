import XCTest

class BTPayPalUAT_Tests: XCTestCase {

    func testInitWithUATString_whenZeroPaddingCharactersAreRequired_setsAuthorizationFingerprintAndConfigURL() {
        let uatString = "123.ewogICAiaXNzIjoiaHR0cHM6Ly9hcGkucGF5cGFsLmNvbSIsCiAgICJzdWIiOiJQYXlQYWw6ZmFrZS1wcC1tZXJjaGFudCIsCiAgICJhY3IiOlsKICAgICAgImNsaWVudCIKICAgXSwKICAgInNjb3BlcyI6WwogICAgICAiQnJhaW50cmVlOlZhdWx0IgogICBdLAogICAiZXhwIjoxNTcxOTgwNTA2LAogICAiZXh0ZXJuYWxfaWRzIjpbCiAgICAgICJQYXlQYWw6ZmFrZS1wcC1tZXJjaGFudCIsCiAgICAgICJCcmFpbnRyZWU6ZmFrZS1idC1tZXJjaGFudCIKICAgXSwKICAgImp0aSI6ImZha2UtanRpIgp9.456"

        let payPalUAT = try? BTPayPalUAT(uatString: uatString)
        XCTAssertNotNil(payPalUAT)
        XCTAssertEqual(payPalUAT?.token, uatString)
        XCTAssertEqual(payPalUAT?.configURL, URL(string: "/merchants/fake-bt-merchant/client_api/v1/configuration"))
    }
    
    func testInitWithUATString_whenOnePaddingCharacterIsRequired_setsAuthorizationFingerprintAndConfigURL() {
        let uatString = "123.ewogICAiaXNzIjoiaHR0cHM6Ly9hcGkucGF5cGFsLmNvbSIsCiAgICJzdWIiOiJQYXlQYWw6ZmFrZS1wcC1tZXJjaGFudCIsCiAgICJhY3IiOlsKICAgICAgImNsaWVudCIKICAgXSwKICAgIm9wdGlvbnMiOnsKCiAgIH0sCiAgICJheiI6ImZha2UtYXoiLAogICAic2NvcGVzIjpbCiAgICAgICJCcmFpbnRyZWU6VmF1bHQiCiAgIF0sCiAgICJleHAiOjE1NzE5ODA1MDYsCiAgICJleHRlcm5hbF9pZHMiOlsKICAgICAgIlBheVBhbDpmYWtlLXBwLW1lcmNoYW50IiwKICAgICAgIkJyYWludHJlZTpmYWtlLWJ0LW1lcmNoYW50IgogICBdLAogICAianRpIjoiZmFrZS1qdGkiCn0.456"

        let payPalUAT = try? BTPayPalUAT(uatString: uatString)
        XCTAssertNotNil(payPalUAT)
        XCTAssertEqual(payPalUAT?.token, uatString)
        XCTAssertEqual(payPalUAT?.configURL, URL(string: "/merchants/fake-bt-merchant/client_api/v1/configuration"))
    }
    
    func testInitWithUATString_whenTwoPaddingCharactersAreRequired_setsAuthorizationFingerprintAndConfigURL() {
        let uatString = "123.ewogICAiaXNzIjoiaHR0cHM6Ly9hcGkucGF5cGFsLmNvbSIsCiAgICJzdWIiOiJQYXlQYWw6ZmFrZS1wcC1tZXJjaGFudCIsCiAgICJzY29wZXMiOlsKICAgICAgIkJyYWludHJlZTpWYXVsdCIKICAgXSwKICAgImV4cCI6MTU3MTk4MDUwNiwKICAgImV4dGVybmFsX2lkcyI6WwogICAgICAiUGF5UGFsOmZha2UtcHAtbWVyY2hhbnQiLAogICAgICAiQnJhaW50cmVlOmZha2UtYnQtbWVyY2hhbnQiCiAgIF0sCiAgICJqdGkiOiJmYWtlLWp0aSIKfQ.456"

        let payPalUAT = try? BTPayPalUAT(uatString: uatString)
        XCTAssertNotNil(payPalUAT)
        XCTAssertEqual(payPalUAT?.token, uatString)
        XCTAssertEqual(payPalUAT?.configURL, URL(string: "/merchants/fake-bt-merchant/client_api/v1/configuration"))
    }
    
    func testInitWithUATString_whenUATStringIsMalformed_throwsError() {
        let uatString = "malformed-uat"
        
        do {
            let _ = try BTPayPalUAT(uatString: uatString)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Invalid PayPal UAT: Missing payload.")
        }
    }
    
    func testInitWithUATString_whenBase64DecodingFails_throwsError() {
        let uatString = "123.&*^(.456"
        
        do {
            let _ = try BTPayPalUAT(uatString: uatString)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Invalid PayPal UAT: Unable to base-64 decode payload.")
        }
    }
    
    func testInitWithUATString_whenJSONSerializationFails_throwsError() {
        let uatString = "123.aW52YWxpZCBqc29u.456"
        
        do {
            let _ = try BTPayPalUAT(uatString: uatString)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Invalid PayPal UAT: The data couldn’t be read because it isn’t in the correct format.")
        }
    }
    
    func testInitWithUATString_whenJSONIsNotDictionary_throwsError() {
        let uatString = "123.WyAic3RyaW5nIiBd.456"
            
        do {
            let _ = try BTPayPalUAT(uatString: uatString)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Invalid PayPal UAT: Expected to find an object at JSON root.")
        }
    }
    
    func testInitWithUATString_whenJSONDoesNotContainExternalIds_throwsError() {
        let uatString = "123.eyJoZWxsbyI6ICJ3b3JsZCJ9.456"
            
        do {
            let _ = try BTPayPalUAT(uatString: uatString)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Invalid PayPal UAT: Braintree merchant id not found.")
        }
    }
    
    func testInitWithUATString_whenJSONDoesNotContainBraintreeMerchantId_throwsError() {
        let uatString = "123.ewogICJleHRlcm5hbF9pZHMiOiBbCiAgICAiUGF5UGFsOm1lcmNoYW50LWlkIgogIF0KfQ.456"
            
        do {
            let _ = try BTPayPalUAT(uatString: uatString)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Invalid PayPal UAT: Braintree merchant id not found.")
        }
    }
    
    func testInitWithUATString_whenErrorIsNil_returnsNil() {
        let uatString = "123.ewogICAiaXNzIjoiaHR0cHM6Ly9hcGkucGF5cGFsLmNvbSIsCiAgICJzdWIiOiJQYXlQYWw6ZmFrZS1wcC1tZXJjaGFudCIsCiAgICJzY29wZXMiOlsKICAgICAgIkJyYWludHJlZTpWYXVsdCIKICAgXSwKICAgImV4cCI6MTU3MTk4MDUwNiwKICAgImV4dGVybmFsX2lkcyI6WwogICAgICAiUGF5UGFsOmZha2UtcHAtbWVyY2hhbnQiLAogICAgICAiQnJhaW50cmVlOmZha2UtYnQtbWVyY2hhbnQiCiAgIF0sCiAgICJqdGkiOiJmYWtlLWp0aSIKfQ.456"

        let payPalUAT = try! BTPayPalUAT(uatString: uatString)
        XCTAssertNotNil(payPalUAT)
    }
}
