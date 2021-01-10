//
//  SaltSideDemoTests.swift
//  SaltSideDemoTests
//
//  Created by Dinesh on 09/01/21.
//

import XCTest
@testable import SaltSideDemo

class SaltSideDemoTests: XCTestCase {
    /// List View Controller instance
    var listVC: ListViewController!
    /// UserList Model
    var listUser: [UserModel]!
    
    override func setUpWithError() throws {
        self.listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
        _ = listVC.view
        _ = UINavigationController(rootViewController: self.listVC)
    }

    override func tearDownWithError() throws {
        listVC = nil
        listUser = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    /// TestUserListWebservice call
    func testWebService() {
        // Create an expectation for api call
        let exp = expectation(description: "WebServiceSuccess")
        // Request Call
        UserListWebServices.getUserList(processSuccess: { [unowned self] (data) in
            self.listUser = data
            exp.fulfill()
        }) {
            XCTFail("Api call failed")
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
    /// Check loader view start animating
    func testToggle() {
        listVC.viewModel.getUserList()
        XCTAssert(listVC.viewModel.toggleInteraction == false, "Api Call not made and ToggleInteraction made true")
    }
    
    
    /// Check the user's list count
    func testUserlistCount() {
        let path = Bundle.main.path(forResource: "UserListMock", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        listUser = try? JSONDecoder().decode([UserModel].self, from: data)
        XCTAssertTrue(listUser.count == 7, "Results count not matched")
    }
    
    /// Check if model decodes correctly or not
    func testModelDecode() {
        let path = Bundle.main.path(forResource: "UserListMock", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        listUser = try? JSONDecoder().decode([UserModel].self, from: data)
        XCTAssertNotNil(listUser)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
