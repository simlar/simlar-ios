/**
 * Copyright (C) 2014 The Simlar Authors.
 *
 * This file is part of Simlar. (https://www.simlar.org)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "SMLRNetworkQuality.h"

SMLRNetworkQuality createNetworkQualityWithFloat(const float quality)
{
    if (4 <= quality && quality <= 5) {
        return SMLRNetworkQualityGood;
    }

    if (3 <= quality && quality < 4) {
        return SMLRNetworkQualityAverage;
    }

    if (2 <= quality && quality < 3) {
        return SMLRNetworkQualityPoor;
    }

    if (1 <= quality && quality < 2) {
        return SMLRNetworkQualityVeryPoor;
    }

    if (0 <= quality && quality < 1) {
        return SMLRNetworkQualityUnusable;
    }

    return SMLRNetworkQualityUnknown;
}

NSString *nameForSMLRNetworkQuality(const SMLRNetworkQuality quality)
{
    switch (quality) {
        case SMLRNetworkQualityGood:     return @"GOOD";
        case SMLRNetworkQualityAverage:  return @"AVERAGE";
        case SMLRNetworkQualityPoor:     return @"POOR";
        case SMLRNetworkQualityVeryPoor: return @"VERY_POOR";
        case SMLRNetworkQualityUnusable: return @"UNUSABLE";
        case SMLRNetworkQualityUnknown:  return @"UNKNOWN";
    }
}

NSString *guiTextForSMLRNetworkQuality(const SMLRNetworkQuality quality)
{
    switch (quality) {
        case SMLRNetworkQualityGood:     return @"good";
        case SMLRNetworkQualityAverage:  return @"average";
        case SMLRNetworkQualityPoor:     return @"poor";
        case SMLRNetworkQualityVeryPoor: return @"very poor";
        case SMLRNetworkQualityUnusable: return @"unusable";
        case SMLRNetworkQualityUnknown:  return @"unknown";
    }
}
