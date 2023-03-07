class LearningResourceSerializer
  include JSONAPI::Serializer
  
  set_id {"null"}
  set_type :learning_resource
  attributes  :country,
              :video,
              :images
end