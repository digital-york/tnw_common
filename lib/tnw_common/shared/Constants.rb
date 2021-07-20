module TnwCommon
    module Shared
        class Constants
            # facets in format:
            # FACET_ID = SOLR_FIELD
            FACET_DATE = "date_facet_ssim".freeze
            FACET_ENTRY_TYPE = "entry_type_facet_ssim".freeze ## This facet isn't used in the UI
            FACET_LANGUAGE = "language_facet_ssim".freeze  ## This facet isn't used in the UI
            FACET_PERSON_SAME_AS = "person_same_as_facet_ssim".freeze
            FACET_PLACE_SAME_AS = "place_same_as_facet_ssim".freeze
            FACET_REGISTER_OR_DEPARTMENT = "register_or_department_facet_ssim".freeze
            FACET_SECTION_TYPE = "section_type_facet_ssim".freeze
            FACET_SUBJECT = "subject_facet_ssim".freeze

            # FACET_ID => FACET Label
            FACETS = {
                FACET_REGISTER_OR_DEPARTMENT => "Register / Department",
                FACET_DATE => "Date",
                FACET_LANGUAGE => "Language",
                FACET_PERSON_SAME_AS => "Person or Group",
                FACET_PLACE_SAME_AS => "Place",
                FACET_SECTION_TYPE => "Section Type",
                FACET_SUBJECT => "Subject"
            }.freeze

            # Common Solr fields for both AR and TNA
            SOLR_FILED_COMMON_DATE_ALL_SSIM = "date_ssim".freeze # save all full dates into this field
            SOLR_FILED_COMMON_DATE_FULL_SSIM = "date_full_ssim".freeze # save the first date into this field as it's used for ordering
            SOLR_FIELD_COMMON_ENTRY_DATE_NOTE_TESIM = "entry_date_note_tesim".freeze
            SOLR_FIELD_COMMON_ENTRY_TYPE_SEARCH = "entry_type_search".freeze
            SOLR_FILED_COMMON_LANGUAGE_SEARCH = "language_search".freeze
            SOLR_FILED_COMMON_NOTE_SEARCH = "note_search".freeze
            SOLR_FILED_COMMON_NOTE_TESIM = "note_tesim".freeze
            SOLR_FILED_COMMON_PLACE_AS_WRITTEN_TESIM = "place_as_written_tesim".freeze
            SOLR_FILED_COMMON_PLACE_SAME_AS_SEARCH = "place_same_as_search".freeze
            SOLR_FILED_COMMON_REPOSITORY_TESIM = "repository_tesim".freeze
            SOLR_FILED_COMMON_SUBJECT_SEARCH = "subject_search".freeze
            SOLR_FILED_COMMON_SUMMARY_SEARCH = "summary_search".freeze
            SOLR_FILED_COMMON_SUMMARY_TESIM = "summary_tesim".freeze
            # SOLR_FILED_COMMON_ = "".freeze

            # Solr fields for TNA only
            SOLR_FILED_TNA_ADDRESSEES_TESIM = "tna_addressees_tesim".freeze
            SOLR_FILED_TNA_DOCUMENT_TYPE_TESIM = "document_type_tesim".freeze
            SOLR_FILED_TNA_PERSONS_TESIM = "tna_persons_tesim".freeze
            SOLR_FILED_TNA_PUBLICATION_TESIM = "publication_tesim".freeze
            SOLR_FILED_TNA_REFERENCE_TESIM = "reference_tesim".freeze
            SOLR_FILED_TNA_SENDERS_TESIM = "tna_senders_tesim".freeze
            # SOLR_FILED_TNA_ = "".freeze

            # Solr fields for AR only
            # SOLR_FILED_BIA_ = "".freeze
        end
    end
end
