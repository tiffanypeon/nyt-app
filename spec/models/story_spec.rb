require 'rails_helper'

RSpec.describe Story do
  it { should respond_to :headline }
  it { should respond_to :byline }
  it { should respond_to :url }
  it { should respond_to :summary }
  it { should respond_to :image }
  it { should respond_to :last_published }

end
