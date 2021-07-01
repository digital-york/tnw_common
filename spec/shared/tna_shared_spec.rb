require 'spec_helper'
require 'tnw_common'
require 'tnw_common/shared/Constants'

describe TnwCommon::Shared do

  it 'has FACETS defined' do
    expect(TnwCommon::Shared::Constants::FACET_REGISTER_OR_DEPARTMENT).to eq("register_or_department_facet_ssim")
    expect(TnwCommon::Shared::Constants::FACET_DATE).to eq("date_facet_ssim")
    expect(TnwCommon::Shared::Constants::FACET_SECTION_TYPE).to eq("section_type_facet_ssim")
    expect(TnwCommon::Shared::Constants::FACET_SUBJECT).to eq("subject_facet_ssim")
    expect(TnwCommon::Shared::Constants::FACET_PLACE_SAME_AS).to eq("place_same_as_facet_ssim")
    expect(TnwCommon::Shared::Constants::FACET_PERSON_SAME_AS).to eq("person_same_as_facet_ssim")
  end

  it 'has FACET LABELS defined' do
    expect(TnwCommon::Shared::Constants::FACETS[TnwCommon::Shared::Constants::FACET_REGISTER_OR_DEPARTMENT]).to eq("Register / Department")
    expect(TnwCommon::Shared::Constants::FACETS[TnwCommon::Shared::Constants::FACET_DATE]).to eq("Date")
    expect(TnwCommon::Shared::Constants::FACETS[TnwCommon::Shared::Constants::FACET_SECTION_TYPE]).to eq("Section Type")
    expect(TnwCommon::Shared::Constants::FACETS[TnwCommon::Shared::Constants::FACET_SUBJECT]).to eq("Subject")
    expect(TnwCommon::Shared::Constants::FACETS[TnwCommon::Shared::Constants::FACET_PLACE_SAME_AS]).to eq("Place")
    expect(TnwCommon::Shared::Constants::FACETS[TnwCommon::Shared::Constants::FACET_PERSON_SAME_AS]).to eq("Person or Group")
  end

end
