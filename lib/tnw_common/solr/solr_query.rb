require 'rsolr'

# This class connects to solr and executes the query
# It uses default parameters, e.g. rows=10, if the parameters aren't passed to the method
module TnwCommon
    module Solr
        class SolrQuery
            #CONN = RSolr.connect :url => SOLR[Rails.env]['url']
            @@conn = RSolr.connect :url => 'http://localhost:8983/solr/archbishops'

            def self.query(q, fl='id', rows=10, sort='', start=0 )
                @@conn.get 'select', :params => {
                    :q=>q,
                    :fl=>fl,
                    :rows=>rows,
                    :sort=>sort,
                    :start=>start
                }
            end
        end
    end
end
