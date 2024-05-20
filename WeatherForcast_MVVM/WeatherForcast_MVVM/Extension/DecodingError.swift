//
//  DecodingError.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/20/24.
//

extension DecodingError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "\(context.codingPath[0].stringValue)에 들어오는 값이 \(type)과 일치하지 않습니다.\n description: \(context.debugDescription)"
        case .valueNotFound(let value, let context):
            return "Value: \(value)를 찾을 수 없습니다.\n description: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "지정된 키 \(key.stringValue)에 대한 항목을 찾을 수 없습니다.\n description: \(context.debugDescription)"
        case .dataCorrupted(let context):
            return "데이터가 손상되었거나 유효하지 않습니다.\n description: \(context)"
        @unknown default:
            return "데이터를 불러오는 데에 실패했습니다."
        }
    }
}
