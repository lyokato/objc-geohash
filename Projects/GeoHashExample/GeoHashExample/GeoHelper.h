
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "NSBag.h"



@interface GeoHelper : NSObject

+(NSString*)geoHashForMapRect:(MKMapRect)mapRect size:(int)size;
+(NSBag*)hashBagForMapRect:(MKMapRect)mapRect;
+(NSDictionary*)hashGridForMapRect:(MKMapRect)mapRect;
+(CLLocationCoordinate2D)getNECoordinate:(MKMapRect)mRect;
+(CLLocationCoordinate2D)getNWCoordinate:(MKMapRect)mRect;
+(CLLocationCoordinate2D)getSECoordinate:(MKMapRect)mRect;
+(CLLocationCoordinate2D)getSWCoordinate:(MKMapRect)mRect;
@end
