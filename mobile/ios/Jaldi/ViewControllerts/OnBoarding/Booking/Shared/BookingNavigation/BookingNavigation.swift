//
//  BookingNavigation.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit
protocol BookingNavigation {
    var progressView: UIProgressView! { get }
    var curretScreen: BookingScreen   { get }
    var bookingObject:BookingObject?  { get }
}
extension BookingNavigation{

    func configureBookingProgress() {
        let animatedProfress = self.animatedProfress()
        progressView?.setProgress(animatedProfress.0, animated: animatedProfress.1)
    }
    func isLastScreen() -> Bool {
        guard let booking = bookingObject , let currentIndex  = currentScreenIndex() else {
            return false
        }
        return currentIndex == (booking.bookingScreens.count - 1)
        
    }
    func nextScreen() -> UIViewController? {
        if self.isLastScreen() {return nil}
        guard let booking = bookingObject , let currentIndex  = currentScreenIndex() else {
            return nil
        }
        let nextScreen = booking.bookingScreens[currentIndex+1]
        return  self.screenWith(bookingScreen: nextScreen)
    }

    //Helpers:
    private func animatedProfress() -> (Float, Bool){
        guard let booking = bookingObject , let currentIndex  = currentScreenIndex() else {
            return (0.0 , false)
        }
        let steps  = booking.bookingScreens.count + 1
        let oneStep = 1.0 / Float(steps)
        let progress =  oneStep * Float(currentIndex) + oneStep
        return (progress , currentIndex != 0)
    
    }
    private func currentScreenIndex() -> Int?{
        guard let booking = bookingObject else {
            return nil
        }
        return booking.bookingScreens.index(of: curretScreen)
        
    }
    //MARK: Next Screen Helpers
    private func screenWith(bookingScreen:BookingScreen) -> UIViewController? {
        switch bookingScreen {
        case .details:
            return self.getBookingDetailsViewController()
        case .desc:
            return self.getBookingDescriptionViewController()
        case .time:
            return self.getBookingTimePickerViewController()
        case .contactInfo:
            return self.getBookingContactInfoViewController()
            
        }
    }
    
    private func getBookingDescriptionViewController() -> UIViewController? {
        let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingDescriptionViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingDescriptionViewController") as? JaldiBookingDescriptionViewController
        bookingDescriptionViewController?.bookingObject = bookingObject
        return bookingDescriptionViewController
    }
    
    private func getBookingTimePickerViewController() -> UIViewController? {
        let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingTimePickerViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingTimePickerViewController") as? JaldiBookingTimePickerViewController
        bookingTimePickerViewController?.bookingObject = bookingObject
        return bookingTimePickerViewController
    }
    
    private func getBookingDetailsViewController() -> UIViewController?  {
        let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingDetailsViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingDetailsViewController") as? JaldiBookingDetailsViewController
        bookingDetailsViewController?.bookingObject = bookingObject
        return bookingDetailsViewController
    }
    
    private func getBookingContactInfoViewController() -> UIViewController?  {
        let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingContactInfoViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingContactInfoViewController") as? JaldiBookingContactInfoViewController
        bookingContactInfoViewController?.bookingObject = bookingObject
        return bookingContactInfoViewController
    }

    
}
