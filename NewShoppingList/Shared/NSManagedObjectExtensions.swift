import CoreData

extension NSManagedObjectContext {
    func saveChanges() {
        guard hasChanges else {
            return
        }

        do {
            try save()
        } catch {
            let errorMessage = error.localizedDescription
            assertionFailure("Unable to save changes. Error: " + errorMessage)
        }
    }
}
