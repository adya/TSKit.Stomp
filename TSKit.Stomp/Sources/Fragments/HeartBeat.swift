import Foundation

/// Configuration of the heart-beating.
struct HeartBeat: Equatable {
    
    /// Number that represents what the sender of the frame can do (outgoing heart-beats):
    /// - `0` means it cannot send heart-beats;
    /// - otherwise it is the smallest number of milliseconds between heart-beats that it can guarantee.
    let guaranteed: UInt
    
    /// Number that represents what the sender of the frame would like to get (incoming heart-beats):
    /// - `0` means it does not want to receive heart-beats
    /// - otherwise it is the desired number of milliseconds between heart-beats
    let expected: UInt
}
