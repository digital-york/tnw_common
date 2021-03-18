require 'rsolr'

# This class connects to solr and executes the query
# It uses default parameters, e.g. rows=10, if the parameters aren't passed to the method
module TnwCommon
    module Solr
        class SolrQuery
            def initialize(solr_url)
                @conn = RSolr.connect :url => solr_url
            end

            def query(q, fl='id', rows=10, sort='', start=0 )
                @conn.get 'select', :params => {
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
