/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Json4Swift_Base : Codable {
	let message : String?
	let request_id : Int?
	let order : Order?

	enum CodingKeys: String, CodingKey {

		case message = "message"
		case request_id = "request_id"
		case order = "order"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		request_id = try values.decodeIfPresent(Int.self, forKey: .request_id)
		order = try values.decodeIfPresent(Order.self, forKey: .order)
	}


struct Order : Codable {
    let order_id : String?
    let delivery_to : String?
    let warehouse_lat : String?
    let warehouse_lng : String?
    let customer_name : String?
    let customer_mobile : String?
    let customer_lat : String?
    let customer_lng : String?
    let product_name : String?
    let product_qty : String?
    let product_weight : String?
    let payment_status : String?
    let delivery_method : String?
    let warehouse_address : String?
    let customer_address : String?
    let product_width : String?
    let product_height : String?
    let service_type : Int?
    let tracking_id : Int?
    let otp : Int?
    let route_key : String?
    let status : String?
    let user_id : Int?
    let current_provider_id : Int?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case delivery_to = "delivery_to"
        case warehouse_lat = "warehouse_lat"
        case warehouse_lng = "warehouse_lng"
        case customer_name = "customer_name"
        case customer_mobile = "customer_mobile"
        case customer_lat = "customer_lat"
        case customer_lng = "customer_lng"
        case product_name = "product_name"
        case product_qty = "product_qty"
        case product_weight = "product_weight"
        case payment_status = "payment_status"
        case delivery_method = "delivery_method"
        case warehouse_address = "warehouse_address"
        case customer_address = "customer_address"
        case product_width = "product_width"
        case product_height = "product_height"
        case service_type = "service_type"
        case tracking_id = "tracking_id"
        case otp = "otp"
        case route_key = "route_key"
        case status = "status"
        case user_id = "user_id"
        case current_provider_id = "current_provider_id"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
        delivery_to = try values.decodeIfPresent(String.self, forKey: .delivery_to)
        warehouse_lat = try values.decodeIfPresent(String.self, forKey: .warehouse_lat)
        warehouse_lng = try values.decodeIfPresent(String.self, forKey: .warehouse_lng)
        customer_name = try values.decodeIfPresent(String.self, forKey: .customer_name)
        customer_mobile = try values.decodeIfPresent(String.self, forKey: .customer_mobile)
        customer_lat = try values.decodeIfPresent(String.self, forKey: .customer_lat)
        customer_lng = try values.decodeIfPresent(String.self, forKey: .customer_lng)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        product_qty = try values.decodeIfPresent(String.self, forKey: .product_qty)
        product_weight = try values.decodeIfPresent(String.self, forKey: .product_weight)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        delivery_method = try values.decodeIfPresent(String.self, forKey: .delivery_method)
        warehouse_address = try values.decodeIfPresent(String.self, forKey: .warehouse_address)
        customer_address = try values.decodeIfPresent(String.self, forKey: .customer_address)
        product_width = try values.decodeIfPresent(String.self, forKey: .product_width)
        product_height = try values.decodeIfPresent(String.self, forKey: .product_height)
        service_type = try values.decodeIfPresent(Int.self, forKey: .service_type)
        tracking_id = try values.decodeIfPresent(Int.self, forKey: .tracking_id)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
        route_key = try values.decodeIfPresent(String.self, forKey: .route_key)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        current_provider_id = try values.decodeIfPresent(Int.self, forKey: .current_provider_id)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}

}
