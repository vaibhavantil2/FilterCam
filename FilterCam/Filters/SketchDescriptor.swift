//
//  SketchDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class SketchDescriptor: FilterDescriptorInterface {



    let key = "Sketch"
    let title = "Sketch"
    
    var show: Bool = true
    var rating: Int = 0

    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"edge strength", minimumValue:0.0, maximumValue:4.0, initialValue:1.0, isRGB:false)]

    
    let filterOperationType = FilterOperationType.singleInput
    
    fileprivate var lclFilter:SketchFilter = SketchFilter() // the actual filter
    fileprivate var stash_edgeStrength: Float
    

    required init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.edgeStrength = parameterConfiguration[0].initialValue
        stash_edgeStrength = lclFilter.edgeStrength
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func reset(){
        lclFilter.removeAllTargets()
        lclFilter = SketchFilter()
        restoreParameters()
    }
    
   
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    func getParameter(_ index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.edgeStrength
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(_ index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.edgeStrength = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(_ index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(_ index:Int, color:UIColor) {}
    
    
    func stashParameters() {
        stash_edgeStrength = lclFilter.edgeStrength
    }
    
    func restoreParameters(){
        lclFilter.edgeStrength = stash_edgeStrength
    }
}
