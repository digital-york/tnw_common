require "tnw_common/solr/solr_query"
require "pry"

# This class report duplicate places
module TnwCommon
  module Services
    module Solr
      def number
        5
      end

      # Sets the facet arrays and search results according to the search term
      def set_search_result_arrays(search_term: sub = nil)
        @section_type_facet_hash = Hash.new 0
        @person_same_as_facet_hash = Hash.new 0
        @place_same_as_facet_hash = Hash.new 0
        @subject_facet_hash = Hash.new 0
        @date_facet_hash = Hash.new 0
        @register_facet_hash = Hash.new 0

        entry_id_set = Set.new
        facets = facet_fields

        query = SolrQuery.new
        @query = SolrQuery.new

        search_term2 = if search_term.include?(" ") || search_term.include?("*")
          "(" + search_term.downcase + ")"
        else
          "(*" + search_term.downcase + "*)"
        end

        # ENTRIES: Get the matching entry ids and facets
        if (sub != "group") && (sub != "person") && (sub != "place")
          # if the search has come from the subjects browse, limit to searching for the subject
          q = if sub == "subject"
            "has_model_ssim:Entry AND subject_search:" + search_term2
          else
            # q = "has_model_ssim:Entry AND (entry_type_search:*#{search_term2}* or section_type_search:*#{search_term2}* or summary_search:*#{search_term2}* or marginalia_search:*#{search_term2}* or subject_search:*#{search_term2}* or language_search:*#{search_term2}* or note_search:*#{search_term2}* or editorial_note_search:*#{search_term2}* or is_referenced_by_search:*#{search_term2}*)"
            "has_model_ssim:Entry AND (entry_type_search:#{search_term2} or section_type_search:#{search_term2} or summary_search:#{search_term2} or marginalia_search:#{search_term2} or subject_search:#{search_term2} or language_search:#{search_term2} or note_search:#{search_term2} or editorial_note_search:#{search_term2} or is_referenced_by_search:#{search_term2} or summary_tesim:#{search_term2} or entry_person_same_as_facet_ssim:#{search_term2} or entry_place_same_as_facet_ssim:#{search_term2} or suggest:#{search_term2} )"
          end
          fq = filter_query
          num = count_query(q)
          unless num == 0
            # @query.solr_query(query, 'id', 0)['response']['numFound'].to_i
            q_result = query.solr_query(q, "id", num, "entry_date_facet_ssim asc", 0, true, -1, "index", facets, fq)
            facet_hash(q_result)
            entry_id_set.merge(q_result["response"]["docs"].map { |e| e["id"] })
          end
        end

        # Filter query for the entry (section types and subject facets), used when looping through the entries
        fq_entry = filter_query

        # PEOPLE/GROUPS: Get the matching entry ids and facets
        if (sub != "subject") && (sub != "place")
          # if the search has come from the people or group browse, limit to searching for group or person
          q = if (sub == "group") || (sub == "person")
            # q = 'has_model_ssim:RelatedAgent AND person_same_as_search:"' + @search_term.downcase + '"'
            "has_model_ssim:RelatedAgent AND person_same_as_search:" + search_term2
          else
            # q = "has_model_ssim:RelatedAgent AND (person_same_as_search:*#{search_term2}* or person_role_search:*#{search_term2}* or person_descriptor_search:*#{search_term2}* or person_descriptor_same_as_search:*#{search_term2}* or person_note_search:*#{search_term2}* or person_same_as_search:*#{search_term2}* or person_related_place_search:*#{search_term2}* or person_related_person_search:*#{search_term2}*)"
            "has_model_ssim:RelatedAgent AND (person_same_as_search:#{search_term2} or
                                                        person_role_search:#{search_term2} or
                                                        person_descriptor_search:#{search_term2} or
                                                        person_descriptor_same_as_search:#{search_term2} or
                                                        person_note_search:#{search_term2} or
                                                        person_same_as_search:#{search_term2} or
                                                        person_related_place_search:#{search_term2} or
                                                        person_related_person_search:#{search_term2})"
          end
          num = count_query(q)
          unless num == 0
            q_result = query.solr_query(q, "relatedAgentFor_ssim", num)
            q_result["response"]["docs"].map do |result|
              next if result.empty?

              result["relatedAgentFor_ssim"].each do |relatedagent|
                q_result2 = query.solr_query("id:#{relatedagent}", "id,has_model_ssim", 1, nil, 0, true, -1, "index", facets, fq_entry)
                q_result2["response"]["docs"].map do |entry|
                  next if q_result2["response"]["numFound"] == 0
                  # Check that the model is Entry
                  next if entry["has_model_ssim"] != ["Entry"]

                  unless entry_id_set.include? entry["id"]
                    add_facet_to_hash(q_result2)
                  end
                  entry_id_set << entry["id"]
                end
              end
            end
          end
        end

        # PLACE: Get the matching entry ids and facets
        if (sub != "group") && (sub != "person") && (sub != "subject")
          # if the search has come from the places browse, limit to searching for places
          q = if sub == "place"
            # q = 'has_model_ssim:RelatedPlace AND place_same_as_search:"' + @search_term.downcase + '"'
            "has_model_ssim:RelatedPlace AND place_same_as_search:" + search_term2
          else
            # q = "has_model_ssim:RelatedPlace AND (place_same_as_search:*#{search_term2}* or place_role_search:*#{search_term2}* or place_type_search:*#{search_term2}* or place_note_search:*#{search_term2}* or place_as_written_search:*#{search_term2}*)"
            "has_model_ssim:RelatedPlace AND (place_same_as_search:#{search_term2} or
                                                        place_role_search:#{search_term2} or
                                                        place_type_search:#{search_term2} or
                                                        place_note_search:#{search_term2} or
                                                        place_as_written_search:#{search_term2})"
          end
          facets = facet_fields
          num = count_query(q)
          unless num == 0
            q_result = query.solr_query(q, "relatedPlaceFor_ssim", num)
            unless q_result["response"]["docs"].nil?
              q_result["response"]["docs"].map do |result|
                id = ""
                id = result["relatedPlaceFor_ssim"][0] unless result["relatedPlaceFor_ssim"].nil?
                q_result2 = query.solr_query("id:#{id}", "id,has_model_ssim", 1, nil, 0, true, -1, "index", facets, fq_entry)
                q_result2["response"]["docs"].map do |entry|
                  next if q_result2["response"]["numFound"] == 0
                  # Check that the model is Entry
                  next if entry["has_model_ssim"] != ["Entry"]

                  unless entry_id_set.include? entry["id"]
                    add_facet_to_hash(q_result2)
                  end
                  entry_id_set << entry["id"]
                end
              end
            end
          end
        end

        # SINGLE DATES: Get the matching entry ids and facets
        if (sub != "group") && (sub != "person") && (sub != "subject") && (sub != "place")
          # q = "has_model_ssim:SingleDate AND date_tesim:*#{search_term2}*"
          q = "has_model_ssim:SingleDate AND date_tesim:#{search_term2}"
          facets = facet_fields
          num = count_query(q)
          unless num == 0
            q_result = query.solr_query(q, "dateFor_ssim", num)
            q_result["response"]["docs"].map do |res|
              next if res.empty?

              res["dateFor_ssim"].each do |single_date|
                # from the entry dates, get the entry ids
                query.solr_query("id:#{single_date}", "entryDateFor_ssim", num)["response"]["docs"].map do |result|
                  q_result2 = query.solr_query("id:#{result["entryDateFor_ssim"][0]}", "id", 1, nil, 0, true, -1, "index", facets, fq_entry)
                  unless q_result2["response"]["numFound"] == 0
                    unless entry_id_set.include? q_result2["response"]["docs"][0]["id"]
                      # add facets
                      add_facet_to_hash(q_result2)
                    end
                    entry_id_set << q_result2["response"]["docs"][0]["id"]
                  end
                  next if result.empty?
                end
              end
            end

            # ENTRY DATES: Get the matching entry ids (no facets needed for entry dates)
            q = "has_model_ssim:EntryDate AND (date_note_tesim:*#{search_term2}*"
            num = count_query(q)
            unless num == 0
              q_result = query.solr_query(q, "entryDateFor_ssim", num, nil, 0, nil, nil, nil, nil, fq_entry)
              entry_id_set.merge(q_result["response"]["docs"].map { |e| e["entryDateFor_ssim"][0] })
            end
          end
        end

        # Sort all of the hashes
        @section_type_facet_hash = @section_type_facet_hash.sort.to_h
        @person_same_as_facet_hash = @person_same_as_facet_hash.sort.to_h
        @place_same_as_facet_hash = @place_same_as_facet_hash.sort.to_h
        @subject_facet_hash = @subject_facet_hash.sort.to_h
        @date_facet_hash = @date_facet_hash.sort.to_h

        # sort by register number
        @register_facet_hash = @register_facet_hash.sort_by { |k, _| (k[9..10].to_i < 10 ? "0" + k[9..10] : k) }.to_h

        # This variable is used on the display page
        @number_of_rows = entry_id_set.size

        # Get the data for one page only, e.g. 10 rows
        entry_id_array = entry_id_set.to_a.slice((@page - 1) * @rows_per_page, @rows_per_page)

        # Iterate over the 10 (or less) entries and get all the data to display
        # Also highlight the search term
        entry_id_array.each do |entry_id|
          q = "id:#{entry_id}"

          fl = "entry_type_facet_ssim, section_type_facet_ssim, summary_tesim, marginalia_tesim, language_facet_ssim, subject_facet_ssim, note_tesim, editorial_note_tesim, is_referenced_by_tesim"

          query.solr_query(q, fl, 1)["response"]["docs"].map do |result|
            # Display all the text if not 'matched records'
            @match_term = @search_term
            if @match_term == "" || @display_type == "full display" || @display_type == "summary"
              @match_term = ".*"
            end

            # Build up the element_array with the entry_id, etc
            @element_array = []
            @element_array << entry_id
            get_entry_and_folio_details(entry_id)
            @element_array << get_element(result["entry_type_facet_ssim"])
            @element_array << get_element(result["section_type_facet_ssim"])
            @element_array << get_element(result["summary_tesim"])
            @element_array << get_element(result["marginalia_tesim"])
            @element_array << get_element(result["language_facet_ssim"])
            @element_array << get_element(result["subject_facet_ssim"])
            @element_array << get_element(result["note_tesim"])
            @element_array << get_element(result["editorial_note_tesim"])
            @element_array << get_element(result["is_referenced_by_tesim"])
            get_places(entry_id, search_term2)
            get_people(entry_id, search_term2)
            get_dates(entry_id, search_term2)
            @partial_list_array << @element_array
          end
        end
      rescue => error
        log_error(__method__, __FILE__, error)
        raise
      end
    end
  end
end
