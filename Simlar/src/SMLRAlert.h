/**
 * Copyright (C) 2017 The Simlar Authors.
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

#import <Foundation/Foundation.h>

@interface SMLRAlert : NSObject

+ (void)showWithViewController:(UIViewController *const)viewController
                         title:(NSString *const)title
                       message:(NSString *const)message;

+ (void)showWithViewController:(UIViewController *const)viewController
                         title:(NSString *const)title
                       message:(NSString *const)message
              closeButtonTitle:(NSString *const)closeButtonTitle;

+ (void)showWithViewController:(UIViewController *const)viewController
                         title:(NSString *const)title
                       message:(NSString *const)message
                   buttonTitle:(NSString *const)buttonTitle
                 buttonHandler:(void (^)())buttonHandler;

+ (void)showWithViewController:(UIViewController *const)viewController
                         title:(NSString *const)title
                       message:(NSString *const)message
              abortButtonTitle:(NSString *const)abortButtonTitle
            abortButtonHandler:(void (^)())abortButtonHandler
           continueButtonTitle:(NSString *const)continueButtonTitle
         continueButtonHandler:(void (^)())continueButtonHandler;

@end
