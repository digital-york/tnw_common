require 'tnw_common/solr/solr_query'
require 'set'

# This class report duplicate places
module TnwCommon
    module Report
        class DuplicatePlaces
            def initialize(solr_url)
                @solr_url = solr_url
            end

            def report()
                solr_query = TnwCommon::Solr::SolrQuery.new(@solr_url)
                places = {}
                duplicates = {}
                response = solr_query.query("has_model_ssim:Place", 'id,place_name_tesim', 2147483647)
                response['response']['docs'].map do |p|
                    unless (p['place_name_tesim'].empty? or p['place_name_tesim'][0].nil?)
                        if places.keys.include? p['place_name_tesim'][0]
                            duplicates[p['place_name_tesim'][0]] = places[p['place_name_tesim'][0]]
                            duplicates[p['place_name_tesim'][0]] << p['id']
                        else
                            places[p['place_name_tesim'][0]] = [p['id']]
                        end
                    end
                end
                duplicates.sort.to_h
            end
        end
    end
end
