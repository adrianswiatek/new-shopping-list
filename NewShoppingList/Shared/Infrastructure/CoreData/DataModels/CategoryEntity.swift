import Foundation
import CoreData

@objc(CategoryEntity)
class CategoryEntity: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var shoppingItems: NSSet
    
    @nonobjc
    static func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }
    
    @nonobjc
    static func fetchAllRequest() -> NSFetchRequest<CategoryEntity> {
        let fetchRequest = CategoryEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
        ]
        return fetchRequest
    }
}

extension CategoryEntity {
    static func fromName(_ name: String, context: NSManagedObjectContext) -> CategoryEntity {
        let entity = CategoryEntity(context: context)
        entity.name = name
        return entity
    }
}
