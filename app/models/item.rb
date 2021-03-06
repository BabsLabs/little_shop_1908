class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price
  validates :price, numericality: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates_presence_of :image,
                        :inventory
  validates :inventory, numericality: true
  validates :inventory, numericality: { greater_than_or_equal_to: 1 }
  validates_inclusion_of :active?, :in => [true, false]

  def find_quantity(order)
    order.item_orders.select(:quantity).where(self.id == :item_id)[0].quantity
  end

  def item_subtotal(order)
    self.price * find_quantity(order)
  end

end
