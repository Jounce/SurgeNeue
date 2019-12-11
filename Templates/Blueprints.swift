import SourceryRuntime

enum ScalarType: String, Comparable, Equatable, Hashable, CaseIterable {
    case float = "Float"
    case double = "Double"

    var name: String {
        self.rawValue
    }

    static func < (lhs: ScalarType, rhs: ScalarType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

enum FunctionType: RawRepresentable, Comparable, Equatable, Hashable, CaseIterable {
    typealias RawValue = String

    case unary(UnaryFunctionType)

    var name: String {
        self.rawValue
    }

    var functionName: String {
        self.name.lowercasedFirstLetter()
    }

    var rawValue: String {
        switch self {
        case .unary(let unary): return unary.rawValue
        }
    }

    typealias AllCases = [FunctionType]

    /// A collection of all values of this type.
    static var allCases: AllCases {
        var allCases: AllCases = []

        allCases.append(contentsOf: UnaryFunctionType.allCases.map { Self.unary($0) })

        return allCases
    }

    init?(rawValue: String) {
        if rawValue.hasSuffix("Unary") {
            guard let unary = UnaryFunctionType(rawValue: rawValue) else {
                return nil
            }
            self = .unary(unary)
        } else {
            return nil
        }
    }

    static func < (lhs: FunctionType, rhs: FunctionType) -> Bool {
        switch (lhs, rhs) {
        case (.unary(let lhs), .unary(let rhs)):
            return lhs < rhs
        }
    }
}

enum UnaryFunctionType: String, Comparable, Equatable, Hashable, CaseIterable {
    case externalMutating = "ExternalMutatingUnary"
    case external = "ExternalUnary"
    case internalMutating = "InternalMutatingUnary"
    case `internal` = "InternalUnary"

    var name: String {
        self.rawValue
    }

    var functionName: String {
        self.name.lowercasedFirstLetter()
    }

    static func < (lhs: UnaryFunctionType, rhs: UnaryFunctionType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct Blueprint {
    let name: String
    let baseTypes: [FunctionType: [ScalarType]]
    let deriveTypes: [FunctionType]

    var functionName: String {
        self.name.prefix(1).lowercased() + self.name.dropFirst()
    }

    init(
        name: String,
        baseTypes: [FunctionType: Set<ScalarType>],
        deriveTypes: Set<FunctionType>
    ) {
        self.name = name
        self.baseTypes = baseTypes.mapValues { $0.sorted() }
        self.deriveTypes = deriveTypes.sorted()
    }
}

func blueprints(from types: Types) -> [Blueprint] {
    return types.based["SurgeBlueprint"].compactMap { type in
        let baseKeys = type.based.keys
        guard let deriveKeys = (type.annotations["derive"] as? [String: Any])?.keys else {
            return nil
        }

        return Blueprint(
            name: type.name,
            baseTypes: baseTypes(from: baseKeys),
            deriveTypes: deriveTypes(from: deriveKeys)
        )
    }
}

private func deriveTypes<S>(from keys: S) -> Set<FunctionType>
where
    S: Sequence,
    S.Element == String
{
    return Set(keys.compactMap(FunctionType.init(rawValue:)))
}

private func baseTypes<S>(from keys: S) -> [FunctionType: Set<ScalarType>]
where
    S: Sequence,
    S.Element == String
{
    var baseTypes: [FunctionType: Set<ScalarType>] = [:]
    for key in keys {
        let suffix = "Blueprint"
        guard key.hasSuffix(suffix) else {
            continue
        }
        let key = key.dropLast(suffix.count)
        for scalarType in ScalarType.allCases {
            let suffix = scalarType.rawValue
            if key.hasSuffix(suffix) {
                let functionKey = key.dropLast(suffix.count)
                guard let functionType = FunctionType(rawValue: String(functionKey)) else {
                    continue
                }
                baseTypes[functionType, default: []].insert(scalarType)
            }
        }
    }
    return baseTypes
}

extension String {
    internal func lowercasedFirstLetter() -> String {
        self.prefix(1).lowercased() + self.dropFirst()
    }
}
