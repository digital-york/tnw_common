module TnwCommon
    module Shared
        class Constants
            FACET_REGISTER_OR_DEPARTMENT = "register_or_department_facet_ssim".freeze
            FACET_DATE = "date_facet_ssim".freeze
            FACET_SECTION_TYPE = "section_type_facet_ssim".freeze
            FACET_SUBJECT = "subject_facet_ssim".freeze
            FACET_PLACE_SAME_AS = "place_same_as_facet_ssim".freeze
            FACET_PERSON_SAME_AS = "person_same_as_facet_ssim".freeze

            FACETS = {
                FACET_REGISTER_OR_DEPARTMENT => "Register / Department",
                FACET_DATE => "Date",
                FACET_SECTION_TYPE => "Section Type",
                FACET_SUBJECT => "Subject",
                FACET_PLACE_SAME_AS => "Place",
                FACET_PERSON_SAME_AS => "Person or Group"
            }.freeze
        end
    end
end
