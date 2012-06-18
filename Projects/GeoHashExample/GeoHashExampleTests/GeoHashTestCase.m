#import "GeoHashTestCase.h"
#import "GeoHash.h"

@interface GeoHashTestCase()

- (void)verifyEncodedHashWithLatitude:(double)lat
                           longitude:(double)lon 
                               length:(NSInteger)length
                         expectedHash:(NSString *)expected;

- (void)verifyDecodedAreaWithHash:(NSString *)hash
                      maxLatitude:(double)maxLat
                      minLatitude:(double)minLat
                    maxLongitude:(double)maxLon
                    minLongitude:(double)minLon;

- (void)verifyAdjacentWithHash:(NSString*)hash
                     direction:(GHDirection)dir
              expectedAdjacent:(NSString *)expected;

- (void)verifyNeighborsForHash:(NSString *)hash
                     withNorth:(NSString *)north
                         south:(NSString *)south
                          west:(NSString *)west
                          east:(NSString *)east
                     northWest:(NSString *)northWest
                     northEast:(NSString *)northEast
                     southWest:(NSString *)southWest
                     southEast:(NSString *)southEast;
@end

@implementation GeoHashTestCase

- (void)verifyEncodedHashWithLatitude:(double)lat
                           longitude:(double)lon 
                               length:(NSInteger)length
                         expectedHash:(NSString *)expected
{
    NSString *encoded = [GeoHash hashForLatitude:lat
                                      longitude:lon 
                                          length:length];
    STAssertNotNil(encoded, @"failed encoding");
    STAssertTrue([encoded isEqualToString:expected], @"encoded hash doesn't match");
}

- (void)verifyDecodedAreaWithHash:(NSString *)hash
                      maxLatitude:(double)maxLat
                      minLatitude:(double)minLat
                    maxLongitude:(double)maxLon
                    minLongitude:(double)minLon
{
    GHArea *area = [GeoHash areaForHash:hash];
    STAssertNotNil(area, @"failed decoding");
    STAssertEquals([area.latitude.max doubleValue], maxLat, @"max latitude is invalid");
    STAssertEquals([area.latitude.min doubleValue], minLat, @"min latitude is invalid");
    STAssertEquals([area.longitude.max doubleValue], maxLon, @"max longitude is invalid");
    STAssertEquals([area.longitude.min doubleValue], minLon, @"min longitude is invalid");
}

- (void)verifyAdjacentWithHash:(NSString*)hash
                     direction:(GHDirection)dir
              expectedAdjacent:(NSString *)expected
{

    NSString *adjacent = [GeoHash adjacentForHash:hash 
                                        direction:dir];
    STAssertNotNil(adjacent, @"failed to obtain adjacent");
    STAssertTrue([adjacent isEqualToString:expected], @"adjacent doesn't match");
}

- (void)verifyNeighborsForHash:(NSString *)hash
                     withNorth:(NSString *)north
                         south:(NSString *)south
                          west:(NSString *)west
                          east:(NSString *)east
                     northWest:(NSString *)northWest
                     northEast:(NSString *)northEast
                     southWest:(NSString *)southWest
                     southEast:(NSString *)southEast
{
    GHNeighbors *neighbors = [GeoHash neighborsForHash:hash];
    STAssertNotNil(neighbors, @"failed to obtain neighbors"); 
    STAssertTrue([neighbors.north isEqualToString:north], @"north doesn't match");
    STAssertTrue([neighbors.south isEqualToString:south], @"south doesn't match");
    STAssertTrue([neighbors.west isEqualToString:west], @"west doesn't match");
    STAssertTrue([neighbors.east isEqualToString:east], @"east doesn't match");
    STAssertTrue([neighbors.northWest isEqualToString:northWest], @"northWest doesn't match");
    STAssertTrue([neighbors.northEast isEqualToString:northEast], @"northEast doesn't match");
    STAssertTrue([neighbors.southWest isEqualToString:southWest], @"southWest doesn't match");
    STAssertTrue([neighbors.southEast isEqualToString:southEast], @"southEast doesn't match");
}

- (void)testEncode
{

    [self verifyEncodedHashWithLatitude:45.37 
                             longitude:-121.7
                                 length:6 
                           expectedHash:@"c216ne"];
    [self verifyEncodedHashWithLatitude:35.6894875
                             longitude:139.6917064
                                 length:13 
                           expectedHash:@"xn774c06kdtve"];
    [self verifyEncodedHashWithLatitude:-33.8671390
                             longitude:151.2071140
                                 length:13 
                           expectedHash:@"r3gx2f9tt5sne"];
    [self verifyEncodedHashWithLatitude:51.5001524
                             longitude:-0.1262362
                                 length:13 
                           expectedHash:@"gcpuvpk44kprq"];
}

- (void)testDecode
{

    [self verifyDecodedAreaWithHash:@"c216ne"
                        maxLatitude:45.37353515625
                        minLatitude:45.3680419921875
                      maxLongitude:-121.695556640625
                      minLongitude:-121.70654296875];

    [self verifyDecodedAreaWithHash:@"C216Ne"
                        maxLatitude:45.37353515625
                        minLatitude:45.3680419921875
                      maxLongitude:-121.695556640625
                      minLongitude:-121.70654296875];

    [self verifyDecodedAreaWithHash:@"dqcw4"
                        maxLatitude:39.0673828125
                        minLatitude:39.0234375
                      maxLongitude:-76.5087890625
                      minLongitude:-76.552734375];

    [self verifyDecodedAreaWithHash:@"DQCW4"
                        maxLatitude:39.0673828125
                        minLatitude:39.0234375
                      maxLongitude:-76.5087890625
                      minLongitude:-76.552734375];
}

- (void)testAdjacent
{

    [self verifyAdjacentWithHash:@"dqcjq"
                       direction:GHDirectionNorth
                expectedAdjacent:@"dqcjw"];

    [self verifyAdjacentWithHash:@"dqcjq"
                       direction:GHDirectionSouth
                expectedAdjacent:@"dqcjn"];

    [self verifyAdjacentWithHash:@"dqcjq"
                       direction:GHDirectionWest
                expectedAdjacent:@"dqcjm"];

    [self verifyAdjacentWithHash:@"dqcjq"
                       direction:GHDirectionEast
                expectedAdjacent:@"dqcjr"];
}

- (void)testNeighbors
{

    [self verifyNeighborsForHash:@"dqcw5"
                       withNorth:@"dqcw7"
                           south:@"dqctg"
                            west:@"dqcw4"
                            east:@"dqcwh"
                       northWest:@"dqcw6"
                       northEast:@"dqcwk"
                       southWest:@"dqctf"
                       southEast:@"dqctu"];

    [self verifyNeighborsForHash:@"xn774c"
                       withNorth:@"xn774f"
                           south:@"xn774b"
                            west:@"xn7749"
                            east:@"xn7751"
                       northWest:@"xn774d"
                       northEast:@"xn7754"
                       southWest:@"xn7748"
                       southEast:@"xn7750"];

    [self verifyNeighborsForHash:@"gcpuvpk"
                       withNorth:@"gcpuvps"
                           south:@"gcpuvph"
                            west:@"gcpuvp7"
                            east:@"gcpuvpm"
                       northWest:@"gcpuvpe"
                       northEast:@"gcpuvpt"
                       southWest:@"gcpuvp5"
                       southEast:@"gcpuvpj"];

    [self verifyNeighborsForHash:@"c23nb62w"
                       withNorth:@"c23nb62x"
                           south:@"c23nb62t"
                            west:@"c23nb62q"
                            east:@"c23nb62y"
                       northWest:@"c23nb62r"
                       northEast:@"c23nb62z"
                       southWest:@"c23nb62m"
                       southEast:@"c23nb62v"];
}

- (void)testVerification
{
    STAssertTrue([GeoHash verifyHash:@"dqcw5"], @"Invalid hash verification");
    STAssertTrue([GeoHash verifyHash:@"Dqcw7"], @"Invalid hash verification");
    STAssertFalse([GeoHash verifyHash:@"abcwd"], @"Invalid hash verification");
    STAssertFalse([GeoHash verifyHash:@"dqcw5@"], @"Invalid hash verification");
}

@end
