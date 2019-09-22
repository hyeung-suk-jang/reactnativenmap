//
//  RNNaverMapMarker.h
//  poolusDriver
//
//  Created by flask on 18/04/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTBridge.h>
#import <NMapsMap/NMGLatLng.h>
#import <NMapsMap/NMFMarker.h>

#import "RCTConvert+NMFMapView.h"

@interface RNNaverMapMarker : UIView

@property (nonatomic, weak) RCTBridge *bridge;
@property (nonatomic, strong) NMFMarker *realMarker;

@property (nonatomic, assign) NMGLatLng *coordinate;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) UIColor *pinColor;
@property (nonatomic, assign) CGPoint anchor;

@end
