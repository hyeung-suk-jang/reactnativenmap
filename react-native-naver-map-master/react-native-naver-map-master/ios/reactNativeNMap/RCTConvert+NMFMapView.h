//
//  RCTConvert+RNNaverMapView.h
//  poolusDriver
//
//  Created by flask on 14/04/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTConvert.h>

#import <NMapsMap/NMFMapView.h>

@interface RCTConvert(NMFMapView)

+ (NMFCameraUpdate *) NMFCameraUpdate: (id) json;
+ (NMGLatLng *) NMGLatLng: (id)json;

@end
