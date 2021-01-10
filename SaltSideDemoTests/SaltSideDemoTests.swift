//
//  SaltSideDemoTests.swift
//  SaltSideDemoTests
//
//  Created by Dinesh on 09/01/21.
//

import XCTest
@testable import SaltSideDemo

class SaltSideDemoTests: XCTestCase {
    var listVC: ListViewController!
    var listUser: [UserModel]!
    
    override func setUpWithError() throws {
        self.listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
        _ = listVC.view
        _ = UINavigationController(rootViewController: self.listVC)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testWebService() {
        let exp = expectation(description: "WebServiceSuccess")
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
    
    func testToggle() {
        listVC.viewModel.getUserList()
        XCTAssert(listVC.viewModel.toggleInteraction == false, "Api Call not made and ToggleInteraction made true")
    }
    
    
    func testUserlistCount() {
        let path = Bundle.main.path(forResource: "UserListMock", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        listUser = try? JSONDecoder().decode([UserModel].self, from: data)
        XCTAssertTrue(listUser.count == 7, "Results count not matched")
    }
    
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
