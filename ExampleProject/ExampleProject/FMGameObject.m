//
//  FMOscillator.m
//  ExampleProject
//
//  Created by Adam Boulanger on 6/4/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "FMGameObject.h"
#import "FMGameObjectConstants.h"

@implementation FMGameObject

-(id) initWithOrchestra:(CSDOrchestra *)newOrchestra {
    self = [super initWithOrchestra:newOrchestra];
    if (self) {
        //define opcodes with properties connected to gameBehavior
    
        //H4Y - ARB: uses argument to set output
        CSDFunctionTable *f = [[CSDFunctionTable alloc] 
                                   initWithOutput:@"iSine" 
                                   TableSize:4096 
                                   GenRouting:kGenRoutineSines
                                   AndParameters:@"1"];
        [self addFunctionStatement:f];
        
        //H4Y - ARB: This assumes that CSDFunctionTable is ftgentmp
        //  and will look for [CSDFunctionTable output] during csd conversion
        myFoscilOpcode = [[CSDFoscili alloc] 
                          initFMOscillatorWithAmplitude:[CSDParam paramWithFloat:0.4]
                          kPitch:[CSDParam paramWithPValue:kPValuePitchTag]
                          kCarrier:[CSDParam paramWithInt:1]
                          xModulation:[CSDParam paramWithPValue:kPValueModulationTag]
                          kModIndex:[CSDParam paramWithInt:15]
                          FunctionTable:f
                          AndOptionalPhase:nil];
        [myFoscilOpcode setOutput:FINAL_OUTPUT];
        
        
        [self addOpcode:myFoscilOpcode];
    }
    return self;
}

-(void) playNoteForDuration:(float)dur Pitch:(float)pitch Modulation:(float)modulation {
    int instrumentNumber = [[orchestra instruments] indexOfObject:self] + 1;
    NSString * note = [NSString stringWithFormat:@"%0.2f %0.2f %0.2f", dur, pitch, modulation];
    [[CSDManager sharedCSDManager] playNote:note OnInstrument:instrumentNumber];
}

                    
@end
