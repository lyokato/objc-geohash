//
//  GeoHashExampleViewController.m
//  GeoHashExample
//
//  Created by KATO Lyo on 11/12/28.
//  Copyright 2011 KATO Lyo. All rights reserved.
//

#import "GeoHashExampleViewController.h"
#import "GeoHash.h"
#import <MapKit/MapKit.h>

@implementation GeoHashExampleViewController

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /* Get GetHash by latitude, longitude, and hash-length */
    
    NSString *hash = [GeoHash hashForLatitude:40.753683
                                    longitude:-73.972640
                                       length:12];
    
    /* hash equals to @"xn774c06kdtve" */
    NSLog(@"hash:%@",hash);
    

    
    // New York City - 800m grid
    CLLocationCoordinate2D ny = CLLocationCoordinate2DMake(40.753683, -73.972640);
    double distance = 800;
    
    CLLocationDistance latMetersPerPoint = MKMetersPerMapPointAtLatitude(ny.latitude);
    CLLocationDistance lngMetersPerPoint = MKMetersPerMapPointAtLatitude(ny.longitude);
    
    double latPts = latMetersPerPoint *distance;
    double lngPts =  lngMetersPerPoint *distance;
    
    MKMapPoint ptNY = MKMapPointForCoordinate(ny);
    MKMapRect mapRect = MKMapRectMake(ptNY.x, ptNY.y, latPts, lngPts);
    
    NSDictionary *hashGrid = [GeoHelper hashGridForMapRect:mapRect];
    NSArray *array = [hashGrid valueForKey:@"mbr"];
    NSBag *bag = [hashGrid valueForKey:@"bag"];
    NSLog(@"bag:%@",bag.internalDictionary);
    NSLog(@"array:%@",array);
    

}
@end


