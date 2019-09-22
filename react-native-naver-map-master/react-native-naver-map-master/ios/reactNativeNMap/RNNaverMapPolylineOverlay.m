//
//  RNNaverMapPolylineOverlay.m
//  poolusDriver
//
//  Created by flask on 18/04/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//
#import "RNNaverMapPolylineOverlay.h"

#import <React/RCTBridge.h>
#import <React/RCTImageLoader.h>
#import <React/RCTUtils.h>
#import <NMapsMap/NMFNaverMapView.h>
#import <NMapsMap/NMGLatLng.h>
#import <NMapsMap/NMFPolylineOverlay.h>

#import "RCTConvert+NMFMapView.h"

@implementation RNNaverMapPolylineOverlay {
}

- (instancetype)init
{
  if ((self = [super init])) {
    _realOverlay = [NMFPolylineOverlay new];
  }
  return self;
}

- (void)setCoordinates:(NSArray<NMGLatLng *>*) coordinates {
  _realOverlay.points = coordinates;
}

- (void)setStrokeWidth:(CGFloat) strokeWidth {
  _realOverlay.width = strokeWidth;
}

- (void)setStrokeColor:(UIColor*) strokeColor {
  _realOverlay.color = strokeColor;
}

@end
