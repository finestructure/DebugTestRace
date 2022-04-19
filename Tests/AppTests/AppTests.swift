@testable import App

import Fluent
import SQLKit
import Vapor
import XCTVapor


enum Variants {
    case triggerAssertWithAnotherELF
    case triggerAssertWithELFAnd
    case noAssertWithSingleELF
    case noAssertWithoutUnwarp
    case noAssertWithAsync
}


final class AppTests: XCTestCase {

    struct Record: Codable { var id: UUID }

    func query(_ db: Database) -> EventLoopFuture<Record?> {
        (db as! SQLDatabase).raw(#"""
            select id from todos
            """#)
        .first(decoding: Record.self)
    }

    func queryAsync(_ db: Database) async throws -> Record? {
        try await (db as! SQLDatabase).raw(#"""
            select id from todos
            """#)
        .first(decoding: Record.self)
    }

    func _test() async throws {
        // setup
        let app = Application(.testing)
        try configure(app)
        let db = app.db
        defer {
            // adding usleep avoids hitting asserts for all variants
            //            usleep(100_000)
            app.shutdown()
        }
        do {
            // ensure we're testing with the db available
            try await Todo(title: "foo").create(on: db)
            let count = try await Todo.query(on: db).count()
            XCTAssertTrue(count > 0)
        }
        do {
            // but delete all records - raising the exception when calling .first() seems
            // to be relevant to trigger the assert
            try await Todo.query(on: db).delete()
            let count = try await Todo.query(on: db).count()
            XCTAssertEqual(count, 0)
        }

        let variant = Variants.noAssertWithSingleELF

        switch variant {
            case .triggerAssertWithAnotherELF:
                let query1 = query(db)
                    .unwrap(or: Abort(.notFound))
                // just the presence of another ELF triggers the assert
                _ = query(db)
                _ = try? await query1.get()

            case .triggerAssertWithELFAnd:
                let query1 = query(db)
                    .unwrap(or: Abort(.notFound))
                let query2 = query(db)
                // as well as .and(...) chaining
                _ = try? await query1.and(query2).get()

            case .noAssertWithoutUnwarp:
                let query1 = query(db)
                let query2 = query(db)
                _ = try? await query1.and(query2).get()

            case .noAssertWithSingleELF:
                let query1 = query(db)
                    .unwrap(or: Abort(.notFound))
                // this by itself does not trigger
                _ = try? await query1.get()

            case .noAssertWithAsync:
                _ = try? await queryAsync(db)
                _ = try? await queryAsync(db)
        }
    }

    func test_race_00() async throws { try await _test() }
    func test_race_01() async throws { try await _test() }
    func test_race_02() async throws { try await _test() }
    func test_race_03() async throws { try await _test() }
    func test_race_04() async throws { try await _test() }
    func test_race_05() async throws { try await _test() }
    func test_race_06() async throws { try await _test() }
    func test_race_07() async throws { try await _test() }
    func test_race_08() async throws { try await _test() }
    func test_race_09() async throws { try await _test() }
    func test_race_10() async throws { try await _test() }
    func test_race_11() async throws { try await _test() }
    func test_race_12() async throws { try await _test() }
    func test_race_13() async throws { try await _test() }
    func test_race_14() async throws { try await _test() }
    func test_race_15() async throws { try await _test() }
    func test_race_16() async throws { try await _test() }
    func test_race_17() async throws { try await _test() }
    func test_race_18() async throws { try await _test() }
    func test_race_19() async throws { try await _test() }
    func test_race_20() async throws { try await _test() }
    func test_race_21() async throws { try await _test() }
    func test_race_22() async throws { try await _test() }
    func test_race_23() async throws { try await _test() }
    func test_race_24() async throws { try await _test() }
    func test_race_25() async throws { try await _test() }
    func test_race_26() async throws { try await _test() }
    func test_race_27() async throws { try await _test() }
    func test_race_28() async throws { try await _test() }
    func test_race_29() async throws { try await _test() }
    func test_race_30() async throws { try await _test() }
    func test_race_31() async throws { try await _test() }
    func test_race_32() async throws { try await _test() }
    func test_race_33() async throws { try await _test() }
    func test_race_34() async throws { try await _test() }
    func test_race_35() async throws { try await _test() }
    func test_race_36() async throws { try await _test() }
    func test_race_37() async throws { try await _test() }
    func test_race_38() async throws { try await _test() }
    func test_race_39() async throws { try await _test() }
    func test_race_40() async throws { try await _test() }
    func test_race_41() async throws { try await _test() }
    func test_race_42() async throws { try await _test() }
    func test_race_43() async throws { try await _test() }
    func test_race_44() async throws { try await _test() }
    func test_race_45() async throws { try await _test() }
    func test_race_46() async throws { try await _test() }
    func test_race_47() async throws { try await _test() }
    func test_race_48() async throws { try await _test() }
    func test_race_49() async throws { try await _test() }

}
