class Order < ApplicationRecord
    belongs_to :customer

    enum payment_method:{"クレジットカード": 0, "銀行振込": 1}
    enum status: {pending: 0, confirm: 1, processing: 2, preparing: 3, shipped: 4}

    has_many :order_details, dependent: :destroy
end
