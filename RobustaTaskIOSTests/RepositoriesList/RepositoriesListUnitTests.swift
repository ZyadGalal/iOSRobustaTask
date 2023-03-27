//
//  RepositoriesListUnitTests.swift
//  RobustaTaskIOSTests
//
//  Created by Zyad Galal on 27/03/2023.
//

import XCTest
import Combine
@testable import RobustaTaskIOS

final class RepositoriesListUnitTests: XCTestCase {
    var viewModel: RepositoriesListViewModelType!
    var repo: RepositoriesListRepoSpy!
    var router: RepositoriesListRouterSpy!
    var cancellables = Set<AnyCancellable>()
    override func setUp() {
        super.setUp()
        repo = RepositoriesListRepoSpy()
        router = RepositoriesListRouterSpy()
        viewModel = RepositoriesListViewModel(repo: repo, router: router)
    }
    
    override func tearDown() {
        repo = nil
        router = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchingReposSuccess() {
        // Given

        repo.repoListResultToBeReturn = .success(getRepos())
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertGreaterThan(viewModel.getRepositoriesCount(), 0)
    }

    func testFetchingReposError() {
        // Given
        let expectation = expectation(description: "api error")
        let responseError = ApiError.missingData
        var error: Error?
        repo.repoListResultToBeReturn = .failure(responseError)
        
        // When
        viewModel.viewDidLoad()
        viewModel.repositoriesRepoPublisher
            .receive(on: DispatchQueue.main)
            .sink { subscription in
                switch subscription {
                case .failure(let err):
                    error = err
                    expectation.fulfill()
                case .finished:
                    print("done")
                }
            } receiveValue: { () in }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(error)
    }

    func testDidSelectRepo() {
        // Given
        repo.repoListResultToBeReturn = .success(getRepos())
        
        // When
        viewModel.viewDidLoad()
        viewModel.didSelectRepo(at: 0)
        
        // Then
        XCTAssertGreaterThan(router.showRepoDetailsCallCount, 0)
    }

    func testSearchTextWithLessThanTwo() {
        // Given
        repo.repoListResultToBeReturn = .success(getRepos())

        // When
        viewModel.viewDidLoad()
        viewModel.searchTextUpdated(with: "a")
        
        // Then
        XCTAssertEqual(viewModel.getRepositoriesCount(), 2)
    }

    func testSearchTextWithMoreThanTwo() {
        // Given
        repo.repoListResultToBeReturn = .success(getRepos())

        // When
        viewModel.viewDidLoad()
        viewModel.searchTextUpdated(with: "roubusta")
        
        // Then
        XCTAssertEqual(viewModel.getRepositoriesCount(), 1)
    }

    func testSearchTextEmptyResult() {
        // Given
        repo.repoListResultToBeReturn = .success(getRepos())

        // When
        viewModel.viewDidLoad()
        viewModel.searchTextUpdated(with: "task")
        
        // Then
        XCTAssertEqual(viewModel.getRepositoriesCount(), 0)
    }

    func testGetRepoItem() {
        // Given
        repo.repoListResultToBeReturn = .success(getRepos())

        // When
        viewModel.viewDidLoad()
        let item = viewModel.getRepositoryItem(at: 0)
        
        // Then
        XCTAssertEqual(item.repositoryName, "test")
    }
}

private extension RepositoriesListUnitTests {
    func getRepos() -> [RepositoriesEntity]{
        let repoOneEntity = RepositoriesEntity(repositoryName: "test",
                                            repositoryOwner: "zyad",
                                            ownerImageURL: "https://www.google.com",
                                            isPrivateRepo: false,
                                            description: "test test")
        
        let repoTwoEntity = RepositoriesEntity(repositoryName: "roubusta",
                                            repositoryOwner: "zyad2",
                                            ownerImageURL: "https://www.google.com",
                                            isPrivateRepo: false,
                                            description: "test test")
       return [repoOneEntity, repoTwoEntity]
    }
}
