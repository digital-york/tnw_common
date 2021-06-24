module TnwCommon
    module Tna
        # This is a class to search TNA solr data
        # Usage:
        # solr_server = TnwCommon::Solr::SolrQuery.new('http://localhost:8983/solr/archbishops')
        # tna_search = TnwCommon::Tna::TnaSearch.new(solr_server)
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

            # return document id/references from a series id, ordered by references
            def get_ordered_documents_from_series(series_id)
                documents = []

                unless series_id.nil?
                    q = "has_model_ssim:Document AND series_ssim:#{series_id}"
                    @solr_server.query(q,'id,reference_tesim')['response']['docs'].map do |r|
                        documents << {id: r['id'], reference: r['reference_tesim'][0]}
                    end
                end
                documents.sort! { |a, b|  a[1].to_i <=> b[1].to_i }

                documents = documents.sort_by {|document| [document[:reference].split('/')[1].to_i, document[:reference].split('/')[2]]}
            end

            # return document json from a document id
            def get_document_json(document_id)
                document_json = ''

                unless document_id.nil?
                    q = "id:#{document_id}"
                    fl = "id,repository_tesim,series_ssim,reference_tesim,summary_tesim,entry_date_note_tesim"
                    fl += ",note_tesim,document_type_tesim,language_tesim,place_same_as_facet_ssim"
                    fl += ",tna_addressees_tesim,tna_senders_tesim,tna_persons_tesim,first_date_full_ssim"
                    @solr_server.query(q,fl)['response']['docs'].map do |r|
                        document_json = r
                    end
                end

                document_json
            end
        end
    end
end
