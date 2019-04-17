//
//  ViewController.swift
//  Phidgets_MultipleObjects_Test
//
//  Created by Joel Igberase on 2019-04-17.
//  Copyright © 2019 Joel Igberase. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {

    let led = DigitalOutput()
    let button = DigitalInput()
    
    func attach_handler(sender: Phidget){
        do{
            if(try sender.getHubPort() == 0){
                print("Led Attached")
            }
            else{
                print("Button Attached")
            }
            
        } catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        } catch {
            //catch other errors here
        }
    }
    
    func state_change(sender: DigitalInput, state: Bool){
        do{
            if(state == true){
                print("Button Pressed")
                try led.setState(true)
            }
            else{
                print("Button Released")
                try led.setState(false)
            }
        } catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        } catch {
            //catch other errors here
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do{
            //enable server discovery
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address objects
            try led.setDeviceSerialNumber(528025)
            try led.setHubPort(0)
            try led.setIsHubPortDevice(true)
            
            try button.setDeviceSerialNumber(528025)
            try button.setHubPort(1)
            try button.setIsHubPortDevice(true)
            
            //add attach handlers
            let _ = led.attach.addHandler(attach_handler)
            let _ = button.attach.addHandler(attach_handler)
            
            //add state change handlers
            let _ = button.stateChange.addHandler(state_change)
            
            //open objects
            try led.open()
            try button.open()
    
        } catch let err as PhidgetError {
            print("Phidget Error" + err.description)
        } catch {
            //catch other errors here
        }
    }


}

