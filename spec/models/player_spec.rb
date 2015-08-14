require 'spec_helper'

describe Player do
  context '#save' do 
    it 'should fail if first_name is too long' do
      FactoryGirl.build(:player, first_name: "a"*31).should_not be_valid
    end 

    it 'should fail if last_name is too long' do
      FactoryGirl.build(:player, last_name: "a"*31).should_not be_valid
    end

    it 'should fail if both first_name and last_name are blank' do
      FactoryGirl.build(:player, first_name: "", last_name: "" ).should_not be_valid
    end

    it 'should fail if sport is not in the validated list' do
      FactoryGirl.build(:player, sport: "cricket" ).should_not be_valid
    end

    it 'should fail if age is less than 0' do
      FactoryGirl.build(:player, age: -1 ).should_not be_valid
    end

    it 'should fail it age is more than 100' do
      FactoryGirl.build(:player, age: 101 ).should_not be_valid
    end

    it 'should fail if an invalid position is given' do
      FactoryGirl.build(:player, position: 'PS' ).should_not be_valid
    end

    it 'should pass if all fields are valid' do
      FactoryGirl.build(:player).should be_valid
    end

    context 'names' do
      it 'should capitalize first_name' do
        player = FactoryGirl.create(:player, first_name: 'test')
        player.first_name.should == 'Test'
      end

      it 'should capitalize last_name' do
        player = FactoryGirl.create(:player, last_name: 'name')
        player.last_name.should == 'Name'
      end

      context 'name_brief' do
        it 'should be first initial and last intial for baseball players' do
          player = Player.create(first_name: 'test', last_name: 'name', sport: 'baseball')
          player.name_brief.should == "T. N."
        end

        it 'should be first name and last intial for basketball players' do
          player = Player.create(first_name: 'test', last_name: 'name', sport: 'basketball')
          player.name_brief.should == "Test N."
        end

        it 'should be first initial and last name for football players' do
          player = Player.create(first_name: 'test', last_name: 'name', sport: 'football')
          player.name_brief.should == "T. Name"
        end
      end
    end
  end

  context 'formatted_avg_pos_age_diff' do
    before :each do 
      @player = Player.new(first_name: 'test', sport: 'baseball', age: 20)
    end

    it 'should return avg_pos_age_diff with a `+` sign if positive' do
      @player.avg_pos_age_diff = 1
      @player.save!

      @player.formatted_avg_pos_age_diff.should == '+1'
    end

    it 'should return avg_pos_age_diff with a `-` sign if negative' do
      @player.avg_pos_age_diff = -1
      @player.save!

      @player.formatted_avg_pos_age_diff.should == '-1'
    end

    it 'should return avg_pos_age_diff as an empty string if age is not present' do
      @player.age = nil
      @player.save!

      @player.formatted_avg_pos_age_diff.should == ''
    end
  end

end
