require 'rails_helper'



RSpec.describe MoviesController, :type => :controller do



   describe 'UPDATE DIRECTOR' do

     it 'should call update_attributes and redirect' do
       mov1 = double("Movie", :title => 'tenant', :director => 'Nolan', :release_date => '2020-09-03', :rating => 'PG13', :description => 'test')
       allow(Movie).to receive(:find).with('21').and_return(mov1)
       expect(mov1).to receive(:update_attributes!).and_return(true)
       put :update, {:id => '21', :movie => {:title => 'tenant', :director => 'aa', :release_date => '2020-09-03', :rating => 'PG13', :description => 'test'}}
       #put :update, {:id => 21, :movie => mov1}
       expect(response).to redirect_to(movie_path(mov1))
       expect(mov1.director == 'aa')
     end
   end


   describe 'similar_method' do
     context 'when the specified movie has a director' do
       it 'pass similar movies to @movies' do
           movie2 = double('Movie', :title => 'Test2', :director => 'foo')
           movie3 = double('Movie', :title => 'Test3', :director => 'foo')
           allow(Movie).to receive(:similar_movies).with(10).and_return([movie2,movie3])
           allow(Movie).to receive(:find).with("10").and_return(movie2)
           put :find_similar_movies, {:id => 10}
           expect(assigns(:movies)).to contain_exactly(movie2,movie3)
           expect(assigns(:movie) == movie2)
           end
        end

    context 'when the specified movie has no director' do
       it 'pass nil to to @movies and redirect to homepage' do
           expect(Movie).to receive(:similar_movies).and_return(nil)
           expect(Movie).to receive(:find).and_return(nil)
           expect(@movie).to receive(:title).and_return("aa") 
           put :find_similar_movies, {:id => "111"}
           expect(assigns(:movies) == nil)
           expect(response).to redirect_to(root_path)
       end
    end
end
end