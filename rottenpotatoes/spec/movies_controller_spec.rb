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


   describe 'WHEN DOCUMENT HAS A DIRECTOR' do
     it 'find similar_movies' do
       movie2 = double('Movie', :title => 'Test2', :director => 'foo')
       movie3 = double('Movie', :title => 'Test3', :director => 'foo')
       allow(Movie).to receive(:similar_movies).with(10).and_return([movie2,movie3])
       allow(Movie).to receive(:find).with("10").and_return(movie2)

       put :find_similar_movies, {:id => 10}
       expect(response==200)
       end
    end
    
    describe 'WHEN DOCUMENT HAS NO DIRECTOR' do
     it 'find similar_movies' do
       expect(Movie).to receive(:similar_movies).and_return(nil)
       expect(Movie).to receive(:find).and_return(nil)
       expect(@movie).to receive(:title).and_return("aa") 
       put :find_similar_movies, {:id => "111"}
       expect(response).to redirect_to(root_path)
       end

    
    end
end