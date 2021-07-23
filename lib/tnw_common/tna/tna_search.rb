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

            # get department desc from id
            def get_department_desc(department_id)
                department_desc = ""
                return department_desc if department_id.nil?

                q = "id:#{department_id}"
                @solr_server.query(q,'id,description_tesim')['response']['docs'].map do |r|
                    if r['description_tesim']
                        department_desc = r['description_tesim'][0]
                    end
                end
                department_desc
            end

            # return department_label (will be used as facet label) from document_id
            def get_department_label(document_id)
                department_label = ""

                unless document_id.nil?
                    q = "has_model_ssim:Document AND id:#{document_id}"
                    @solr_server.query(q,'id,series_ssim')['response']['docs'].map do |r|
                        unless r['series_ssim'].nil?
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
                        # series.append([r['id'], r['preflabel_tesim'], r['description_tesim']])
                        series.append([r['preflabel_tesim'][0] + ' - ' + r['description_tesim'][0], r['id']])
                    end
                end
                # only order by the containing numbers in the series label
                series.sort_by {|s| s[0].scan(/\d+/)[0].to_i}
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

            # return document id/references from a series id, ordered by references
            def get_ordered_documents_from_series_in_year_group(series_id)
                return nil, nil if series_id.nil?

                all_documents = []
                documents_in_year_group = {}

                unless series_id.nil?
                    q = "has_model_ssim:Document AND series_ssim:#{series_id}"
                    @solr_server.query(q,'id,reference_tesim,date_facet_ssim')['response']['docs'].map do |r|
                        current_year = r['date_facet_ssim'][0]
                        current_documents = []
                        if documents_in_year_group[current_year].nil?
                            documents_in_year_group[current_year] = current_documents
                        else
                            current_documents = documents_in_year_group[current_year]
                        end
                        current_documents << {id: r['id'], year: current_year, reference: r['reference_tesim'][0]}
                        all_documents << {id: r['id'], year: current_year, reference: r['reference_tesim'][0]}
                    end
                end

                # If the reference is in format: C 81/1791/12
                unless documents_in_year_group.length()==0
                    documents_in_year_group.each do |year, documents|
                        if documents[0][:reference].split('/').length == 2
                            documents.sort_by! {|document| [document[:reference].split('/')[0], document[:reference].split('/')[1].to_i, document[:reference].split('/')[2]]}
                        else
                            documents.sort_by! { |document| [document[:reference]] }
                        end
                    end
                    if all_documents[0][:reference].split('/').length == 2
                        all_documents.sort_by! {|document| [document[:reference].split('/')[0], document[:reference].split('/')[1].to_i, document[:reference].split('/')[2]]}
                    else
                        all_documents.sort_by! { |document| [document[:reference]] }
                    end
                end
                #
                # if (not year.nil?) and (not documents_in_year_group[year].empty?)
                #     return documents_in_year_group[year]
                # else
                #     return documents_in_year_group.values[0] # return the first value by default
                # end

                return all_documents, documents_in_year_group

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
                q = "placeOfDatingFor_ssim:#{document_id}"
                fl = "id,place_same_as_facet_ssim,place_role_tesim,place_note_tesim,place_as_written_tesim"
                @solr_server.query(q,fl)['response']['docs'].map do |r|
                    place_of_datings << {
                        "place_same_as": r["place_same_as_facet_ssim"],
                        "place_role": r["place_role_tesim"],
                        "place_note": r["place_note_tesim"],
                        "place_as_written": r["place_as_written_tesim"]
                    }
                end

                place_of_datings
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

                places
            end

            # get Tna Addressees
            def get_tna_addressees(document_id)
                return nil if document_id.nil?

                addressees = []
                q = "addresseeFor_ssim:#{document_id}"
                fl = "id,person_as_written_tesim"
                @solr_server.query(q,fl)['response']['docs'].map do |r|
                    addressees << {
                        "person_as_written": r["person_as_written_tesim"]
                    }
                end

                addressees
            end

            # get Tna Senders
            def get_tna_senders(document_id)
                return nil if document_id.nil?

                senders = []
                q = "senderFor_ssim:#{document_id}"
                fl = "id,person_as_written_tesim"
                @solr_server.query(q,fl)['response']['docs'].map do |r|
                    senders << {
                        "person_as_written": r["person_as_written_tesim"]
                    }
                end

                senders
            end

            # get Tna Persons
            def get_tna_persons(document_id)
                return nil if document_id.nil?

                persons = []
                q = "personFor_ssim:#{document_id}"
                fl = "id,person_as_written_tesim"
                @solr_server.query(q,fl)['response']['docs'].map do |r|
                    persons << {
                        "person_as_written": r["person_as_written_tesim"]
                    }
                end

                persons
            end

            # get dates
            def get_dates(document_id)
                return nil if document_id.nil?

                dates = []
                # Step 1: find latest DocumentDate
                q = "documentDateFor_ssim:#{document_id}"
                fl = "id"
                document_date_id = ''
                @solr_server.query(q, fl, 1, 'system_modified_dtsi desc')['response']['docs'].map do |r|
                    document_date_id = r['id']
                end

                return [] if document_date_id==''

                # Step 2: find single dates linked to the DocumentDate found in step 1
                q2 = "dateFor_ssim:#{document_date_id}"
                fl2 = "id,date_tesim,date_certainty_tesim,date_type_tesim,date_facet_ssim"
                @solr_server.query(q2, fl2)['response']['docs'].map do |r|
                    dates << {
                        "date": r["date_tesim"],
                        "certainty": r["date_certainty_tesim"],
                        "type": r["date_type_tesim"],
                        "facet": r["date_facet_ssim"]
                    }
                end

                dates
            end
        end
    end
end
