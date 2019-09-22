//
//  RNNaverMapViewManager.m
//  poolusDriver
//
//  Created by flask on 14/04/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//
#import <React/RCTBridge.h>
#import <React/RCTViewManager.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTUIManager.h>

#import <NMapsMap/NMFNaverMapView.h>
#import <NMapsMap/NMFCameraUpdate.h>
#import <NMapsMap/NMGLatLng.h>

#import "RCTConvert+NMFMapView.h"
#import "RNNaverMapView.h"

@interface RNNaverMapViewManager : RCTViewManager

@end

@implementation RNNaverMapViewManager

RCT_EXPORT_MODULE(RNNaverMapView)

-(UIView *)view
{
  RNNaverMapView *map = [[RNNaverMapView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
  return map;
}

RCT_CUSTOM_VIEW_PROPERTY(center, NMFCameraUpdate*, RNNaverMapView)
{
  if (json == nil) return;
  [view.mapView moveCamera: [RCTConvert NMFCameraUpdate: json]];
  // TODO use `NMFCameraUpdateWith` if latlng, zoom, tilt, bearing exist.
}

RCT_CUSTOM_VIEW_PROPERTY(showsMyLocationButton, BOOL, RNNaverMapView)
{
  if (json == nil) return;
  view.showLocationButton = json;
}

RCT_CUSTOM_VIEW_PROPERTY(mapPadding, UIEdgeInsets, RNNaverMapView)
{
  if (json == nil) return;
  view.mapView.contentInset = [RCTConvert UIEdgeInsets: json];
}

RCT_CUSTOM_VIEW_PROPERTY(mapType, int, RNNaverMapView)
{
  if (json == nil) return;
  int type = [json intValue];
  if (type == 0) {
    view.mapView.mapType = NMFMapTypeBasic;
  } else if (type == 1) {
    view.mapView.mapType = NMFMapTypeNavi;
  } else if (type == 2) {
    view.mapView.mapType = NMFMapTypeSatellite;
  } else if (type == 3) {
    view.mapView.mapType = NMFMapTypeHybrid;
  } else if (type == 4) {
    view.mapView.mapType = NMFMapTypeTerrain;
  }
}

RCT_CUSTOM_VIEW_PROPERTY(compass, BOOL, RNNaverMapView)
{
  if (json == nil) view.showCompass = NO;
  view.showCompass = json;
}

RCT_CUSTOM_VIEW_PROPERTY(scaleBar, BOOL, RNNaverMapView)
{
  if (json == nil) view.showScaleBar = NO;
  view.showScaleBar = json;
}

RCT_CUSTOM_VIEW_PROPERTY(zoomControl, BOOL, RNNaverMapView)
{
  if (json == nil) view.showZoomControls = NO;
  view.showZoomControls = json;
}

RCT_CUSTOM_VIEW_PROPERTY(buildingHeight, NSNumber*, RNNaverMapView)
{
  if (json == nil) view.mapView.buildingHeight = 1.0f;
  view.mapView.buildingHeight = [json floatValue];
}

RCT_CUSTOM_VIEW_PROPERTY(nightMode, BOOL, RNNaverMapView)
{
  if (json == nil) view.mapView.nightModeEnabled = NO;
  view.mapView.nightModeEnabled = json;
}

RCT_CUSTOM_VIEW_PROPERTY(tilt, BOOL, RNNaverMapView)
{
  // TODO
}

RCT_CUSTOM_VIEW_PROPERTY(bearing, BOOL, RNNaverMapView)
{
  // TODO
}

RCT_EXPORT_METHOD(setLocationTrackingMode:(nonnull NSNumber *)reactTag
                  withMode: (NSNumber *) mode
                  )
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    id view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNNaverMapView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting NMFMapView, got: %@", view);
    } else {
      if (mode.intValue == 0) {
        ((RNNaverMapView *)view).positionMode = NMFMyPositionDisabled;
      } else if (mode.intValue == 1) {
        ((RNNaverMapView *)view).positionMode = NMFMyPositionNormal;
      } else if (mode.intValue == 2) {
        ((RNNaverMapView *)view).positionMode = NMFMyPositionDirection;
      } else if (mode.intValue == 3) {
        ((RNNaverMapView *)view).positionMode = NMFMyPositionCompass;
      }
    }
  }];
}

RCT_EXPORT_METHOD(animateToTwoCoordinates:(nonnull NSNumber *)reactTag
                  withCoord1: (NMGLatLng *) coord1
                  withCoord2: (NMGLatLng *) coord2
                  )
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    id view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNNaverMapView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting NMFMapView, got: %@", view);
    } else {
      NMFCameraUpdate* cameraUpdate = [NMFCameraUpdate
                                       cameraUpdateWithFitBounds:
                                       NMGLatLngBoundsMake(MAX(coord1.lat, coord2.lat),
                                                           MIN(coord1.lng, coord2.lng),
                                                           MIN(coord1.lat, coord2.lat),
                                                           MAX(coord1.lng, coord2.lng))
                                       padding: 24.0f];
      cameraUpdate.animation = NMFCameraUpdateAnimationEaseIn;
      [((RNNaverMapView *)view).mapView moveCamera: cameraUpdate];
    }
  }];
}

@end
