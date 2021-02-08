//
//  Alert.swift
//  Appetizers
//
//  Created by Tristan on 03/12/2020.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    // - Network Alerts
    
    static let invalidURL = AlertItem(
        title: Text("Server Error"),
        message: Text("There was an issue connecting to the server. Please contact support."),
        dismissButton: .default(Text("Ok")))
    
    static let invalidResponse = AlertItem(
        title: Text("Server Error"),
        message: Text("Invalid response from the server. Please try letter or contact the server."),
        dismissButton: .default(Text("Ok")))
    
    static let invalidData = AlertItem(
        title: Text("Server Error"),
        message: Text("The data received from the server is invalid. Please contact support."),
        dismissButton: .default(Text("Ok")))
    
    static let unableToComplete = AlertItem(
        title: Text("Server Error"),
        message: Text("Unable to complete your resquest at this time. Please check you internet connection."),
        dismissButton: .default(Text("Ok")))
    
    // - Account Alerts
    
    static let missingInfo = AlertItem(
        title: Text("Missing Information"),
        message: Text("Please ensure all fields in the form have been filled out."),
        dismissButton: .default(Text("Ok")))
    
    static let wrongFormat = AlertItem(
        title: Text("Invalid Email"),
        message: Text("Please ensure your email is correct."),
        dismissButton: .default(Text("Ok")))
    
    static let userSaveSuccess = AlertItem(
        title: Text("Profile Saved"),
        message: Text("Your profile information was successfully saved!"),
        dismissButton: .default(Text("Ok")))
    
    static let invalidUserData = AlertItem(
        title: Text("Profile Error"),
        message: Text("There was an error saving or retrieving your profile"),
        dismissButton: .default(Text("Ok")))
}