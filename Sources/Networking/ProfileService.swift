//
//  ProfileService.swift
//  Ello
//
//  Created by Sean on 2/15/15.
//  Copyright (c) 2015 Ello. All rights reserved.
//

import Foundation

import UIKit
import Moya
import SwiftyJSON

typealias ProfileFollowingSuccessCompletion = (users: [User]) -> ()

struct ProfileService {

    func loadCurrentUser(success: ProfileSuccessCompletion, failure: ElloFailureCompletion?) {
        ElloProvider.sharedProvider.elloRequest(ElloAPI.Profile,
            method: .GET,
            parameters: ElloAPI.Profile.defaultParameters,
            mappingType:MappingType.UsersType,
            success: { (data, responseConfig) in
                if let user = data as? User {
                    success(user: user)
                }
                else {
                    ElloProvider.unCastableJSONAble(failure)
                }
            },
            failure: failure
        )
    }

    func loadCurrentUserFollowing(forRelationship relationship: Relationship, success: ProfileFollowingSuccessCompletion, failure: ElloFailureCompletion?) {
        ElloProvider.sharedProvider.elloRequest(ElloAPI.ProfileFollowing(priority: relationship.rawValue),
            method: .GET,
            parameters: ElloAPI.ProfileFollowing(priority: relationship.rawValue).defaultParameters,
            mappingType: MappingType.UsersType,
            success: { data, responseConfig in
                if let users = data as? [User] {
                    success(users: users)
                }
                else {
                    ElloProvider.unCastableJSONAble(failure)
                }
            },
            failure: failure
        )
    }

}