#import <SenTestingKit/SenTestingKit.h>
#import "GeoHash.h"

@interface GeoHashTestCase : SenTestCase {

}
- (void)testEncode;
- (void)testDecode;
- (void)testAdjacent;
- (void)testNeighbors;
- (void)testVerification;
@end

