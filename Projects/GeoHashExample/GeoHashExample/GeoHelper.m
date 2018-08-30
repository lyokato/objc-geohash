

#import "GeoHelper.h"
#import "GeoHash.h"

@implementation GeoHelper


+(NSString*)geoHashForMapRect:(MKMapRect)mapRect size:(int)size{
    NSDictionary *d0 = [self hashGridForMapRect:mapRect];
    __block NSString *geohash = @"";
    NSArray *array = [(NSSet*)[d0 valueForKey:@"mbr"] allObjects];
    geohash = [array objectAtIndex:0];
   [array enumerateObjectsUsingBlock:^(NSString *gHash, NSUInteger idx, BOOL * _Nonnull stop) {
       if (gHash.length == size) {
           geohash = gHash;
       }
   }];


    return [geohash substringWithRange:NSMakeRange(0, 1)];
  
    
}
+(NSBag*)hashBagForMapRect:(MKMapRect)mapRect{
    return [[self hashGridForMapRect:mapRect] valueForKey:@"mbr"];
}

// This is a wide net that will spill outside the mapRect.
+(NSDictionary*)hashGridForMapRect:(MKMapRect)mapRect{
    
    CLLocationCoordinate2D ne =  [GeoHelper getNECoordinate:mapRect];
    CLLocationCoordinate2D nw =  [GeoHelper getNWCoordinate:mapRect];
    CLLocationCoordinate2D se =  [GeoHelper getSECoordinate:mapRect];
    CLLocationCoordinate2D sw =  [GeoHelper getSWCoordinate:mapRect];
    
    int hashLength = 12;
    NSString *neHash = [GeoHash hashForLatitude:ne.latitude
                                      longitude:ne.longitude
                                         length:hashLength];
    NSString *nwHash = [GeoHash hashForLatitude:nw.latitude
                                      longitude:nw.longitude
                                         length:hashLength];
    NSString *seHash = [GeoHash hashForLatitude:se.latitude
                                      longitude:se.longitude
                                         length:hashLength];
    NSString *swHash = [GeoHash hashForLatitude:sw.latitude
                                      longitude:sw.longitude
                                         length:hashLength];
    
 
    NSBag *bag = [NSBag bag];
    int depth = 12; // chars deep into geohash
    BOOL excludeTopLevel = YES;
    
    for(int i=1;i<=depth;i++){
        if (excludeTopLevel && i == 1) {
            continue;
        }
        [bag add:[neHash substringToIndex:i]];
        [bag add:[nwHash substringToIndex:i]];
        [bag add:[seHash substringToIndex:i]];
        [bag add:[swHash substringToIndex:i]];
    }
    
    
    // NSLog(@"bag:%@",[bag internalDictionary]);
    /*
     9z = 2;
     9z9 = 1;
     9zs = 1;
     cb = 2;
     cb1 = 1;
     cbh = 1;
     */
    
    NSMutableArray *arr = [NSMutableArray array];
    [[bag internalDictionary] enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull obj, NSString*  _Nonnull key, BOOL * _Nonnull stop) {
        if (key.intValue > 1) {
            [arr addObject:obj];
        }
    }];
    
    NSDictionary *d0 = [NSDictionary dictionaryWithObjectsAndKeys:
                        neHash,@"ne",
                        nwHash,@"nw",
                        seHash,@"se",
                        swHash,@"sw",
                        arr,@"mbr",
                        bag,@"bag",nil];
    return d0;
}
+(CLLocationCoordinate2D)getNECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:mRect.origin.y];
}
+(CLLocationCoordinate2D)getNWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMinX(mRect) y:mRect.origin.y];
}
+(CLLocationCoordinate2D)getSECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:MKMapRectGetMaxY(mRect)];
}
+(CLLocationCoordinate2D)getSWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:mRect.origin.x y:MKMapRectGetMaxY(mRect)];
}
+(CLLocationCoordinate2D)getCoordinateFromMapRectanglePoint:(double)x y:(double)y{
    MKMapPoint swMapPoint = MKMapPointMake(x, y);
    return MKCoordinateForMapPoint(swMapPoint);
}

@end
