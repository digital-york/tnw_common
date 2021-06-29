require 'spec_helper'
require 'tnw_common'
require 'tnw_common/solr/solr_query'
require 'tnw_common/tna/tna_search'

describe TnwCommon::Tna::TnaSearch do
  solr_server = TnwCommon::Solr::SolrQuery.new('http://localhost:8983/solr/archbishops')
  tna_search = TnwCommon::Tna::TnaSearch.new(solr_server)

  it 'has a get_document_ids_from_series method' do
    # document_ids = tna_search.get_document_ids_from_series('1257b485h')
    document_ids = tna_search.get_document_ids_from_series(nil)
    expect(document_ids.length()).to eq(0)
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

  # get_department_label
  it 'has a get_department_label method' do
    # department_label = tna_search.get_department_label('dn39xd05s')
    # expect(department_label).to eq('Chancery')
    department_label = tna_search.get_department_label(nil)
    expect(department_label).to eq('')
  end
end
