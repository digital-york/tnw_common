require 'spec_helper'
require 'tnw_common'
require 'tnw_common/version'

describe TnwCommon do
  it 'has a version number' do
    expect(TnwCommon::VERSION).not_to be nil
  end
end
