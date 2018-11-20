alias Podium.{
  Action,
  API,
  Contact,
  ConversationItem,
  Interaction,
  Message,
  Source
}

import Podium

location_uid = "f45d1aac-da3a-5bfa-a70d-8376bed6d792"
contact = %Podium.Contact{
  name: "Ryan Jones",
  phone_number: "+18018976321"
}
message = %Podium.Message{
  body: "Hey there, :contact:!",
  contact: contact,
  location_uid: location_uid
}
conversation_item = %Podium.ConversationItem{
  contact: contact,
  header: "Hey there",
  subheader: "It's that time again",
  body: "Hey there, :contact:! It's time for your annual checkup",
  location_uid: location_uid,
  icon_url: "",
  source_type: :event,
  publish_date: DateTime.utc_now
}
