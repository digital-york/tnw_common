module TnwCommon
    module Solr
        module Tna
            # This is a class to search TNA solr data
            # Usage:
            # solr_server = TnwCommon::Solr::SolrQuery.new('http://localhost:8983/solr/archbishops')
            # tna_search = TnwCommon::Solr::Tna::TnaSearch.new(solr_server)
            # tna_search.get_document_ids_from_series('1257b485h')
            class TnaSearch
                def initialize(solr_server)
                    @solr_server = solr_server
                end

                # return document ids from a series id
                def get_document_ids_from_series(series_id)
                    document_ids = []

                    unless series_id.nil?
                        q = "has_model_ssim:Document AND series_ssim:#{series_id}"
                        @solr_server.query(q)['response']['docs'].map do |r|
                            document_ids << r['id']
                        end
                    end

                    document_ids
                end
            end
        end
    end
end
