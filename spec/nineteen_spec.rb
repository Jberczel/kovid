# frozen_string_literal: true

RSpec.describe Kovid::Nineteen do
  describe 'whatis' do
    it 'defines COVID-19' do
      text = 'Coronavirus disease 2019 (COVID-19) is an infectious disease caused by severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2).'

      expect(Kovid::Nineteen.whatis).to eq(text)
    end
  end

  describe 'country(name)' do
    let(:country) { 'ghana' }
    let(:no_country) { 'wonderland' }
    it 'returns table with country data' do
      table = Kovid::Nineteen.country(country)

      expect(table.title).to eq('Ghana')
    end

    it 'raise a JSON::ParseError when country specified has no reported case' do
      table = Kovid::Nineteen.country(no_country)
      good_news = "Thankfully, there are no reported cases in Wonderland!"

      expect(table.rows.first.cells.first.value).to eq(good_news)
    end
  end

  describe 'country_full(name)' do
    let(:country) { 'italy' }
    let(:no_country) { 'wonderland' }

    it 'returns table with country data' do
      table = Kovid::Nineteen.country_full(country)

      expect(table.title).to eq('Italy')
    end

    it 'raise a JSON::ParseError when country specified has no reported case' do
      table = Kovid::Nineteen.country_full(no_country)
      good_news = "Thankfully, there are no reported cases in Wonderland!"

      expect(table.rows.first.cells.first.value).to eq(good_news)
    end
  end

  describe 'country_comparison(names_array)' do
    let(:country) { %w[ghana poland] }
    it 'returns table with country data' do
      table = Kovid::Nineteen.country_comparison(country)

      expect(table.headings.first.cells.last.value).to eq('Recovered')
      expect(table.headings.first.cells.first.value).to eq('Country')
    end
  end

  describe 'country_comparison_full(names_array)' do
    let(:country) { %w[ghana poland] }
    it 'returns table with country data' do
      table = Kovid::Nineteen.country_comparison_full(country)

      expect(table.headings.first.cells.first.value).to eq('Country')
      expect(table.headings.first.cells.last.value).to eq('Cases/Million')
    end
  end

  describe 'cases' do
    it 'returns summary of cases' do
      table = Kovid::Nineteen.cases

      expect(table.headings.first.cells.first.value).to eq('Cases')
      expect(table.headings.first.cells.last.value).to eq('Recoveries')
    end
  end
end