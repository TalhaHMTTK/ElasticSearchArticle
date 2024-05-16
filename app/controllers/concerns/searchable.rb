module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
  
      mapping do
        indexes :title, type: 'text'
        indexes :description, type: 'text'
      end
  
      def self.search(query)
        # build and run search
        params = {
            query: {
              multi_match: {
                query: query,
                fields: ['title', 'content'],
                fuzziness: "AUTO"
              }
            }
          }
    
          self.__elasticsearch__.search(params).records.to_a
      end
    end
  end
  