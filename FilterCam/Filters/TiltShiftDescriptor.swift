//
//  TiltShiftDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/8/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//


import Foundation
import GPUImage


class TiltShiftDescriptor: FilterDescriptorInterface {
    
    
    
    let key = "TiltShift"
    let title = "Tilt-Shift Lens Effect"
    
    var show: Bool = true
    var rating: Int = 0

    let filter: BasicOperation?  = nil
    var filterGroup: OperationGroup? = nil
    
    let numParameters = 4
    let parameterConfiguration = [ParameterSettings(title:"blur radius", minimumValue:0.0, maximumValue:16.0, initialValue:7.0, isRGB:false),
                                  ParameterSettings(title:"top focus level", minimumValue:0.0, maximumValue:1.0, initialValue:0.4, isRGB:false),
                                  ParameterSettings(title:"bottom focus level", minimumValue:0.0, maximumValue:1.0, initialValue:0.6, isRGB:false),
                                  ParameterSettings(title:"focus fall off rate", minimumValue:0.0, maximumValue:1.0, initialValue:0.2, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    fileprivate var lclFilter:TiltShift = TiltShift() // the actual filter
    fileprivate var stash_blurRadiusInPixels: Float
    fileprivate var stash_topFocusLevel: Float
    fileprivate var stash_bottomFocusLevel: Float
    fileprivate var stash_focusFallOffRate: Float
    
    
    required init(){
        filterGroup = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.blurRadiusInPixels = parameterConfiguration[0].initialValue
        lclFilter.topFocusLevel = parameterConfiguration[1].initialValue
        lclFilter.bottomFocusLevel = parameterConfiguration[2].initialValue
        lclFilter.focusFallOffRate = parameterConfiguration[3].initialValue
        
        stash_blurRadiusInPixels = lclFilter.blurRadiusInPixels
        stash_topFocusLevel = lclFilter.topFocusLevel
        stash_bottomFocusLevel = lclFilter.bottomFocusLevel
        stash_focusFallOffRate = lclFilter.focusFallOffRate
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func reset(){
        lclFilter.removeAllTargets()
        lclFilter = TiltShift()
        restoreParameters()
    }
    
  
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    func getParameter(_ index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.blurRadiusInPixels
        case 2:
            return lclFilter.topFocusLevel
        case 3:
            return lclFilter.bottomFocusLevel
        case 4:
            return lclFilter.focusFallOffRate
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(_ index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.blurRadiusInPixels = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        case 2:
            lclFilter.topFocusLevel = value
            log.debug("\(parameterConfiguration[1].title):\(value)")
            break
        case 3:
            lclFilter.bottomFocusLevel = value
            log.debug("\(parameterConfiguration[2].title):\(value)")
            break
        case 4:
            lclFilter.bottomFocusLevel = value
            log.debug("\(parameterConfiguration[3].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(_ index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(_ index:Int, color:UIColor) {}
    
    
    func stashParameters() {
        stash_blurRadiusInPixels = lclFilter.blurRadiusInPixels
        stash_topFocusLevel = lclFilter.topFocusLevel
        stash_bottomFocusLevel = lclFilter.bottomFocusLevel
        stash_focusFallOffRate = lclFilter.focusFallOffRate
    }
    
    func restoreParameters(){
        lclFilter.blurRadiusInPixels = stash_blurRadiusInPixels
        lclFilter.topFocusLevel = stash_topFocusLevel
        lclFilter.bottomFocusLevel = stash_bottomFocusLevel
        lclFilter.focusFallOffRate = stash_focusFallOffRate
    }
}
