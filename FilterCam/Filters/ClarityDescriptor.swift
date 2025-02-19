//
//  ClarityDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class ClarityDescriptor: FilterDescriptorInterface {
    
    
    let key = "Clarity"
    let title = "Clarity"
    
    var show: Bool = true
    var rating: Int = 0

    let filter: BasicOperation?  = nil
    var filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"clarity", minimumValue:0.0, maximumValue:2.0, initialValue:1.0, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    fileprivate var lclFilter:Clarity = Clarity() // the actual filter
    fileprivate var stash_clarity: Float
    
    
    required init(){
        filterGroup = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.clarity = parameterConfiguration[0].initialValue
        stash_clarity = lclFilter.clarity
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func reset(){
        lclFilter.removeAllTargets()
        lclFilter = Clarity()
        restoreParameters()
    }
    
 
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(_ index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.clarity
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(_ index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.clarity = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(_ index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(_ index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_clarity = lclFilter.clarity
    }
    
    func restoreParameters(){
        lclFilter.clarity = stash_clarity
    }
}
