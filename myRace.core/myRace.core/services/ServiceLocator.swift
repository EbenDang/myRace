//
//  ServiceLocator.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

protocol IServiceLocator {
    func register<T>(instance: T)
    func register<T>(recipe: @escaping () -> T)
    func resolve<T>() -> T?
}


class ServiceLocator: IServiceLocator {
    
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
    
    private static var instance: ServiceLocator = {
        return ServiceLocator()
    }()
    
    private init() {
    }
    
    class func shareInstance() -> ServiceLocator {
        return instance
    }
    
    func register<T>(instance: T) {
        let key = typeNmae(some: T.self)
        self.repository[key] = .Instance(instance)
    }
    
    func register<T>(recipe: @escaping () -> T) {
        let key = typeNmae(some: T.self)
        self.repository[key] = .Recipe(recipe)
    }
    
    func resolve<T>() -> T? {
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
