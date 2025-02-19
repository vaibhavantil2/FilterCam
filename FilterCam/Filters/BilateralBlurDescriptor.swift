//
//  BilateralBlurDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class BilateralBlurDescriptor: FilterDescriptorInterface {
    
    
    let key = "BilateralBlur"
    let title = "Bilateral Blur"
    
    var show: Bool = true
    var rating: Int = 0

    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"distance normalization factor", minimumValue:0.0, maximumValue:16.0, initialValue:10.0, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    fileprivate var lclFilter:BilateralBlur = BilateralBlur() // the actual filter
    fileprivate var stash_distanceNormalizationFactor: Float
    
    
    required init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.distanceNormalizationFactor = parameterConfiguration[0].initialValue
        stash_distanceNormalizationFactor = lclFilter.distanceNormalizationFactor
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func reset(){
        lclFilter.removeAllTargets()
        lclFilter = BilateralBlur()
        restoreParameters()
    }
    
    
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(_ index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.distanceNormalizationFactor
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(_ index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.distanceNormalizationFactor = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(_ index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(_ index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_distanceNormalizationFactor = lclFilter.distanceNormalizationFactor
    }
    
    func restoreParameters(){
        lclFilter.distanceNormalizationFactor = stash_distanceNormalizationFactor
    }
}
