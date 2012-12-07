# encoding: utf-8

configure :development do
  raise "No keys.yml was found" unless File.exist?(keys_file = "config/keys.yml")
  $keys = YAML.load(File.read(keys_file))

  MyMoip.key         = $keys["key"]
  MyMoip.token       = $keys["token"]
  MyMoip.environment = "sandbox"
end

configure :production do
  MyMoip.key         = ENV["KEY"]
  MyMoip.token       = ENV["TOKEN"]
  MyMoip.environment = "production"
end

get "/" do

  request_id = Time.now.to_s

  # First request: what and from who
  #
  payer = MyMoip::Payer.new(
    id: request_id,
    name: "Juquinha da Rocha",
    email: "juquinha@rocha.com",
    address_street: "Felipe Neri",
    address_street_number: "406",
    address_street_extra: "Sala 501",
    address_neighbourhood: "Auxiliadora",
    address_city: "Porto Alegre",
    address_state: "RS",
    address_country: "BRA",
    address_cep: "90440150",
    address_phone: "5130405060"
  )

  instruction = MyMoip::Instruction.new(
    id: request_id,
    payment_reason: "Order in Buy Everything Store",
    values: [100.0],
    payer: payer
  )

  transparent_request = MyMoip::TransparentRequest.new(request_id)
  transparent_request.api_call(instruction)

  # Second request: how
  #
  credit_card = MyMoip::CreditCard.new(
    logo: :visa,
    card_number: "4916654211627608",
    expiration_date: "06/15",
    security_code: "000",
    owner_name: "Juquinha da Rocha",
    owner_birthday: Date.new(1984, 11, 3),
    owner_phone: "5130405060",
    owner_cpf: "52211670695"
  )

  credit_card_payment = MyMoip::CreditCardPayment.new(credit_card, installments: 1)

  @payment_request = MyMoip::PaymentRequest.new(request_id)
  @payment_request.api_call(credit_card_payment, token: transparent_request.token)

  haml :checkout
end
