class RecipeSerializer
  include JSONAPI::Serializer
  
  set_id {"null"}
  attributes  :title,
              :image,
              :url,
              :country
end
 