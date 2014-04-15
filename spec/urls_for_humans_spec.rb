require 'spec_helper'

describe UrlsForHumans do

  let(:first) { 'John' }
  let(:last)  { 'Doe'  }

  let(:user) { User.new(first, last) }

  subject { user }

  describe '.to_param' do

    it 'should return the correct string' do
      expect(subject.to_param).to eq("#{ user.id }-#{ user.first_name.parameterize }-#{ user.last_name.parameterize }")
    end

    context 'with no first name' do

      let(:user) { User.new(nil, last) }

      it 'should return the correct string' do
        expect(subject.to_param).to eq("#{ user.id }-#{ user.last_name.parameterize }")
      end
    end

    context 'with no last name' do

      let(:user) { User.new(first, nil) }

      it 'should return the correct string' do
        expect(subject.to_param).to eq("#{ user.id }-#{ user.first_name.parameterize }")
      end
    end

    context 'with no first or last name' do

      let(:user) { User.new(nil, nil) }

      it 'should return the correct string' do
        expect(subject.to_param).to eq(user.id.to_s)
      end
    end
  end

  describe '.urls_for_humans and @humanly_attrs' do

    let(:attrs) { [:fake, :attrs] }

    before { User.urls_for_humans(*attrs) }

    it 'should return the correct attributes' do
      expect(User.humanly_attrs).to eq(attrs)
    end
  end
end
