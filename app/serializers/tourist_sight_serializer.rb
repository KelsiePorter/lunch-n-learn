class TouristSightSerializer
  include JSONAPI::Serializer
  
  set_id {"null"}
  set_type :tourist_sight
  attributes  :name,
              :address,
              :place_id
end