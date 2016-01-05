# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Link do
  it "is valid with a name and url" do
    expect(build(:link)).to be_valid
  end
  it "is invalid without a name" do
    expect(build(:link, name: nil)).to have(1).errors_on(:name)
  end
  it "is invalid without a url" do
    expect(build(:link, url: nil)).to have(1).errors_on(:url)
  end
end
