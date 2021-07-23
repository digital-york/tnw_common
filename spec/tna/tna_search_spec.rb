require 'spec_helper'
require 'tnw_common'
require 'tnw_common/solr/solr_query'
require 'tnw_common/tna/tna_search'

describe TnwCommon::Tna::TnaSearch do
  solr_server = TnwCommon::Solr::SolrQuery.new('http://localhost:8983/solr/archbishops')
  tna_search = TnwCommon::Tna::TnaSearch.new(solr_server)

  #get_all_departments
  it 'has a get_all_departments method' do
    departments = tna_search.get_all_departments()
    # puts departments
    expect(departments.length()).to be_positive
  end

  # get_department_desc
  it 'has a get_department_desc method' do
    # desc = tna_search.get_department_desc('6108vp64c')
    # puts desc
    desc = tna_search.get_department_desc(nil)
    expect(desc).to eq('')
  end

  it 'has a get_document_ids_from_series method' do
    # document_ids = tna_search.get_document_ids_from_series('1257b485h')
    document_ids = tna_search.get_document_ids_from_series(nil)
    expect(document_ids.length()).to eq(0)
  end

  # get_all_series
  it 'has a get_all_series method' do
    # series = tna_search.get_all_series('6108vp64c')
    # puts series
    series = tna_search.get_all_series(nil)
    expect(series.length()).to eq(0)
  end

  it 'has a get_document_json method' do
    # document_json = tna_search.get_document_json('gf06gf08h')
    document_json = tna_search.get_document_json(nil)
    expect(document_json).to eq('')
  end

  # get_ordered_documents_from_series
  it 'has a get_ordered_documents_from_series method' do
    # documents = tna_search.get_ordered_documents_from_series('1257b485h')
    documents = tna_search.get_ordered_documents_from_series(nil)
    expect(documents.length()).to eq(0)
  end

  # get_ordered_documents_from_series_in_year_group
  it 'has a get_ordered_documents_from_series_in_year_group method' do
    # all_documents, document_hash = tna_search.get_ordered_documents_from_series_in_year_group('1257b485h')
    # puts all_documents
    all_documents, document_hash = tna_search.get_ordered_documents_from_series_in_year_group(nil)
    expect(all_documents).to eq(nil)
    expect(document_hash).to eq(nil)
  end

  # get_department_label
  it 'has a get_department_label method' do
    # department_label = tna_search.get_department_label('dn39xd05s')
    # expect(department_label).to eq('Chancery')
    department_label = tna_search.get_department_label(nil)
    expect(department_label).to eq('')
  end

  # get_place_of_dating
  it 'has a get_place_of_dating method' do
    # place_of_datings = tna_search.get_place_of_dating('dn39xd05s')
    # puts place_of_datings
    place_of_datings = tna_search.get_place_of_datings(nil)
    expect(place_of_datings).to eq(nil)
  end

  # get_tna_places
  it 'has a get_tna_places method' do
    # places = tna_search.get_tna_places('dn39xd05s')
    # puts places
    places = tna_search.get_tna_places(nil)
    expect(places).to eq(nil)
  end

  # get_tna_addressees
  it 'has a get_tna_addressees method' do
    # places = tna_search.get_tna_addressees('dn39xd05s')
    # puts addressees
    addressees = tna_search.get_tna_addressees(nil)
    expect(addressees).to eq(nil)
  end

  # get_tna_senders
  it 'has a get_tna_senders method' do
    # senders = tna_search.get_tna_senders('dn39xd05s')
    # puts senders
    senders = tna_search.get_tna_senders(nil)
    expect(senders).to eq(nil)
  end

  # get_tna_persons
  it 'has a get_tna_persons method' do
    # persons = tna_search.get_tna_persons('dn39xd05s')
    # puts persons
    persons = tna_search.get_tna_persons(nil)
    expect(persons).to eq(nil)
  end

  # get_dates
  it 'has a get_dates method' do
    # dates = tna_search.get_dates('dn39xd05s')
    # puts dates
    dates = tna_search.get_dates(nil)
    expect(dates).to eq(nil)
  end
end
