//
//  UtilsDefine.swift
//  CrazyJobJournal
//
//  Created by Nanashi Kai Ni on 28/02/23.
//

import SwiftUI


struct Card: ViewModifier {
    init(width:CGFloat,height:CGFloat,angleRotation: Binding<Double>) {
        self.width = width
        self.height = height
        _angleRotation = angleRotation
    }
    private var width: CGFloat
    private var height: CGFloat
    @Binding var angleRotation: Double
    func body(content: Content) -> some View {
        content
            .frame(width: width,height: height)
            .rotationEffect(.degrees(angleRotation))
    }
}


struct ToggleCheckBoxStyle: ToggleStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack{
                Image(systemName: "checkmark.square").symbolVariant(configuration.isOn ? .fill : .none)
                configuration.label
            }
        }.tint(.black)
        
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Optional where Wrapped == NSSet {
    func array<T: Hashable>(of: T.Type) -> [T] {
        if let set = self as? Set<T> {
            return Array(set)
        }
        return [T]()
    }
}

extension Color {
    static let ColorNote = Color("ColorNote")
    static let ColorStroke = Color("ColorStroke")
}

extension Date {
    var startOfNextDay: Date {
        return Calendar.current.nextDate(after: self, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTimePreservingSmallerComponents)!
    }
    var secondsUntilNextDay: TimeInterval {
        return startOfNextDay.timeIntervalSince(self)
    }
}

extension String {

    func toDate(withFormat format: String = "y M d HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

extension Date {

    func toString(withFormat format: String = "y M d HH:mm:ss") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}

extension TimeInterval {
  func asString() -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    return formatter.string(from: self) ?? ""
  }
}
