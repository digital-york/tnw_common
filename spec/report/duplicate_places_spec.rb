require 'spec_helper'
require 'tnw_common'
require 'tnw_common/report/duplicate_places'

describe TnwCommon::Report do
  dp = TnwCommon::Report::DuplicatePlaces.new('http://localhost:8983/solr/archbishops')
  it 'has a report method' do
    duplicates = dp.report()
    expect(duplicates.keys.length).to be >= 0

    # duplicates.each do |k, v|
    #   puts k + ' >> ' + v.to_s
    # end
    # puts "Total: " + duplicates.keys.length.to_s
  end
end
