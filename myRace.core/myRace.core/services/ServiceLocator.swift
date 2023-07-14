//
//  ServiceLocator.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

public protocol ServiceLocator {
    func register<T>(instance: T)
    func register<T>(recipe: @escaping () -> T)
    func resolve<T>() -> T?
}


open class ServiceLocatorImpl: ServiceLocator {
    
    enum RegistryRec {
        case Instance(Any)
        case Recipe(() -> Any)
        
        func unwap() -> Any {
            switch self {
            case .Instance(let instance):
                return instance
            case .Recipe(let recipe):
                return recipe()
            }
        }
    }
    
    private lazy var repository: Dictionary<String, RegistryRec> = [:]
    
    private static var instance: ServiceLocatorImpl = {
        return ServiceLocatorImpl()
    }()
    
    private init() {
    }
    
    public class func shareInstance() -> ServiceLocatorImpl {
        return instance
    }
    
    public func register<T>(instance: T) {
        let key = typeNmae(some: T.self)
        self.repository[key] = .Instance(instance)
    }
    
    public func register<T>(recipe: @escaping () -> T) {
        let key = typeNmae(some: T.self)
        self.repository[key] = .Recipe(recipe)
    }
    
    public func resolve<T>() -> T? {
        let key = self.typeNmae(some: T.self)
        var instance: T?
        if let record = self.repository[key] {
            instance = record.unwap() as? T
            switch record {
            case .Recipe:
                if let instance = instance {
                    self.register(instance: instance)
                }
            default:
                break
            }
        }
        
        return instance
    }
    
    private func typeNmae(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
}
