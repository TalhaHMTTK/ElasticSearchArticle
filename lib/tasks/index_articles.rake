namespace :elasticsearch do
    desc "Index articles into Elasticsearch"
    task index_articles: :environment do
      Article.find_each do |article|
        article.__elasticsearch__.index_document
      end
    end
  end