//
//  ZARAfitTests.swift
//  ZARAfitTests
//
//  Created by Davit on 22/09/23.
//

import XCTest
@testable import ZARAfit
class FakeInteractor: CharactersListInteractorProtocol {
    var simulateError = false // Flag to simulate a network error

    func loadCharacters(completion: @escaping (Result<CharacterObjectResponse?, Error>) -> Void) {
        if simulateError {
            let error = NSError(domain: "com.rickandmortyapi.network", code: -1009, userInfo: nil) // Simulated network error
            completion(.failure(error))
        } else {
            completion(.success(CharacterObjectResponseMock.createMock()))
        }
    }
    
    var presenter: CharactersListPresenterProtocol?
    
    struct CharacterObjectResponseMock {
        static func createMock() -> CharacterObjectResponse {
            let info = InformationObject(count: 2, pages: 12, next: nil, prev: nil)

            let character1 = CharacterObject(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "Genius",
                gender: "Male",
                origin: CharacterOriginObject(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: CharacterLocationObject(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"],
                url: "https://rickandmortyapi.com/api/character/1",
                created: "2017-11-04T18:48:46.250Z"
            )

            let character2 = CharacterObject(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: CharacterOriginObject(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: CharacterLocationObject(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/3"],
                url: "https://rickandmortyapi.com/api/character/2",
                created: "2017-11-04T18:50:21.651Z"
            )

            let results = [character1, character2]

            return CharacterObjectResponse(info: info, results: results)
        }
    }
}

final class ZARAfitTests: XCTestCase {
    var presenter: CharactersListPresenterProtocol?
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let interactor = FakeInteractor()
        self.presenter = CharactersListPresenter()
        self.presenter?.interactor = interactor
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        self.presenter = nil
    }
    func listCharactersAndAssert() {
           presenter?.listCharacters()
           XCTAssertNotNil(presenter?.characters)
           XCTAssert(presenter?.characters?.count ?? 0 > 0)
       }
    private func isValidURL(_ urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func testCharactersList() throws {
        listCharactersAndAssert()
    }
    func testCharacterPages() throws {
        listCharactersAndAssert()
        XCTAssert(self.presenter?.totalPages == 12)
    }
    func testCharacterStatus() throws {
        listCharactersAndAssert()
        let validStatuses = ["Alive", "Dead", "unknown"]
        
        for character in presenter?.characters ?? [] {
            XCTAssert(validStatuses.contains(character.status), "Invalid character status: \(character.status)")
        }
    }
    func testCharacterImages() throws {
        listCharactersAndAssert()
        
        for character in presenter?.characters ?? [] {
            XCTAssertTrue(isValidURL(character.image), "Invalid character image URL: \(character.image)")
        }
    }
    func testCharacterOriginURL() throws {
        listCharactersAndAssert()
        
        for character in presenter?.characters ?? [] {
            XCTAssertTrue(isValidURL(character.origin.url), "Invalid character origin URL: \(character.origin.url)")
        }
    }
    func testNetworkError() throws {
        let interactor = FakeInteractor()
        interactor.simulateError = true // Simulate a network error
        presenter = CharactersListPresenter()
        presenter?.interactor = interactor
        interactor.presenter = presenter

        let expectation = self.expectation(description: "Network Error Expectation")
        
        presenter?.listCharacters()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.presenter?.characters, "Characters should be nil on network error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            presenter?.listCharacters()
        }
    }

}
