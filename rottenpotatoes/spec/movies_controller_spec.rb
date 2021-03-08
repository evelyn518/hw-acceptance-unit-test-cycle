require 'rails_helper'

describe Movie do
    it 'should find movies with the same director' do
        movie1 = Movie.create(title: 'Test1', director: 'Director 1')
        movie2 = Movie.create(title: 'Test2', director: 'Director 1')
        results = Movie.similar_movies(movie1.id)
        expect(results).to eq([movie1, movie2])
    end

    it 'should return nil when no director present ' do
        movie1 = Movie.create(title: 'Test 1')
        results = Movie.similar_movies(movie1.id)
        expect(results).to eq(nil)
    end
end

describe "#all_ratings" do 
    it 'should return array ["G", "PG", "PG-13", "NC-17", "R"]' do
      Movie.stub(:all_ratings).and_return(["G", "PG", "PG-13", "NC-17", "R"]) 
      expect(Movie.all_ratings).to eq(["G", "PG", "PG-13", "NC-17", "R"])
    end
end
RSpec.describe MoviesController, :type => :controller do



   describe 'UPDATE DIRECTOR' do

     it 'should call update_attributes and redirect' do
       mov1 = double("Movie", :title => 'Hunger Games', :director => 'Nora', :release_date => '1977-05-25', :rating => 'R', :description => 'test')
       allow(Movie).to receive(:find).with('21').and_return(mov1)
       expect(mov1).to receive(:update_attributes!).and_return(true)
       put :update, {:id => '21', :movie => {:title => 'Hunger Games', :director => 'Nora', :release_date => '1977-05-25', :rating => 'R', :description => 'test'}}
       #put :update, {:id => 21, :movie => mov1}
       expect(response).to redirect_to(movie_path(mov1))
     end
   end

   describe 'HOMEPAGE' do
     it 'render HOMEPAGE' do
       get :index
       expect(response).to render_template('index')
     end
   end

   describe 'CREATE/DELETE' do
     it 'DELETE' do
       movie2 = double('Movie', :title => 'Hunger Games 2', :director => 'Nora', :id => '21')
       allow(Movie).to receive(:find).with('23').and_return(movie2)
       expect(movie2).to receive(:destroy)
       delete :destroy, {:id => '23'}
     end
     it 'CREATE' do
       new_movie = double('Movie', :title => 'Hunger Games', :director => 'Nora', :release_date => '1977-05-25', :rating => 'R', :description => 'test')
       allow(Movie).to receive(:create!).and_return(new_movie)
       post :create, {:id => '21', :movie => {:title => 'Hunger Games', :director => 'Nora', :release_date => '1977-05-25', :rating => 'R', :description => 'test'}}
     end
    end
end