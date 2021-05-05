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
            def solr_query(q, fl='id', rows=0, sort='', start=0,facet=false,limit=nil,f_sort=nil,field=nil, fq=nil)
                @conn.get 'select', :params => {
                                     :q=>q,
                                     :fl=>fl,
                                     :rows=>rows,
                                     :sort=>sort,
                                     :start=>start,
                                     :facet=>facet,
                                     'facet.limit'=>limit,
                                     'facet.sort'=>f_sort,
                                     'facet.field'=>field, #supply a string or an array
                                    :fq=>fq #supply a string or an array
                                 }
              end
        end
    end
end
