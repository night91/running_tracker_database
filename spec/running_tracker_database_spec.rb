require "spec_helper"

RSpec.describe RunningTrackerDatabase do
  it "has a version number" do
    expect(RunningTrackerDatabase::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
