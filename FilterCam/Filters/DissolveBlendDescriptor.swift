//
//  DissolveBlendDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class DissolveBlendDescriptor: FilterDescriptorInterface {
    
    
    let key = "DissolveBlend"
    let title = "Dissolve Blend"
    
    var show: Bool = true
    var rating: Int = 0

    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"mix", minimumValue:0.0, maximumValue:1.0, initialValue:0.5, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.blend
    
    fileprivate var lclFilter:DissolveBlend = DissolveBlend() // the actual filter
    fileprivate var stash_mix: Float
    
    
    required init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.mix = parameterConfiguration[0].initialValue
        stash_mix = lclFilter.mix
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func reset(){
        lclFilter.removeAllTargets()
        lclFilter = DissolveBlend()
        restoreParameters()
    }
    
   
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(_ index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.mix
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(_ index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.mix = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(_ index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(_ index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_mix = lclFilter.mix
    }
    
    func restoreParameters(){
        lclFilter.mix = stash_mix
    }
}
