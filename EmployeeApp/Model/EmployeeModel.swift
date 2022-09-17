
import Foundation
struct EmployeeModel : Codable {
	let identifier : Int?
	let name : String?
	let username : String?
	let email : String?
	let profile_image : String?
	let address : AddressModel?
	let phone : String?
	let website : String?
	let company : CompanyModel?

	enum CodingKeys: String, CodingKey {

		case identifier = "id"
		case name = "name"
		case username = "username"
		case email = "email"
		case profile_image = "profile_image"
		case address = "address"
		case phone = "phone"
		case website = "website"
		case company = "company"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		identifier = try values.decodeIfPresent(Int.self, forKey: .identifier)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
		address = try values.decodeIfPresent(AddressModel.self, forKey: .address)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		website = try values.decodeIfPresent(String.self, forKey: .website)
		company = try values.decodeIfPresent(CompanyModel.self, forKey: .company)
	}

}
