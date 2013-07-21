class User
  include Mongoid::Document
  field :username, type: String
  field :password, type: String
  field :token, type: String
  field :token_expires, type: DateTime

  validates_presence_of :username
  validates_presence_of :password, on: :create

  def generate_token
    self.token = SecureRandom.hex
    self.token_expires = Time.now + 1.minute
    self.save
  end
end