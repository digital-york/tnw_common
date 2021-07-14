module TnwCommon
    module Shared
        class Constants
            # facets in format:
            # FACET_ID = SOLR_FIELD
            FACET_REGISTER_OR_DEPARTMENT = "register_or_department_facet_ssim".freeze
            FACET_DATE = "date_facet_ssim".freeze
            FACET_SECTION_TYPE = "section_type_facet_ssim".freeze
            FACET_SUBJECT = "subject_facet_ssim".freeze
            FACET_PLACE_SAME_AS = "place_same_as_facet_ssim".freeze
            FACET_PERSON_SAME_AS = "person_same_as_facet_ssim".freeze

            # FACET_ID => FACET Label
            FACETS = {
                FACET_REGISTER_OR_DEPARTMENT => "Register / Department",
                FACET_DATE => "Date",
                FACET_SECTION_TYPE => "Section Type",
                FACET_SUBJECT => "Subject",
                FACET_PLACE_SAME_AS => "Place",
                FACET_PERSON_SAME_AS => "Person or Group"
            }.freeze

            # Common Solr fields for both AR and TNA
            SOLR_FILED_COMMON_DATE_FULL = "date_full_ssim".freeze
            SOLR_FILED_COMMON_DATE_SHORT = "date_facet_ssim".freeze
            SOLR_FILED_COMMON_LANGUAGE_FACET = "language_facet_ssim".freeze
            SOLR_FILED_COMMON_LANGUAGE_SEARCH = "language_search".freeze
            SOLR_FILED_COMMON_NOTE = "note_search".freeze
            SOLR_FILED_COMMON_PLACE_AS_WRITTEN = "place_as_written_tesim".freeze
            SOLR_FILED_COMMON_PLACE_SAME_AS = "place_same_as_tesim".freeze
            SOLR_FILED_COMMON_PLACE_SAME_AS_SEARCH = "place_same_as_search".freeze
            SOLR_FILED_COMMON_REPOSITORY = "repository_tesim".freeze
            SOLR_FILED_COMMON_SUBJECT_SEARCH = "subject_search".freeze
            SOLR_FILED_COMMON_SUMMARY = "summary_search".freeze
            # SOLR_FILED_COMMON_ = "".freeze

            # Solr fields for TNA only
            SOLR_FILED_TNA_ADDRESSEES = "tna_addressees_tesim".freeze
            SOLR_FILED_TNA_DOCUMENT_TYPE = "document_type_facet_ssim".freeze
            SOLR_FILED_TNA_PERSONS = "tna_persons_tesim".freeze
            SOLR_FILED_TNA_PUBLICATION = "publication_tesim".freeze
            SOLR_FILED_TNA_REFERENCE = "reference_tesim".freeze
            SOLR_FILED_TNA_SENDERS = "tna_senders_tesim".freeze
            # SOLR_FILED_TNA_ = "".freeze

            # Solr fields for AR only
            # SOLR_FILED_BIA_ = "".freeze
        end
    end
end
