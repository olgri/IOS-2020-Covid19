//
//  CasesStruct.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 11/10/20.
//

import Foundation

struct Case: Decodable {
    var infected: Int?
    var recovered: Int?
    var country: String

    private enum CodingKeys: String, CodingKey {
            case infected, recovered, country
        }

    init(infected: Int? = nil, recovered: Int? = nil, country: String) {
            self.infected = infected
            self.recovered = recovered
            self.country = country
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        infected = try? container.decode(Int.self, forKey: .infected)
        country = try container.decode(String.self, forKey: .country)
        recovered = try? container.decode(Int.self, forKey: .recovered)
    }
}
