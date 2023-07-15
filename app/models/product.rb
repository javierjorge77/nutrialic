class Product
    attr_accessor :id, :name, :description, :amount_in_cents
    def initialize(id, name, description, amount_in_cents)
        @id = id.to_i
        @name = name.to_s
        @description = description.to_s
        @amount_in_cents = amount_in_cents.to_i
    end
    def self.stripe_nutritionist(id, name, description, amount)
        new(id, name, description, amount)
    end
end