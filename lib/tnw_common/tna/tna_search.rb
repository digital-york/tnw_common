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

            # return all departments as Hash (department_id => department_label)
            def get_all_departments()
                departments = Hash.new
                q = "has_model_ssim:Department"
                @solr_server.query(q,'id,description_tesim')['response']['docs'].map do |r|
                    if r['id'] and r['description_tesim']
                        departments[r['id']] = [r['description_tesim'][0]]
                    end
                end
                departments.sort_by {|k, v| v}.to_h
            end


            # return department_label (will be used as facet label) from document_id
            def get_department_label(document_id)
                department_label = ""

                unless document_id.nil?
                    q = "has_model_ssim:Document AND id:#{document_id}"
                    @solr_server.query(q,'id,series_ssim')['response']['docs'].map do |r|
                        series_id = r['series_ssim'].length()==0?'' : r['series_ssim'][0]
                        unless series_id == ''
                            q2 = "has_model_ssim:Series AND id:#{series_id}"
                            @solr_server.query(q2,'id,isPartOf_ssim')['response']['docs'].map do |r2|
                                department_id = r2['isPartOf_ssim'][0]
                                unless department_id == ''
                                    q3 = "has_model_ssim:Department AND id:#{department_id}"
                                    @solr_server.query(q3,'id,description_tesim')['response']['docs'].map do |r3|
                                        department_label = r3['description_tesim'][0]
                                    end
                                end
                            end
                        end
                    end
                end

                department_label
            end

            # return all series as array
            # e.g.
            # [
            # ["5x21ts254", "C85", "Significations of Excommunication"],
            # ["tx31qw845", "C49", "Parliamentary and Council Proceedings"],
            # ]
            def get_all_series(department_id)
                series = []
                return series if department_id.nil?

                q = "isPartOf_ssim:#{department_id}"
                @solr_server.query(q,'id,preflabel_tesim,description_tesim')['response']['docs'].map do |r|
                    if r['id'] and r['preflabel_tesim'] and r['description_tesim']
                        series.append([r['id'], r['preflabel_tesim'], r['description_tesim']])
                    end
                end
                series.sort_by {|s| s[1]}
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

                # If the reference is in format: C 81/1791/12
                unless documents.length()==0
                    if documents[0][:reference].split('/').length == 2
                        documents = documents.sort_by {|document| [document[:reference].split('/')[0], document[:reference].split('/')[1].to_i, document[:reference].split('/')[2]]}
                    else
                        documents = documents.sort_by { |document| [document[:reference]] }
                    end
                end
                documents
            end

            # return document json from a document id
            def get_document_json(document_id)
                document_json = ''

                unless document_id.nil?
                    q = "id:#{document_id}"
                    fl = "*"
                    @solr_server.query(q,fl)['response']['docs'].map do |r|
                        document_json = r
                    end
                end

                document_json
            end

            # get Place of Datings
            def get_place_of_datings(document_id)
                return nil if document_id.nil?

                place_of_datings = []
                q = "PlaceofDatingFor_ssim:#{document_id}"
                fl = "id,place_same_as_facet_ssim,place_role_tesim,place_note_tesim,place_as_written_tesim"
                @solr_server.query(q,fl)['response']['docs'].map do |r|
                    place_of_datings << {
                        "place_same_as": r["place_same_as_facet_ssim"],
                        "place_role": r["place_role_tesim"],
                        "place_note": r["place_note_tesim"],
                        "place_as_written": r["place_as_written_tesim"]
                    }
                end

                place_of_datings.to_json
            end

            # get Tna Places
            def get_tna_places(document_id)
                return nil if document_id.nil?

                places = []
                q = "tnaPlaceFor_ssim:#{document_id}"
                fl = "id,place_same_as_facet_ssim,place_role_tesim,place_note_tesim,place_as_written_tesim"
                @solr_server.query(q,fl)['response']['docs'].map do |r|
                    places << {
                        "place_same_as": r["place_same_as_facet_ssim"],
                        "place_role": r["place_role_tesim"],
                        "place_note": r["place_note_tesim"],
                        "place_as_written": r["place_as_written_tesim"]
                    }
                end

                places.to_json
            end
        end
    end
end
