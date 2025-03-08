import UIKit

protocol ObjectMapper {
    associatedtype Object
    func map(_ json: [String: Any]) -> Object?
}

class ObjectMapperImplementation: ObjectMapper {
    typealias Object = Int
    
    func map(_ json: [String : Any]) -> Int? {
        return nil
    }
}

class ArticaleService {
    var mapper: any ObjectMapper
    
    init(mapper: any ObjectMapper) {
        self.mapper = mapper
    }
}
